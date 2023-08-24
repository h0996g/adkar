import 'package:adkar/Screens/Adkar/Adkarhome.dart';
import 'package:adkar/Screens/Adkar/adkarDetails.dart';
import 'package:adkar/Screens/Adkar/cubit/ahadith_cubit.dart';
import 'package:adkar/Screens/quran/homequran.dart';
import 'package:adkar/shared/components/components.dart';
import 'package:flutter/material.dart';

import '../../notification.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Noti.initialize();
    // Noti.initialize();

    Noti.init();
    listenNotification();
  }

  void listenNotification() => Noti.onNotification.stream.listen((event) async {
        if (event == 'adkarSabah') {
          await AhadithCubit.get(context).getSectionDetails(context, 1);
          navigatAndReturn(
              context: context,
              page: AdkarDetails(
                title: 'اذكار الصباح',
              ));
        } else if (event == "adkarMasa1") {
          await AhadithCubit.get(context).getSectionDetails(context, 2);
          navigatAndReturn(
              context: context,
              page: AdkarDetails(
                title: 'اذكار المساء',
              ));
        }
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Noti.showNotification(
            title: 'title',
            body: 'bodyyyy',
            fln: Noti.flutterLocalNotificationsPlugin,
            payload: "adkarSabah");
      }),
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                Noti.cancel(0);
                print('f');
              },
              child: Text(
                'fdfdf',
                style: TextStyle(color: Colors.white),
              ))
        ],
        backgroundColor: Colors.black,
        title: Text('حصن المسلم'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              // color: Colors.amber,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/1.jpg"),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  // width: width,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      navigatAndReturn(
                          context: context, page: QuranHomeScreen());
                    },
                    child: Row(
                      children: [
                        Image.asset("assets/images/iconquran.png", height: 35),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          // isUpperCase ? text.toUpperCase() : text,
                          "القران الكريم",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  // width: width,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      navigatAndReturn(context: context, page: AdkarHome());
                    },
                    child: Row(
                      children: [
                        Image.asset("assets/images/open-hands.png", height: 35),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          "اذكار المسلم",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Text("\uFD3E" + replaceFarsiNumber("2") + "\uFD3F")
            MaterialButton(
              onPressed: () {
                Noti.showTimeNotificationDaily(
                    payload: 'adkarMasa1',
                    title: 'adkarMasa1',
                    body: 'adkarMasa1',
                    // scheduleDate: DateTime.now().add(Duration(seconds: 10)),
                    time: TimeOfDay(hour: 15, minute: 17),
                    fln: Noti.flutterLocalNotificationsPlugin);
              },
              child: Icon(
                Icons.abc,
                size: 80,
              ),
            )
          ],
        ),
      ),
    );
  }
}
