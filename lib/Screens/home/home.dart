import 'package:adkar/Screens/Adkar/adkar_home.dart';
import 'package:adkar/Screens/NamesOfAllah/names_of_allah.dart';
import 'package:adkar/Screens/settings/settings.dart';
import 'package:adkar/shared/components/audio.dart';
import 'package:adkar/Screens/home/suggest.dart';
import 'package:adkar/shared/components/tasbih.dart';
import 'package:adkar/Screens/quran/homequran.dart';
import 'package:adkar/shared/components/components.dart';
import 'package:adkar/shared/components/functions.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../shared/helper/constant.dart';

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
    if (isFirstTimeAdkarCH) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => ShowCaseWidget.of(context).startShowCase([
          globalKeyOne,
          globalKeyTwo,
        ]),
      );
    }
    super.initState();

    // Noti.initialize();

    // Noti.init();
    listenNotification(context);
    checkUpdate(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'حصن المسلم',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                navigatAndReturn(context: context, page: const Setting());
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: SingleChildScrollView(
          // controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: size.height / 5.5,
                width: double.infinity,
                // color: Colors.amber,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/1.jpg"),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(
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
                              context: context, page: const QuranHomeScreen());
                        },
                        child: Row(
                          children: [
                            Image.asset("assets/images/iconquran.png",
                                height: 35),
                            const SizedBox(
                              width: 3,
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
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
                          navigatAndReturn(
                              context: context, page: const AdkarHome());
                        },
                        child: Row(
                          children: [
                            Image.asset("assets/images/open-hands.png",
                                height: 35),
                            const SizedBox(
                              width: 3,
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
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
              const SizedBox(
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
                          navigatAndReturn(
                              context: context, page: const Suggest());
                        },
                        child: Row(
                          children: [
                            Image.asset("assets/images/suggestion.png",
                                height: 35),
                            const SizedBox(
                              width: 3,
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
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
                              context: context, page: const NamesOfAllah());
                        },
                        child: Row(
                          children: [
                            Image.asset("assets/images/names.png", height: 35),
                            const SizedBox(
                              width: 3,
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
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
              const SizedBox(
                height: 10,
              ),
              Tasbih(globalKey: globalKeyOne),
              const SizedBox(
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
