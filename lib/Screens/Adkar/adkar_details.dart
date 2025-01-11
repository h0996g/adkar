import 'package:adkar/Screens/Adkar/cubit/ahadith_cubit.dart';
import 'package:adkar/shared/components/audio_adkar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vibration/vibration.dart';

import '../../models/section_details_model.dart';
import '../../shared/helper/cash_helper.dart';
import '../../shared/helper/constant.dart';
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
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white, // White icon
              ),
            ),
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
                  cubit.ischangeSize ? Icons.done_all : Icons.text_fields,
                  color: Colors.white, // White icon
                ),
              )
            ],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.brown.shade700, Colors.brown.shade500],
                ),
              ),
            ),
            title: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp), // White text with responsive size
            ),
          ),
          body: ConditionalBuilder(
            builder: (BuildContext context) {
              return Column(
                children: [
                  if (cubit.ischangeSize) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              cubit.changeSliderValueWithButton('minus');
                            },
                            icon: Image.asset(
                              "assets/images/minus.png",
                              height: 35.h,
                            ),
                          ),
                          Expanded(
                            child: Slider(
                              value: cubit.valueSlider,
                              onChanged: (onChange) {
                                cubit.changeSliderValue(onChange);
                              },
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              cubit.changeSliderValueWithButton('plus');
                            },
                            icon: Image.asset(
                              "assets/images/plus.png",
                              height: 35.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
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
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'الَّذِينَ آتَيْنَاهُمْ الْكِتَابَ يَتْلُونَهُ حَقَّ تِلَاوَتِهِ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    AudioAdkar(globalKey: globalKey),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget dikrItem(SectionDetailsModel model, int index, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: InkWell(
        onTap: () {
          Vibration.vibrate(duration: 20);
          AhadithCubit.get(context).readAdkar(index);
        },
        child: Card(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r), // Rounded corners
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.content}',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: sizeAdkarTextCH.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.brown[800], // Text color for readability
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Vibration.vibrate(duration: 20);
                        AhadithCubit.get(context).readAdkar(index);
                      },
                      child: Text(
                        "التكرار ${model.count}",
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: Colors.brown[400],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      onPressed: () {
                        // Share functionality
                        Share.share(
                          'شارك هذا الحديث:\n\n'
                          '${model.content}\n\n'
                          'عدد التكرارات: ${model.count}',
                          subject: 'مشاركة حديث',
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.share, color: Colors.white, size: 20.sp),
                          SizedBox(width: 8.w),
                          Text(
                            'مشاركة',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
