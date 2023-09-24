import 'package:adkar/Screens/Adkar/Adkarhome.dart';
import 'package:adkar/Screens/Adkar/adkarDetails.dart';
import 'package:adkar/Screens/Adkar/cubit/ahadith_cubit.dart';
import 'package:adkar/Screens/NamesOfAllah/namesOfAllah.dart';
import 'package:adkar/Screens/home/audio.dart';
import 'package:adkar/Screens/home/suggest.dart';
import 'package:adkar/Screens/home/tasbih.dart';
import 'package:adkar/Screens/quran/homequran.dart';
import 'package:adkar/shared/components/components.dart';
import 'package:adkar/shared/components/constant.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../notification.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey globalKeyOne = GlobalKey();
  final GlobalKey globalKeyTwo = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState

    if (isFirstTimeAdkar)
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => ShowCaseWidget.of(context).startShowCase([
          globalKeyOne,
          globalKeyTwo,
        ]),
      );
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
              page: ShowCaseWidget(
                builder: Builder(
                  builder: (context) => AdkarDetails(
                    title: 'اذكار الصباح',
                  ),
                ),
              ));
        } else if (event == "adkarMasa1") {
          await AhadithCubit.get(context).getSectionDetails(context, 2);
          navigatAndReturn(
              context: context,
              page: ShowCaseWidget(
                builder: Builder(
                    builder: ((context) => AdkarDetails(
                          title: 'اذكار المساء',
                        ))),
              ));
        }
      });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'حصن المسلم',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: SingleChildScrollView(
          // controller: _scrollController,
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: size.height / 5.5,
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
                  Expanded(
                    child: Container(
                      // width: size.width ,
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
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  reverse: true,
                                  child: Text(
                                      // isUpperCase ? text.toUpperCase() : text,
                                      "القران الكريم",
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.01,
                  ),
                  Expanded(
                    child: Container(
                      // width: size.width * 0.4,
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
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  reverse: true,
                                  child: Text("اذكار المسلم",
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      // width: width,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          navigatAndReturn(context: context, page: Suggest());
                        },
                        child: Row(
                          children: [
                            Image.asset("assets/images/suggestion.png",
                                height: 35),
                            SizedBox(
                              width: 3,
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  reverse: true,
                                  child: Text(
                                      textDirection: TextDirection.rtl,
                                      // isUpperCase ? text.toUpperCase() : text,
                                      "ابلاغ او اقتراح",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.01,
                  ),
                  Expanded(
                    child: Container(
                      // width: width,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          navigatAndReturn(
                              context: context, page: NamesOfAllah());
                        },
                        child: Row(
                          children: [
                            Image.asset("assets/images/names.png", height: 35),
                            SizedBox(
                              width: 3,
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  reverse: true,
                                  child: Text('أسماء ٱللَّه الحسنى',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Tasbih(globalKey: globalKeyOne),
              SizedBox(
                height: 10,
              ),
              Text(
                  'أَفَلا يَتَدَبَّرُونَ الْقُرْآنَ وَلَوْ كَانَ مِنْ عِنْدِ غَيْرِ اللَّهِ لَوَجَدُوا فِيهِ اخْتِلافًا كَثِيرًا',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall),
              Audio(
                globalKey: globalKeyTwo,
              )
            ],
          ),
        ),
      ),
    );
  }
}
