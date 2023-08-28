import 'package:adkar/Screens/quran/audioQuran.dart';
import 'package:adkar/Screens/quran/cubit/quran_cubit.dart';
import 'package:adkar/models/quranApi.dart';
import 'package:flutter/material.dart';

import '../../shared/components/helper/constant.dart';

class SoraQuran extends StatelessWidget {
  final int id;
  const SoraQuran({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    // List<Widget> ayahs = [];
    // Column k = Column(
    //   children: [],
    // );
    // // List<TextSpan> a = [];
    // QuranCubit.get(context).dataQuranApi![index].ayahs.forEach((element) {
    //   // ayahs.add(
    //   //   Column(
    //   //     children: [
    //   //       Text(
    //   //         textDirection: TextDirection.rtl,
    //   //         "${element.text}\uFD3F${replaceFarsiNumber(element.numberInSurah.toString())}\uFD3E",
    //   //         style: TextStyle(
    //   //             color: Colors.black,
    //   //             fontSize: 30,
    //   //             fontWeight: FontWeight.w700),
    //   //       ),
    //   //       Row(
    //   //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   //         children: [
    //   //           AudioQuran(url: element.audio!),
    //   //           IconButton(
    //   //               onPressed: () {
    //   //                 QuranCubit.get(context)
    //   //                     .tafsirAya(
    //   //                         sura_number: index + 1,
    //   //                         ayah_number: element.numberInSurah!)
    //   //                     .then((value) {
    //   //                   showModalBottomSheet(
    //   //                     context: context,
    //   //                     builder: (context) => Padding(
    //   //                       padding: const EdgeInsets.all(10.0),
    //   //                       child: Text(
    //   //                         textDirection: TextDirection.rtl,
    //   //                         QuranCubit.get(context).tafseerModel!.text!,
    //   //                         style: TextStyle(
    //   //                             fontSize: 28, fontWeight: FontWeight.w400),
    //   //                       ),
    //   //                     ),
    //   //                   );
    //   //                 });
    //   //               },
    //   //               icon: Image.asset('assets/images/languages.png'))
    //   //         ],
    //   //       ),
    //   //     ],
    //   //   ),
    //   // );
    //   k.children.add(
    //     Text(
    //       textDirection: TextDirection.rtl,
    //       "${element.text}\uFD3F${replaceFarsiNumber(element.numberInSurah.toString())}\uFD3E",
    //       style: TextStyle(
    //           color: Colors.black, fontSize: 30, fontWeight: FontWeight.w700),
    //     ),
    //   );
    //   k.children.add(
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         AudioQuran(url: element.audio!),
    //         IconButton(
    //             onPressed: () {
    //               QuranCubit.get(context)
    //                   .tafsirAya(
    //                       sura_number: index + 1,
    //                       ayah_number: element.numberInSurah!)
    //                   .then((value) {
    //                 showModalBottomSheet(
    //                   context: context,
    //                   builder: (context) => Padding(
    //                     padding: const EdgeInsets.all(10.0),
    //                     child: Text(
    //                       textDirection: TextDirection.rtl,
    //                       QuranCubit.get(context).tafseerModel!.text!,
    //                       style: TextStyle(
    //                           fontSize: 28, fontWeight: FontWeight.w400),
    //                     ),
    //                   ),
    //                 );
    //               });
    //             },
    //             icon: Image.asset('assets/images/languages.png'))
    //       ],
    //     ),
    //   );
    //   // print(element.ar);
    //   // a.add(TextSpan(
    //   //     text:
    //   //         "${element.text} \uFD3F${replaceFarsiNumber(element.numberInSurah.toString())}\uFD3E ",
    //   //     style: TextStyle(color: Colors.black, fontSize: 30)));
    // });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          QuranCubit.get(context).dataQuranApi![id].name!,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemBuilder: (context, index) => itemBuilderAyahs(
                QuranCubit.get(context).dataQuranApi![id].ayahs[index],
                context),
            // separatorBuilder: (context, index) =>

            itemCount: QuranCubit.get(context).dataQuranApi![id].ayahs.length),
      ),
    );
  }

  Widget itemBuilderAyahs(Ayahs model, context) {
    return Column(
      children: [
        Text(
          textDirection: TextDirection.rtl,
          // textAlign: TextAlign.right,
          "${model.text}\uFD3F${replaceFarsiNumber(model.numberInSurah.toString())}\uFD3E",
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.w700),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AudioQuran(url: model.audio!),
            IconButton(
                onPressed: () {
                  QuranCubit.get(context)
                      .tafsirAya(
                          sura_number: id + 1,
                          ayah_number: model.numberInSurah!)
                      .then((value) {
                    showModalBottomSheet(
                      // isScrollControlled: true,
                      enableDrag: true,
                      isDismissible: true,
                      context: context,
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Text(
                            textDirection: TextDirection.rtl,
                            QuranCubit.get(context).tafseerModel!.text!,
                            // overflow: TextOverflow.ellipsis,
                            // maxLines: 30,
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    );
                  });
                },
                icon: Image.asset('assets/images/languages.png'))
          ],
        ),
      ],
    );
  }
}
