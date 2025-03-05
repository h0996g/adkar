import 'package:adkar/shared/components/functions.dart';
import 'package:adkar/shared/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:adkar/Screens/Adkar/adkar_home.dart';
import 'package:adkar/Screens/NamesOfAllah/names_of_allah.dart';
import 'package:adkar/Screens/quran/homequran.dart';
import 'package:adkar/Screens/settings/settings.dart';
import 'package:adkar/Screens/home/suggest.dart';
import 'package:adkar/shared/components/tasbih.dart';
import 'package:adkar/shared/components/audio.dart';
import 'package:showcaseview/showcaseview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey globalKeyOne = GlobalKey();
  final GlobalKey globalKeyTwo = GlobalKey();
  final List<Map<String, dynamic>> _menuItems = [
    {
      'title': 'اذكار المسلم',
      'icon': 'assets/images/open-hands.png',
      'page': const AdkarHome(),
    },
    {
      'title': 'القران الكريم',
      'icon': 'assets/images/iconquran.png',
      'page': const QuranHomeScreen(),
    },
    {
      'title': 'أسماء ٱللَّه الحسنى',
      'icon': 'assets/images/names.png',
      'page': const NamesOfAllah(),
    },
    {
      'title': 'ابلاغ او اقتراح',
      'icon': 'assets/images/suggestion.png',
      'page': const Suggest(),
    },
  ];
  @override
  void initState() {
    if (isFirstTimeAdkarCH) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => ShowCaseWidget.of(context).startShowCase([
          globalKeyOne,
          globalKeyTwo,
        ]),
      );

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
    listenNotification(context);
    checkUpdate(context);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(),
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'حصن المسلم',
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.settings, color: Colors.white, size: 24.sp),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Setting()),
          ),
        ),
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.brown.shade700, Colors.brown.shade500],
          ),
        ),
      ),
      elevation: 0,
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.brown.shade50, Colors.white],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildMenuGrid(),
            SizedBox(height: 20.h),
            _buildTasbihSection(),
            SizedBox(height: 20.h),
            _buildQuranVerse(),
            SizedBox(height: 20.h),
            _buildAudioPlayer(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuGrid() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
        ),
        itemCount: _menuItems.length,
        itemBuilder: (context, index) {
          return _buildMenuItem(_menuItems[index]);
        },
      ),
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => item['page']),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.brown.shade100, Colors.brown.shade50],
          ),
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(item['icon'], height: 50.h),
            SizedBox(height: 10.h),
            Text(
              item['title'],
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade800,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTasbihSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Tasbih(globalKey: globalKeyOne),
    );
  }

  Widget _buildQuranVerse() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.brown.shade100, Colors.brown.shade50],
        ),
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'أَفَلا يَتَدَبَّرُونَ الْقُرْآنَ وَلَوْ كَانَ مِنْ عِنْدِ غَيْرِ اللَّهِ لَوَجَدُوا فِيهِ اخْتِلافًا كَثِيرًا',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade700,
              height: 1.5,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'سورة النساء - آية 82',
            style: TextStyle(
              fontSize: 14.sp,
              fontStyle: FontStyle.italic,
              color: Colors.brown.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioPlayer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Audio(globalKey: globalKeyTwo),
    );
  }
}
