import 'package:adkar/Screens/quran/cubit/quran_cubit.dart';
import 'package:adkar/Screens/quran/soraQuran.dart';
import 'package:adkar/shared/components/components.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/quranModel.dart';
import 'cubit/quran_state.dart';

class QuranHomeScreen extends StatelessWidget {
  const QuranHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuranCubit, QuranState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: () {
            print(QuranCubit.get(context).dataQuranDetails!);
          }),
          appBar: AppBar(
              title: Text('القران الكريم'), backgroundColor: Colors.black),
          body: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10),
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => ayaItem(
                QuranCubit.get(context).dataQuranDetails![index], context),
            itemCount: QuranCubit.get(context).dataQuranDetails!.length,
          ),
        );
      },
    );
  }

  Widget ayaItem(QuranModel model, context) {
    return Card(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image(
            image: AssetImage(model.type == 'مكية'
                ? "assets/images/kaaba.png"
                : "assets/images/madina.png"),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              navigatAndReturn(
                  context: context, page: SoraQuran(index: model.id!));
            },
            child: Row(
              children: [
                Spacer(),
                Text(
                  model.name!,
                  style: TextStyle(
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
