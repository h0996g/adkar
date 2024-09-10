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

  @override
  void initState() {
    super.initState();
    _audioPlayer.setUrl(widget.url);
    _audioPlayer.playerStateStream.listen((state) {
      if (mounted) {
        setState(() {
          isPlaying = state.playing;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
      onPressed: () async {
        if (isPlaying) {
          await _audioPlayer.pause();
        } else {
          await _audioPlayer.play();
        }
      },
    );
  }

  Widget _buildReplayButton() {
    return IconButton(
      onPressed: () {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.play();
      },
      icon: Icon(
        Icons.replay,
        color: isPlaying ? Colors.brown.shade400 : Colors.transparent,
      ),
      iconSize: 50,
    );
  }
}
