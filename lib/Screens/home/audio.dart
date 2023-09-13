import 'dart:math';

import 'package:adkar/shared/components/show_case_widget.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Audio extends StatefulWidget {
  Audio({super.key, required this.globalKey});
  final GlobalKey globalKey;
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
    return ShowCaseView(
      description: '',
      globalKey: widget.globalKey,
      title: 'تشغيل قراءات مختلفة لايات مختلفة ',
      child: Row(
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
                    int randomAya = Random().nextInt(224);
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
                // max: duration.inSeconds.toDouble(),
                max: duration.inSeconds.toDouble() + 1.0,
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
    );
  }
}
