import 'package:adkar/Screens/quran/audioQuran.dart';
import 'package:adkar/Screens/quran/cubit/quran_cubit.dart';
import 'package:flutter/material.dart';

import '../../shared/components/helper/constant.dart';

class SoraQuran extends StatelessWidget {
  final int index;
  const SoraQuran({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    List<Widget> ayahs = [];
    // List<TextSpan> a = [];
    QuranCubit.get(context).dataQuranApi![index].ayahs.forEach((element) {
      ayahs.add(
        Column(
          children: [
            Text(
              textDirection: TextDirection.rtl,
              "${element.text}\uFD3F${replaceFarsiNumber(element.numberInSurah.toString())}\uFD3E",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w700),
            ),
            AudioQuran(url: element.audio!)
          ],
        ),
      );
      // print(element.ar);
      // a.add(TextSpan(
      //     text:
      //         "${element.text} \uFD3F${replaceFarsiNumber(element.numberInSurah.toString())}\uFD3E ",
      //     style: TextStyle(color: Colors.black, fontSize: 30)));
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          QuranCubit.get(context).dataQuranApi![index].name!,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Center(
          child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: ayahs,
              )
              // RichText(
              //   textDirection: TextDirection.rtl,
              //   text: TextSpan(children: a),
              // ),
              ),
        ),
      ),
    );
  }
}
