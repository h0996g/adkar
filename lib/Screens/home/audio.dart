import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Audio extends StatefulWidget {
  const Audio({super.key});

  @override
  State<Audio> createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  bool isCompleted = false;
  final audioPlay = AudioPlayer();
  bool isplaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlay.onPlayerStateChanged.listen((event) {
      setState(() {
        isplaying = event == PlayerState.playing;
      });
    });
    audioPlay.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
      audioPlay.onPositionChanged.listen((event) {
        setState(() {
          position = event;
        });
      });
    });
    audioPlay.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.completed) {
        isCompleted = true;
      } else {
        isCompleted = false;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    audioPlay.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'أَفَلا يَتَدَبَّرُونَ الْقُرْآنَ وَلَوْ كَانَ مِنْ عِنْدِ غَيْرِ اللَّهِ لَوَجَدُوا فِيهِ اخْتِلافًا كَثِيرًا',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w600,
            color: Colors.red.shade400,
          ),
        ),
        Row(
          children: [
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
                    String url = '';
                    int randomAya = Random().nextInt(144);
                    print(randomAya);
                    await FirebaseFirestore.instance
                        .collection('quran')
                        .doc('$randomAya')
                        .get()
                        .then((value) {
                      url = value['link'];
                    });
                    // String url =
                    //     'https://firebasestorage.googleapis.com/v0/b/quran-28f24.appspot.com/o/quran%2Fal_qurani8-20230827-0012.mp3?alt=media&token=84d7f44c-f8c1-4d65-bbb8-91462f30cfc0';
                    await audioPlay.play(UrlSource(url));
                  }
                }),
            Expanded(
              child: Slider(
                  // mouseCursor: MouseCursor.defer,
                  secondaryActiveColor: Colors.grey,
                  inactiveColor: Colors.grey.shade300,
                  activeColor: Colors.brown,
                  value: position.inSeconds.toDouble(),
                  max: duration.inSeconds.toDouble(),
                  onChanged: (onChanged) async {
                    final position = Duration(seconds: onChanged.toInt());
                    await audioPlay.seek(position);
                    // play audio if was paused
                    await audioPlay.resume();
                  }),
            ),
          ],
        ),
      ],
    );
  }
}
