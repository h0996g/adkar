import 'package:adkar/shared/components/show_case_widget.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';

class AudioQuran extends StatefulWidget {
  final String url;
  final GlobalKey globalKey;
  final int index;
  const AudioQuran({
    super.key,
    required this.url,
    required this.globalKey,
    required this.index,
  });

  @override
  State<AudioQuran> createState() => _AudioQuranState();
}

class _AudioQuranState extends State<AudioQuran> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.index == 0
            ? ShowCaseView(
                description: '',
                globalKey: widget.globalKey,
                title: 'سماع قراءة الاية',
                child: _buildPlayPauseButton(),
              )
            : _buildPlayPauseButton(),
        _buildReplayButton(),
      ],
    );
  }

  Widget _buildPlayPauseButton() {
    return IconButton(
      icon: Icon(
        isPlaying ? Icons.pause : Icons.play_arrow,
        color: Colors.brown.shade400,
      ),
      iconSize: 50,
      onPressed: _playPause,
    );
  }

  Widget _buildReplayButton() {
    return IconButton(
      onPressed: _restartCurrentAudio,
      icon: Icon(
        Icons.replay,
        color: isPlaying ? Colors.brown.shade400 : Colors.transparent,
      ),
      iconSize: 50,
    );
  }

  Future<void> _playPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.setUrl(widget.url);
      await _audioPlayer.play();
    }
  }

  Future<void> _restartCurrentAudio() async {
    await _audioPlayer.seek(Duration.zero);
    await _audioPlayer.play();
  }
}
