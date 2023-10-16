import 'package:adkar/Screens/Adkar/adkar_details.dart';
import 'package:adkar/Screens/Adkar/cubit/ahadith_cubit.dart';
import 'package:adkar/models/section_model.dart';
import 'package:adkar/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';

import 'cubit/ahadith_state.dart';

class AdkarHome extends StatelessWidget {
  const AdkarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AhadithCubit, AhadithState>(
      listener: (context, state) {},
      builder: (context, state) {
        AhadithCubit cubit = AhadithCubit.get(context);
        return Scaffold(
          body: ConditionalBuilder(
            builder: (BuildContext context) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    iconTheme: const IconThemeData(
                      color: Colors.white,
                    ),
                    // title: Text('اذكار الصباح'),
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 0,
                    pinned: true,
                    centerTitle: false,
                    expandedHeight: 230,
                    flexibleSpace: const FlexibleSpaceBar(
                      background: Image(
                        image: AssetImage("assets/images/888-6.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => buildItem(
                            cubit.dataSections![index], context, index),
                        childCount: cubit.dataSections!.length),
                  ),
                ],
              );
            },
            condition: cubit.dataSections!.isNotEmpty,
            fallback: (BuildContext context) {
              return Container();
            },
          ),
        );
      },
    );
  }

  Widget buildItem(SectionModel model, context, int index) {
    return InkWell(
      onTap: () {
        // print(model.id);
        AhadithCubit.get(context)
            .getSectionDetails(context, model.id!)
            .then((value) {
          navigatAndReturn(
              context: context,
              page: ShowCaseWidget(
                builder: Builder(
                  builder: (context) => AdkarDetails(
                    title: model.name!,
                  ),
                ),
              ));
        });
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
            top: 9, bottom: 3, start: 5, end: 5),
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: AhadithCubit.get(context).colors[index],
            // borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset(AhadithCubit.get(context).icon[index],
                      height: 40)),
              // Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  child: Text("${model.name}",
                      textDirection: TextDirection.rtl,
                      style: Theme.of(context).textTheme.displayMedium),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
