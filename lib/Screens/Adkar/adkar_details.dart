import 'package:adkar/Screens/Adkar/cubit/ahadith_cubit.dart';
import 'package:adkar/shared/components/audio.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/vibration.dart';

import '../../models/section_details_model.dart';
import '../../shared/components/constant.dart';
import '../../shared/helper/cash_helper.dart';
import 'cubit/ahadith_state.dart';

class AdkarDetails extends StatelessWidget {
  final String title;
  const AdkarDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    GlobalKey globalKey = GlobalKey();

    return BlocConsumer<AhadithCubit, AhadithState>(
      listener: (context, state) {},
      builder: (context, state) {
        AhadithCubit cubit = AhadithCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    if (cubit.ischangeSize) {
                      CachHelper.putcache(
                          key: 'sizeAdkarText', value: sizeAdkarTextCH);
                    }
                    cubit.showSliderChangeSizeText();
                  },
                  icon: Icon(
                      cubit.ischangeSize ? Icons.done_all : Icons.text_fields))
            ],
            title: Text(
              title,
            ),
          ),
          body: ConditionalBuilder(
            builder: (BuildContext context) {
              return Column(
                children: [
                  cubit.ischangeSize
                      ? Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    cubit.changeSliderValueWithButton('minus');
                                  },
                                  icon: Image.asset("assets/images/minus.png",
                                      height: 35),
                                ),
                                Expanded(
                                  child: Slider(
                                      value: cubit.valueSlider,
                                      onChanged: (onChange) {
                                        cubit.changeSliderValue(onChange);
                                      }),
                                ),
                                IconButton(
                                  onPressed: () {
                                    cubit.changeSliderValueWithButton('plus');
                                  },
                                  icon: Image.asset("assets/images/plus.png",
                                      height: 35),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        )
                      : const SizedBox(),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => dikrItem(
                          cubit.dataAdkarDetails![index], index, context),
                      itemCount: cubit.dataAdkarDetails!.length,
                    ),
                  ),
                ],
              );
            },
            condition: cubit.dataAdkarDetails!.isNotEmpty,
            fallback: (BuildContext context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'الَّذِينَ آتَيْنَاهُمْ الْكِتَابَ يَتْلُونَهُ حَقَّ تِلَاوَتِهِ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                  Audio(
                    globalKey: globalKey,
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget dikrItem(SectionDetailsModel model, index, context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Vibration.vibrate(duration: 20);

              AhadithCubit.get(context).readAdkar(index);
            },
            child: Card(
              color: Colors.grey[50],
              child: Text('${model.content}',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontSize: sizeAdkarTextCH, fontWeight: FontWeight.w600)),
            ),
          ),
          Row(
            children: [
              MaterialButton(
                color: Colors.grey,
                onPressed: () {},
                child: const Row(
                  children: [
                    Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'مشاركة',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Vibration.vibrate(duration: 20);
                    AhadithCubit.get(context).readAdkar(index);
                  },
                  child: Text(
                    "التكرار ${model.count}",
                    style: const TextStyle(fontSize: 25, color: Colors.grey),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
