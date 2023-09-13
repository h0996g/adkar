import 'package:adkar/Screens/quran/audioQuran.dart';
import 'package:adkar/Screens/quran/cubit/quran_cubit.dart';
import 'package:adkar/models/quranApi.dart';
import 'package:adkar/shared/components/constant.dart';
import 'package:adkar/shared/components/show_case_widget.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../shared/components/helper/constant.dart';

class SoraQuran extends StatefulWidget {
  final int id;
  const SoraQuran({super.key, required this.id});

  @override
  State<SoraQuran> createState() => _SoraQuranState();
}

class _SoraQuranState extends State<SoraQuran> {
  final GlobalKey globalKeyOne = GlobalKey();
  final GlobalKey globalKeyTwo = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    if (isFirstTimeQuran)
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => ShowCaseWidget.of(context)
            .startShowCase([globalKeyOne, globalKeyTwo]),
      );
    super.initState();
  }

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
          QuranCubit.get(context).dataQuranApi![widget.id].name!,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => itemBuilderAyahs(
                QuranCubit.get(context).dataQuranApi![widget.id].ayahs[index],
                context,
                index),
            // separatorBuilder: (context, index) =>

            itemCount:
                QuranCubit.get(context).dataQuranApi![widget.id].ayahs.length),
      ),
    );
  }

  Widget itemBuilderAyahs(Ayahs model, context, int index) {
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
            AudioQuran(
              url: model.audio!,
              globalKey: globalKeyOne,
              index: index,
            ),
            index == 0
                ? ShowCaseView(
                    description: '',
                    globalKey: globalKeyTwo,
                    title: 'شرح الاية القرانية',
                    child: IconButton(
                        onPressed: () {
                          QuranCubit.get(context)
                              .tafsirAya(
                                  sura_number: widget.id + 1,
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
                                        fontSize: 28,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                        icon: Image.asset('assets/images/languages.png')),
                  )
                : IconButton(
                    onPressed: () {
                      QuranCubit.get(context)
                          .tafsirAya(
                              sura_number: widget.id + 1,
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
                    icon: Image.asset('assets/images/languages.png')),
          ],
        ),
      ],
    );
  }
}
