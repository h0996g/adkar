import 'package:adkar/Screens/Adkar/Adkarhome.dart';
import 'package:adkar/Screens/Adkar/adkarDetails.dart';
import 'package:adkar/Screens/Adkar/cubit/ahadith_cubit.dart';
import 'package:adkar/Screens/home/audio.dart';
import 'package:adkar/Screens/quran/homequran.dart';
import 'package:adkar/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../notification.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _counter = 0;
  int _index = 0;
  List<String> tasbih = [
    'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
    'سُبْحَانَ اللَّه الْعَظِيم'
  ];
  void _incrementCounter() {
    setState(() {
      if (_counter >= 0.9) {
        _counter = 0.0;
        _index = _index == 0 ? 1 : 0;
        return;
      }
      _counter = _counter + 0.1;
    });
  }

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('حصن المسلم'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: 180,
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
                          Image.asset("assets/images/iconquran.png",
                              height: 35),
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
                          Image.asset("assets/images/open-hands.png",
                              height: 35),
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
              SizedBox(
                height: 50,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade50,
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade500,
                          offset: Offset(4.0, 4.0),
                          blurRadius: 15,
                          spreadRadius: 1),
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4.0, -4.0),
                          blurRadius: 15,
                          spreadRadius: 1.0)
                    ]),
                padding: EdgeInsetsDirectional.symmetric(vertical: 5),
                width: size.width * 0.8,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'حلقة التسبيح  ',
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        _incrementCounter();
                        print(_counter);
                      },
                      child: CircularPercentIndicator(
                        animation: true,
                        animateFromLastPercent: true,
                        circularStrokeCap: CircularStrokeCap.round,
                        curve: Curves.easeInQuad,
                        addAutomaticKeepAlive: true,
                        radius: 100.0,
                        animationDuration: 250,

                        lineWidth: 20.0,
                        percent: _counter,
                        center: new Text(
                          '${tasbih[_index]}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              shadows: [
                                Shadow(
                                  color: Colors.grey,
                                  blurRadius: 6,
                                )
                              ]),
                        ),
                        progressColor: Color.fromARGB(255, 83, 34, 8),
                        backgroundColor: Color.fromARGB(47, 83, 34, 8),

                        // progressColor: Colors.yellow,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${(_counter * 10).round()}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    )
                  ],
                ),
              ), // Text("\uFD3E" + replaceFarsiNumber("2") + "\uFD3F")
              SizedBox(
                height: 10,
              ),
              Text(
                'أَفَلا يَتَدَبَّرُونَ الْقُرْآنَ وَلَوْ كَانَ مِنْ عِنْدِ غَيْرِ اللَّهِ لَوَجَدُوا فِيهِ اخْتِلافًا كَثِيرًا',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: Colors.red.shade400,
                ),
              ),
              Audio()
            ],
          ),
        ),
      ),
    );
  }
}
