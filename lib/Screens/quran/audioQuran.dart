import 'package:adkar/shared/components/show_case_widget.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioQuran extends StatefulWidget {
  final String url;
  final GlobalKey globalKey;
  // index bh global key yndar ghir la lawla f liste View
  final int index;
  const AudioQuran(
      {super.key,
      required this.url,
      required this.globalKey,
      required this.index});

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

    audioPlay.onPlayerStateChanged.listen((event) {
      if (this.mounted) {
        setState(() {
          isplaying = event == PlayerState.playing;
        });
      }
    });

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
        widget.index == 0
            ? ShowCaseView(
                description: '',
                globalKey: widget.globalKey,
                title: 'سماع قراءة الاية',
                child: IconButton(
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
              )
            : IconButton(
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
      ],
    );
  }
}
