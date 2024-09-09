import 'package:adkar/Screens/Adkar/adkar_details.dart';
import 'package:adkar/Screens/Adkar/cubit/ahadith_cubit.dart';
import 'package:adkar/models/section_model.dart';
import 'package:adkar/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                    iconTheme: const IconThemeData(color: Colors.white),
                    backgroundColor: Colors.brown,
                    elevation: 0,
                    pinned: true,
                    centerTitle: false,
                    expandedHeight: 200.h,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.asset(
                        "assets/images/888-6.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.all(16.w),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.2,
                        crossAxisSpacing: 16.w,
                        mainAxisSpacing: 16.h,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => buildItem(
                            cubit.dataSections![index], context, index),
                        childCount: cubit.dataSections!.length,
                      ),
                    ),
                  ),
                ],
              );
            },
            condition: cubit.dataSections!.isNotEmpty,
            fallback: (BuildContext context) {
              return const Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
    );
  }

  Widget buildItem(SectionModel model, context, int index) {
    return InkWell(
      onTap: () {
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
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.brown.shade100,
              Colors.brown.shade50,
            ],
          ),
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AhadithCubit.get(context).icon[index],
              height: 50.h,
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                "${model.name}",
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
