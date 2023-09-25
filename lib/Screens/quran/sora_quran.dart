import 'package:adkar/Screens/quran/cubit/quran_cubit.dart';
import 'package:adkar/models/quran_api.dart';
import 'package:adkar/shared/components/constant.dart';
import 'package:adkar/shared/components/show_case_widget.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../shared/components/audio_quran.dart';
import '../../shared/helper/constant.dart';

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
    if (isFirstTimeQuran) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => ShowCaseWidget.of(context)
            .startShowCase([globalKeyOne, globalKeyTwo]),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          QuranCubit.get(context).dataQuranApi![widget.id].name!,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
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
          style: const TextStyle(
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
                                  suraNumber: widget.id + 1,
                                  ayahNumber: model.numberInSurah!)
                              .then((value) {
                            showModalBottomSheet(
                              // isScrollControlled: true,
                              enableDrag: true,
                              isDismissible: true,
                              context: context,
                              builder: (context) => Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Text(
                                    textDirection: TextDirection.rtl,
                                    QuranCubit.get(context).tafseerModel!.text!,
                                    // overflow: TextOverflow.ellipsis,
                                    // maxLines: 30,
                                    style: const TextStyle(
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
                              suraNumber: widget.id + 1,
                              ayahNumber: model.numberInSurah!)
                          .then((value) {
                        showModalBottomSheet(
                          // isScrollControlled: true,
                          enableDrag: true,
                          isDismissible: true,
                          context: context,
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Text(
                                textDirection: TextDirection.rtl,
                                QuranCubit.get(context).tafseerModel!.text!,
                                // overflow: TextOverflow.ellipsis,
                                // maxLines: 30,
                                style: const TextStyle(
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
