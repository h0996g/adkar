import 'dart:math';
import 'package:adkar/shared/components/show_case_widget.dart';
import 'package:just_audio/just_audio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AudioAdkar extends StatefulWidget {
  const AudioAdkar({super.key, required this.globalKey});
  final GlobalKey globalKey;
  @override
  State<AudioAdkar> createState() => _AudioAdkarState();
}

class _AudioAdkarState extends State<AudioAdkar> {
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
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
            style: TextStyle(color: Colors.black, fontSize: 12.sp),
          ),
          Text(
            formatTime(duration),
            style: TextStyle(color: Colors.black, fontSize: 12.sp),
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
        activeColor: Colors.black,
        inactiveColor: Colors.grey.shade300,
      ),
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildControlButton(Icons.skip_next, _playPreviousAya),
        SizedBox(width: 16.w),
        _buildPlayPauseButton(),
        SizedBox(width: 16.w),
        _buildControlButton(Icons.skip_previous, _playNextAya),
        SizedBox(width: 16.w),
        _buildRepeatButton(),
      ],
    );
  }

  Widget _buildControlButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildPlayPauseButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        shape: BoxShape.circle,
      ),
      child: Transform.rotate(
        angle: 180 * pi / 180,
        child: IconButton(
          icon: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.black,
          ),
          iconSize: 36.sp,
          onPressed: _playPause,
        ),
      ),
    );
  }

  Widget _buildRepeatButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(Icons.replay, color: Colors.black),
        onPressed: _restartAudio,
      ),
    );
  }

  Future<void> _restartAudio() async {
    await _audioPlayer.seek(Duration.zero);
    await _audioPlayer.play();
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
}
