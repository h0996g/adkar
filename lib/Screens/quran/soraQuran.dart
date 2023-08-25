import 'package:adkar/Screens/quran/cubit/quran_cubit.dart';
import 'package:flutter/material.dart';

import '../../shared/components/helper/constant.dart';

class SoraQuran extends StatelessWidget {
  final int index;
  const SoraQuran({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    List<TextSpan> a = [];
    QuranCubit.get(context).dataQuranDetails![index].array.forEach((element) {
      print(element.ar);
      a.add(TextSpan(
          text:
              "${element.ar} \uFD3F${replaceFarsiNumber(element.id.toString())}\uFD3E ",
          style: TextStyle(color: Colors.black, fontSize: 30)));
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          QuranCubit.get(context).dataQuranDetails![index].name!,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            child: RichText(
              textDirection: TextDirection.rtl,
              text: TextSpan(children: a),
            ),
          ),
        ),
      ),
    );
  }
}
