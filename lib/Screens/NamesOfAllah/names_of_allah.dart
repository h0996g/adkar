import 'package:adkar/Screens/NamesOfAllah/cubit/names_of_allah_cubit.dart';
import 'package:adkar/Screens/NamesOfAllah/explain_name.dart';
import 'package:adkar/models/names_of_allah.dart';
import 'package:adkar/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/names_of_allah_state.dart';

class NamesOfAllah extends StatelessWidget {
  const NamesOfAllah({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NamesOfAllahCubit, NamesOfAllahState>(
      listener: (context, state) {},
      builder: (context, state) {
        NamesOfAllahCubit cubit = NamesOfAllahCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'أسماء ٱللَّه الحسنى',
              // style: TextStyle(color: Colors.black),
            ),
          ),
          body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return namesOfAllahItem(context, cubit.namesModel[index], index);
            },
            itemCount: cubit.namesModel.length,
          ),
        );
      },
    );
  }

  Widget namesOfAllahItem(
      BuildContext context, NamesOfAllahModel model, int index) {
    return InkWell(
      onTap: () {
        navigatAndReturn(
            context: context,
            page: ExplainName(
              id: index,
              name: model.name!,
              explain: model.text!,
            ));
      },
      child: Card(
        elevation: 5,
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Text(
              textDirection: TextDirection.rtl,
              model.name!,
              style: const TextStyle(
                fontSize: 40,
                // fontWeight: FontWeight.w500,
                // fontFamily: "Amiri"
              ),
            ),
            const Spacer(),
            Image.asset("assets/images/languages.png", height: 35),
          ],
        ),

        // Text(
        //   textDirection: TextDirection.ltr,
        //   model.text!,
        //   style: TextStyle(
        //     fontSize: 10,
        //     fontWeight: FontWeight.w500,
        //   ),
        // ),
      ),
    );
  }
}
