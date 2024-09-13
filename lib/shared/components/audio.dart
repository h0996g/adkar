import 'dart:io';
import 'dart:math';
import 'package:adkar/shared/components/show_case_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:just_audio/just_audio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class Audio extends StatefulWidget {
  const Audio({super.key, required this.globalKey});
  final GlobalKey globalKey;
  @override
  State<Audio> createState() => _AudioState();
}

class _AudioState extends State<Audio> with SingleTickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String url = '';

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  List<int> audioHistory = [];
  int currentAudioIndex = -1;

  @override
  void initState() {
    super.initState();
    _audioPlayer.playerStateStream.listen((state) {
      if (mounted) {
        setState(() {
          isPlaying = state.playing;
        });
      }
    });
    _audioPlayer.durationStream.listen((d) {
      if (mounted && d != null) {
        setState(() {
          duration = d;
        });
      }
    });
    _audioPlayer.positionStream.listen((p) {
      if (mounted) {
        setState(() {
          position = p;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseView(
      description: '',
      globalKey: widget.globalKey,
      title: 'تشغيل قراءات مختلفة لايات مختلفة ',
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.brown.shade50, Colors.brown.shade100],
          ),
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildTimeDisplay(),
            _buildProgressBar(),
            SizedBox(height: 8.h),
            _buildControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeDisplay() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            formatTime(position),
            style: TextStyle(color: Colors.brown.shade700, fontSize: 12.sp),
          ),
          Text(
            formatTime(duration),
            style: TextStyle(color: Colors.brown.shade700, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.r),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 12.r),
        trackHeight: 4.h,
      ),
      child: Slider(
        value: position.inSeconds.toDouble(),
        max: duration.inSeconds.toDouble(),
        onChanged: (value) async {
          final newPosition = Duration(seconds: value.toInt());
          await _audioPlayer.seek(newPosition);
        },
        activeColor: Colors.brown.shade600,
        inactiveColor: Colors.brown.shade200,
      ),
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildControlButton(Icons.skip_next, _playPreviousAya),
        _buildPlayPauseButton(),
        _buildControlButton(Icons.skip_previous, _playNextAya),
        _buildControlButton(Icons.replay, _restartCurrentAudio),
        _buildControlButton(Icons.share, _shareAudio),
      ],
    );
  }

  Widget _buildControlButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(
        icon,
        color: Colors.brown.shade700,
        size: 30,
      ),
      onPressed: onPressed,
    );
  }

  Widget _buildPlayPauseButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.brown.shade200,
        shape: BoxShape.circle,
      ),
      child: Transform.rotate(
        angle: 180 * pi / 180,
        child: IconButton(
          icon: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.brown.shade800,
            size: 36.sp,
          ),
          iconSize: 36.sp,
          onPressed: _playPause,
        ),
      ),
    );
  }

  Future<void> _playAya(int ayaId) async {
    await FirebaseFirestore.instance
        .collection('quran')
        .doc('$ayaId')
        .get()
        .then((value) {
      url = value['link'];
    });
    await _audioPlayer.setUrl(url);
    await _audioPlayer.play();
  }

  Future<void> _playNextAya() async {
    int nextAyaId;
    if (currentAudioIndex < audioHistory.length - 1) {
      currentAudioIndex++;
      nextAyaId = audioHistory[currentAudioIndex];
    } else {
      nextAyaId = Random().nextInt(370);
      audioHistory.add(nextAyaId);
      currentAudioIndex = audioHistory.length - 1;
    }
    await _playAya(nextAyaId);
  }

  Future<void> _playPreviousAya() async {
    if (currentAudioIndex > 0) {
      currentAudioIndex--;
      int previousAyaId = audioHistory[currentAudioIndex];
      await _playAya(previousAyaId);
    }
  }

  Future<void> _playPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      if (url.isEmpty) {
        await _playNextAya();
      } else {
        await _audioPlayer.play();
      }
    }
  }

  Future<void> _restartCurrentAudio() async {
    await _audioPlayer.seek(Duration.zero);
    await _audioPlayer.play();
  }

  Future<void> _shareAudio() async {
    if (url.isNotEmpty) {
      try {
        // Show loading indicator
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Preparing audio for sharing...')),
        );

        // Get the Firebase Storage reference from the URL
        final ref = FirebaseStorage.instance.refFromURL(url);

        // Get temporary directory
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/shared_audio.mp3');

        // Download to temporary file
        await ref.writeToFile(file);

        // Share the file
        final result = await Share.shareXFiles([XFile(file.path)],
            text: 'Check out this audio!');

        if (result.status == ShareResultStatus.success) {
          print('Thank you for sharing the audio!');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sharing audio: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No audio to share')),
      );
    }
  }
}
