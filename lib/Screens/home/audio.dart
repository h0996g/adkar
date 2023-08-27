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
  String url = '';

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
              onPressed: () {
                setState(() {
                  audioPlay.seek(Duration.zero);
                  audioPlay.play(UrlSource(url));
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
                    // 3la kima yji y3awed myzidch yjib mn firebase
                    if (isCompleted || url == '') {
                      int randomAya = Random().nextInt(144);
                      print(randomAya);
                      await FirebaseFirestore.instance
                          .collection('quran')
                          .doc('$randomAya')
                          .get()
                          .then((value) {
                        url = value['link'];
                      });
                    }

                    await audioPlay.play(UrlSource(url));
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
        ),
      ],
    );
  }
}
