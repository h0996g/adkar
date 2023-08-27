import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AudioQuran extends StatefulWidget {
  final String url;
  const AudioQuran({super.key, required this.url});

  @override
  State<AudioQuran> createState() => _AudioQuranState();
}

class _AudioQuranState extends State<AudioQuran> {
  bool isCompleted = false;
  final audioPlay = AudioPlayer();
  bool isplaying = false;
  // String url = '';

  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // audioPlay.onPlayerStateChanged.listen((event) {
    //   setState(() {
    //     isplaying = event == PlayerState.playing;
    //   });
    // });
    // audioPlay.onDurationChanged.listen((event) {
    //   setState(() {
    //     duration = event;
    //   });
    //   audioPlay.onPositionChanged.listen((event) {
    //     setState(() {
    //       position = event;
    //     });
    //   });
    // });
    // audioPlay.onPlayerStateChanged.listen((event) {
    //   if (event == PlayerState.completed) {
    //     isCompleted = true;
    //   } else {
    //     isCompleted = false;
    //   }
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    audioPlay.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              audioPlay.seek(Duration.zero);
              audioPlay.play(UrlSource(widget.url));
            });
          },
          icon: Icon(Icons.replay,
              color: isCompleted == true
                  ? Colors.brown.shade400
                  : Colors.transparent),
          iconSize: 50,
        ),
        IconButton(
            icon: Icon(
              isplaying
                  ? Icons.pause
                  : isCompleted
                      ? Icons.skip_next
                      : Icons.play_arrow,
              color: Colors.brown.shade400,
            ),
            iconSize: 50,
            onPressed: () async {
              if (isplaying) {
                await audioPlay.pause();
              } else {
                await audioPlay.play(UrlSource(widget.url));
              }
            }),
        Expanded(
          child: Slider(
              secondaryActiveColor: Colors.grey,
              inactiveColor: Colors.grey.shade300,
              activeColor: Colors.brown,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (onChanged) async {
                final position = Duration(seconds: onChanged.toInt());
                await audioPlay.seek(position);
                // play audio if was paused
                await audioPlay.resume();
              }),
        ),
      ],
    );
  }
}
