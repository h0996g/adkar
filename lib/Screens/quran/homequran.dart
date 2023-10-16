import 'package:adkar/Screens/quran/cubit/quran_cubit.dart';
import 'package:adkar/Screens/quran/sora_quran.dart';
import 'package:adkar/models/quran_api.dart';
import 'package:adkar/shared/components/components.dart';
import 'package:adkar/shared/components/constant.dart';
import 'package:adkar/shared/helper/cash_helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';

import 'cubit/quran_state.dart';

class QuranHomeScreen extends StatelessWidget {
  const QuranHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuranCubit, QuranState>(
      listener: (context, state) {},
      builder: (context, state) {
        QuranCubit cubit = QuranCubit.get(context);
        return Scaffold(
          appBar: AppBar(
              // iconTheme: IconThemeData(color: Colors.white),
              title: const Text('القران الكريم'),
              backgroundColor: Colors.white),
          body: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                ayaItem(cubit.dataQuranApi![index], context, index),
            itemCount: cubit.dataQuranApi!.length,
          ),
        );
      },
    );
  }

  Widget ayaItem(QuranApi model, context, int index) {
    return Card(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image(
            image: AssetImage(model.revelationType == 'مكية'
                ? "assets/images/kaaba.png"
                : "assets/images/madina.png"),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              navigatAndReturn(
                context: context,
                page: ShowCaseWidget(
                  onFinish: () async {
                    await CachHelper.putcache(
                            key: 'isFirstTimeQuran', value: false)
                        .then((value) {
                      isFirstTimeQuran = false;
                    });
                  },
                  builder: Builder(
                    builder: (context) => SoraQuran(
                      id: index,
                    ),
                  ),
                ),
              );
            },
            child: Row(
              children: [
                const Spacer(),
                Text(
                  model.name!,
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
