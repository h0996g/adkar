import 'package:adkar/shared/components/show_case_widget.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:adkar/shared/helper/cash_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Tasbih extends StatefulWidget {
  const Tasbih({super.key, required this.globalKey});
  final GlobalKey globalKey;

  @override
  State<Tasbih> createState() => _TasbihState();
}

class _TasbihState extends State<Tasbih> with SingleTickerProviderStateMixin {
  final items = ['10', '33', '100'];
  String? value = CachHelper.getData(key: 'nOfTasbih') ?? '33';
  double _counter = 0;
  int index = 0;

  int _indexTasbih = 0;
  String? selectTasbih = CachHelper.getData(key: 'selectTasbih') ?? "1";
  List<String> tasbih = [
    'سُبْحَانَ اللَّهِ\n وَبِحَمْدِهِ',
    'سُبْحَانَ اللَّه\n الْعَظِيم'
  ];
  List<String> tasbih2 = [
    'سُبْحَانَ اللَّهِ ',
    'الْحَمْدُ لِلَّهِ',
    'لا إِلَهَ إِلا اللَّهُ',
    'اللَّهُ أَكْبَر'
  ];

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      if (_counter >= 0.98) {
        _counter = 0.0;
        index = 0;
        _indexTasbih = selectTasbih == "1"
            ? (_indexTasbih == 0 ? 1 : 0)
            : (_indexTasbih + 1) % tasbih2.length;
        return;
      }
      index++;
      _counter = _counter + (1 / int.parse(value!));
    });
    _animationController.forward().then((_) => _animationController.reverse());
  }

  void _showTasbihSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('اختر نوع التسبيح',
              style: TextStyle(color: Colors.brown[800])),
          backgroundColor: Colors.brown[50],
          children: <Widget>[
            ListTile(
              title: Text(
                  'سُبْحَانَ اللَّه الْعَظِيم, سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
                  style: TextStyle(color: Colors.brown[700])),
              onTap: () {
                setState(() {
                  selectTasbih = "1";
                  CachHelper.putcache(key: 'selectTasbih', value: selectTasbih);
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text(
                  'سُبْحَانَ اللَّهِ, الْحَمْدُ لِلَّهِ, لا إِلَهَ إِلا اللَّهُ, اللَّهُ أَكْبَر',
                  style: TextStyle(color: Colors.brown[700])),
              onTap: () {
                setState(() {
                  selectTasbih = "2";
                  CachHelper.putcache(key: 'selectTasbih', value: selectTasbih);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.brown.shade50, Colors.brown.shade100],
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
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'حلقة التسبيح',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800],
                  ),
                ),
                ShowCaseView(
                  description: 'افتح القائمة واختر عدد تكرار التسبيح',
                  globalKey: widget.globalKey,
                  title: 'عدد تكرار التسبيح',
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: BoxDecoration(
                      color: Colors.brown[50],
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: DropdownButton<String>(
                      value: value,
                      underline: const SizedBox(),
                      icon:
                          Icon(Icons.arrow_drop_down, color: Colors.brown[700]),
                      dropdownColor: Colors.brown[50],
                      items: items.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item,
                              style: TextStyle(
                                  color: Colors.brown[700], fontSize: 16.sp)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          value = newValue;
                          CachHelper.putcache(key: 'nOfTasbih', value: value);
                          _counter = 0.0;
                          index = 0;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: _incrementCounter,
              onLongPress: () => _showTasbihSelectionDialog(context),
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularPercentIndicator(
                          radius: 120.r,
                          lineWidth: 18.w,
                          percent: _counter,
                          progressColor: Colors.brown[600],
                          backgroundColor: Colors.brown[100]!,
                          circularStrokeCap: CircularStrokeCap.round,
                          animation: true,
                          animateFromLastPercent: true,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              selectTasbih == "1"
                                  ? tasbih[_indexTasbih]
                                  : tasbih2[_indexTasbih],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown[800],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              '$index / ${value!}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.sp,
                                color: Colors.brown[800],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
