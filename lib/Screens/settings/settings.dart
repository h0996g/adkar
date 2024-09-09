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
                      onChanged: (value) {
                        value
                            ? showToast(
                                msg: 'تم تفعيل التنبيهات بنجاح',
                                state: ToastStates.success)
                            : showToast(
                                msg: 'تم تعطيل التنبيهات',
                                state: ToastStates.warning);
                        cubit.changeSwitchListTile(value, 'switchNoti',
                            off: 'all');
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
                        children: [
                          ListTile(
                            title: const Text('تنبيهات عائمة'),
                            trailing: Radio(
                              value: 'custom',
                              activeColor: Colors.brown,
                              hoverColor: Colors.brown,
                              groupValue: cubit.notificationType,
                              onChanged: (value) {
                                cubit.changeNotificationType(value!);
                                // CustomNotification()
                                //     .startCustomNotificationService();
                                cubit.changeSwitchListTile(false, 'switchNoti',
                                    off: 'normal');
                                cubit.changeSwitchListTile(true, 'switchNoti',
                                    on: 'custom');
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('تنبيهات عادية'),
                            trailing: Radio(
                              activeColor: Colors.brown,
                              value: 'normal',
                              groupValue: cubit.notificationType,
                              onChanged: (value) {
                                cubit.changeNotificationType(value!);
                                cubit.changeSwitchListTile(false, 'switchNoti',
                                    off: 'custom');
                                cubit.changeSwitchListTile(true, 'switchNoti',
                                    on: 'normal');
                                // CustomNotification()
                                //     .stopCustomNotificationService();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  _buildSettingItem(
                    title: 'تفعيل الاهتزاز عند القراءة',
                    child: Switch.adaptive(
                      value: true,
                      onChanged: (value) {},
                      activeColor: Colors.brown,
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
