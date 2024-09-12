import 'package:adkar/Screens/settings/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/components/components.dart';
import 'cubit/settings_state.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "الاعدادات",
          style: TextStyle(color: Colors.white, fontSize: 20.sp),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.brown,
        elevation: 0,
      ),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          SettingsCubit cubit = SettingsCubit.get(context);

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.brown.shade50, Colors.white],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                textDirection: TextDirection.rtl,
                children: [
                  _buildSettingItem(
                    title: 'تفعيل التنبيهات',
                    child: Switch.adaptive(
                      value: cubit.switchNoti,
                      onChanged: (value) async {
                        print(value);

                        value
                            ? showToast(
                                msg: 'تم تفعيل التنبيهات بنجاح',
                                state: ToastStates.success)
                            : showToast(
                                msg: 'تم تعطيل التنبيهات',
                                state: ToastStates.warning);

                        await cubit.changeSwitchListTile(value, 'switchNoti',
                            on: cubit.notificationType);
                      },
                      activeColor: Colors.brown,
                    ),
                  ),
                  if (cubit.switchNoti)
                    Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'نوع التنبيهات',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    await cubit
                                        .changeNotificationType('custom');
                                    await cubit.changeSwitchListTile(
                                        true, 'switchNoti',
                                        on: 'custom');
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(12.w),
                                    decoration: BoxDecoration(
                                      color: cubit.notificationType == 'custom'
                                          ? Colors.brown
                                          : Colors.brown.shade50,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      'تنبيهات عائمة',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color:
                                            cubit.notificationType == 'custom'
                                                ? Colors.white
                                                : Colors.brown,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    await cubit
                                        .changeNotificationType('normal');
                                    await cubit.changeSwitchListTile(
                                        true, 'switchNoti',
                                        on: 'normal');
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(12.w),
                                    decoration: BoxDecoration(
                                      color: cubit.notificationType == 'normal'
                                          ? Colors.brown
                                          : Colors.brown.shade50,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      'تنبيهات عادية',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color:
                                            cubit.notificationType == 'normal'
                                                ? Colors.white
                                                : Colors.brown,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (cubit.notificationType == 'custom') ...[
                            SizedBox(height: 16.h),
                            Text(
                              'تكرار التنبيهات العائمة',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Wrap(
                              spacing: 8.w,
                              runSpacing: 8.h,
                              children: [
                                '5 دقائق',
                                '15 دقيقة',
                                '30 دقيقة',
                                '1 ساعة',
                                '2 ساعة',
                                '4 ساعات'
                              ].map((interval) {
                                return GestureDetector(
                                  onTap: () =>
                                      cubit.changeFloatingNotificationInterval(
                                          interval),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 8.h),
                                    decoration: BoxDecoration(
                                      color:
                                          cubit.floatingNotificationInterval ==
                                                  interval
                                              ? Colors.brown
                                              : Colors.brown.shade50,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Text(
                                      interval,
                                      style: TextStyle(
                                        color:
                                            cubit.floatingNotificationInterval ==
                                                    interval
                                                ? Colors.white
                                                : Colors.brown,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ],
                      ),
                    ),
                  _buildSettingItem(
                    title: 'تفعيل الاهتزاز عند القراءة',
                    child: Switch.adaptive(
                      value: true,
                      onChanged: (value) {},
                      activeColor: Colors.grey,
                    ),
                  ),
                  _buildSettingItem(
                    title: 'موعد التنبيهات لأذكار الصباح',
                    child: _buildTimeButton(
                      context,
                      cubit,
                      cubit.selectedTimeSabah,
                      'sabah',
                      'تم تعديل موعد أذكار الصباح بنجاح',
                    ),
                  ),
                  _buildSettingItem(
                    title: 'موعد التنبيهات لأذكار المساء',
                    child: _buildTimeButton(
                      context,
                      cubit,
                      cubit.selectedTimeMasaa,
                      'masaa',
                      'تم تعديل موعد أذكار المساء بنجاح',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIntervalDropdown(SettingsCubit cubit) {
    return DropdownButton<String>(
      value: cubit.floatingNotificationInterval,
      items: <String>[
        '15 minutes',
        '30 minutes',
        '1 hour',
        '2 hours',
        '4 hours'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          cubit.changeFloatingNotificationInterval(newValue);
        }
      },
      style: TextStyle(color: Colors.brown, fontSize: 16.sp),
      dropdownColor: Colors.brown.shade50,
    );
  }

  Widget _buildSettingItem({required String title, required Widget child}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Expanded(
            child: Text(
              title,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
          ),
          child,
        ],
      ),
    );
  }

  Widget _buildTimeButton(BuildContext context, SettingsCubit cubit,
      TimeOfDay selectedTime, String sabahOrMasaa, String successMessage) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.brown.shade50),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
      child: Text(
        "${selectedTime.hourOfPeriod}:${((selectedTime.minute >= 0 && selectedTime.minute < 10) ? '0' : '')}${selectedTime.minute} ${(selectedTime.period.name == 'am') ? "ص" : "م"}",
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.brown,
          decoration: cubit.switchNoti
              ? TextDecoration.none
              : TextDecoration.lineThrough,
          decorationColor: cubit.switchNoti ? Colors.transparent : Colors.black,
          decorationThickness: 2,
        ),
      ),
      onPressed: () async {
        if (cubit.switchNoti == false) {
          return;
        }
        final TimeOfDay? timeOfDay = await showTimePicker(
          context: context,
          initialTime: selectedTime,
          initialEntryMode: TimePickerEntryMode.dial,
        );
        if (timeOfDay != null) {
          cubit.changeTimePicker(
              sabahOrMasaa: sabahOrMasaa, timeOfDay: timeOfDay);
          await cubit.changeTimeAdkar(
              sabahOrMasaa: sabahOrMasaa, timeOfDay: timeOfDay);
          showToast(msg: successMessage, state: ToastStates.success);
        }
      },
    );
  }
}
