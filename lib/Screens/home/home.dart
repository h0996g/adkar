import 'package:adkar/Screens/Adkar/adkar_home.dart';
import 'package:adkar/Screens/NamesOfAllah/names_of_allah.dart';
import 'package:adkar/Screens/home/suggest.dart';
import 'package:adkar/Screens/settings/settings.dart';
import 'package:adkar/shared/components/audio.dart';
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
        title: const Text(
          'حصن المسلم',
        ),
        actions: [setting(context)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: SingleChildScrollView(
          // controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              item(context, "assets/images/open-hands.png", "اذكار المسلم",
                  const AdkarHome()),
              const SizedBox(
                height: 10,
              ),
              item(context, "assets/images/iconquran.png", "القران الكريم",
                  const QuranHomeScreen()),
              const SizedBox(
                height: 10,
              ),
              item(context, "assets/images/names.png", "أسماء ٱللَّه الحسنى",
                  const NamesOfAllah()),
              const SizedBox(
                height: 10,
              ),
              item(context, "assets/images/suggestion.png", "ابلاغ او اقتراح",
                  const Suggest()),
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

  IconButton setting(BuildContext context) {
    return IconButton(
        onPressed: () {
          navigatAndReturn(context: context, page: const Setting());
        },
        icon: const Icon(
          Icons.settings,
        ));
  }

  Container item(
      BuildContext context, String urlIcon, String title, Widget page) {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        color: Colors.grey[800],
      ),
      child: MaterialButton(
        onPressed: () {
          navigatAndReturn(context: context, page: page);
        },
        child: Row(
          children: [
            Image.asset(urlIcon, height: 35),
            const Spacer(),
            Text(
                // isUpperCase ? text.toUpperCase() : text,
                title,
                maxLines: 1,
                style: Theme.of(context).textTheme.displayMedium),
          ],
        ),
      ),
    );
  }
}
