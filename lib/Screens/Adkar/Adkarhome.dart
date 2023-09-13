import 'package:adkar/Screens/Adkar/adkarDetails.dart';
import 'package:adkar/Screens/Adkar/cubit/ahadith_cubit.dart';
import 'package:adkar/models/sectionModel.dart';
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
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          // appBar: AppBar(
          //   iconTheme: IconThemeData(color: Colors.white),
          //   backgroundColor: Colors.black,
          //   title: const Text(
          //     'أذكار المسلم',
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   centerTitle: true,
          // ),

          body: ConditionalBuilder(
            builder: (BuildContext context) {
              return CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    iconTheme: IconThemeData(
                      color: Colors.white,
                    ),
                    // title: Text('اذكار الصباح'),
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 0,
                    pinned: true,
                    centerTitle: false,
                    expandedHeight: 230,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image(
                        image: AssetImage("assets/images/2.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => buildItem(
                            AhadithCubit.get(context).dataSections![index],
                            context,
                            index),
                        childCount:
                            AhadithCubit.get(context).dataSections!.length),
                  ),
                ],
              );
            },
            condition: AhadithCubit.get(context).dataSections!.isNotEmpty,
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
        print(model.id);
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
      ),
    );
  }
}
