import 'dart:async';
import 'dart:io';

import 'package:adkar/shared/helper/cash_helper.dart';
import 'package:adkar/shared/components/show_case_widget.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Tasbih extends StatefulWidget {
  const Tasbih({super.key, required this.globalKey});
  final GlobalKey globalKey;
  @override
  State<Tasbih> createState() => _TasbihState();
}

class _TasbihState extends State<Tasbih> {
  final items = ['10', '33', '100'];
  String? value = CachHelper.getData(key: 'nOfTasbih') ?? '10';
  double _counter = 0;
  int index = 0;

  int _indexTasbih = 0;
  List<String> tasbih = [
    'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
    'سُبْحَانَ اللَّه الْعَظِيم'
  ];
  void _incrementCounter() {
    setState(() {
      if (_counter >= 0.98) {
        _counter = 0.0;
        index = 0;
        _indexTasbih = _indexTasbih == 0 ? 1 : 0;
        return;
      }
      index++;
      _counter = _counter + (1 / int.parse(value!));
      if (_counter >= 0.98) {
        Future.delayed(const Duration(milliseconds: 700), () {
          if (_counter >= 0.98) {
            setState(() {
              _counter = 0.0;
              index = 0;
              _indexTasbih = _indexTasbih == 0 ? 1 : 0;
              return;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade50,
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade500,
                offset: const Offset(4.0, 4.0),
                blurRadius: 15,
                spreadRadius: 1),
            const BoxShadow(
                color: Colors.white,
                offset: Offset(-4.0, -4.0),
                blurRadius: 15,
                spreadRadius: 1.0)
          ]),
      padding: const EdgeInsetsDirectional.symmetric(vertical: 5),
      width: size.width * 0.8,
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.rtl,
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
              const Spacer(),
              ShowCaseView(
                description: 'افتح القائمة واختر عدد تكرار التسبيح',
                globalKey: widget.globalKey,
                title: 'عدد تكرار التسبيح',
                child: DropdownButton(
                  iconSize: 0,
                  value: value,
                  items: items.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() {
                    this.value = value;
                    CachHelper.putcache(key: 'nOfTasbih', value: this.value);
                    _counter = 0.0;
                    index = 0;
                  }),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              _incrementCounter();
              print(value);
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
              center: Text(
                tasbih[_indexTasbih],
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    shadows: [
                      Shadow(
                        color: Colors.grey,
                        blurRadius: 6,
                      )
                    ]),
              ),
              progressColor: const Color.fromARGB(255, 83, 34, 8),
              backgroundColor: const Color.fromARGB(47, 83, 34, 8),

              // progressColor: Colors.yellow,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '$index',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          )
        ],
      ),
    ); // Text("\uFD3E" + replaceFarsiNumber("2") + "\uFD3F")
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
}
