import 'package:adkar/Screens/Adkar/Details.dart';
import 'package:adkar/Screens/Adkar/cubit/ahadith_cubit.dart';
import 'package:adkar/models/sectionModel.dart';
import 'package:adkar/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/ahadith_state.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AhadithCubit, AhadithState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('أذكار المسلم'),
            centerTitle: true,
          ),
          body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ConditionalBuilder(
                builder: (BuildContext context) {
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildItem(
                        AhadithCubit.get(context).dataSections![index],
                        context),
                    itemCount: AhadithCubit.get(context).dataSections!.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  );
                },
                condition: AhadithCubit.get(context).dataSections!.isNotEmpty,
                fallback: (BuildContext context) {
                  return Container();
                },
              )),
        );
      },
    );
  }

  Widget buildItem(SectionModel model, context) {
    return InkWell(
      onTap: () {
        print(model.id);
        AhadithCubit.get(context)
            .getSectionDetails(context, model.id!)
            .then((value) {
          navigatAndReturn(
              context: context,
              page: AdkarDetails(
                title: model.name!,
              ));
        });
      },
      child: Container(
        width: double.infinity,
        height: 100,
        // color: Colors.red,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Colors.lightGreenAccent,
              Colors.green,
              // Colors.lightGreen
            ])),
        child: Center(
          child: Text(
            "${model.name}",
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
