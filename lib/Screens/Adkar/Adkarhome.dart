import 'package:adkar/Screens/Adkar/adkarDetails.dart';
import 'package:adkar/Screens/Adkar/cubit/ahadith_cubit.dart';
import 'package:adkar/models/sectionModel.dart';
import 'package:adkar/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/ahadith_state.dart';

class AdkarHome extends StatelessWidget {
  const AdkarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AhadithCubit, AhadithState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'أذكار المسلم',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ConditionalBuilder(
                builder: (BuildContext context) {
                  return Column(
                    children: [
                      Container(
                        height: 250,
                        width: double.infinity,
                        // color: Colors.amber,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/2.jpg"),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildItem(
                              AhadithCubit.get(context).dataSections![index],
                              context,
                              index),
                          itemCount:
                              AhadithCubit.get(context).dataSections!.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                        ),
                      ),
                    ],
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

  Widget buildItem(SectionModel model, context, int index) {
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
        height: 90,
        // color: Colors.red,
        decoration: BoxDecoration(
          color: AhadithCubit.get(context).colors[index],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Image.asset(AhadithCubit.get(context).icon[index],
                    height: 40)),
            // Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "${model.name}",
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
