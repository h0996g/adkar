import 'package:adkar/Screens/settings/cubit/settings_cubit.dart';
import 'package:adkar/notification.dart';
import 'package:adkar/shared/helper/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import 'cubit/settings_state.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      appBar: AppBar(
        title: const Text("الاعدادات"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocConsumer<SettingsCubit, SettingsState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            SettingsCubit cubit = SettingsCubit.get(context);

            return Column(textDirection: TextDirection.rtl, children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  const Expanded(
                    child: Text(
                      'تفعيل التنبيهات',
                      textDirection: TextDirection.rtl,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: SwitchListTile.adaptive(
                        activeTrackColor: Colors.green,
                        // inactiveThumbColor: Colors.amber,
                        selectedTileColor: Colors.red,
                        tileColor: Colors.transparent,
                        hoverColor: Colors.red,

                        thumbColor: MaterialStateProperty.all(Colors.grey[200]),
                        onChanged: (value) {
                          value
                              ? showToast(
                                  msg: 'تم تفعيل التنبيهات بنجاح',
                                  state: ToastStates.success)
                              : showToast(
                                  msg: 'تم تعطيل التنبيهات',
                                  state: ToastStates.warning);
                          cubit.changeSwitchListTile(value, 'switchNoti');
                        },
                        value: cubit.switchNoti,
                        activeColor: Colors.black26,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  const Expanded(
                    child: Text(
                      'تفعيل الاهتزاز عند القراءة ',
                      textDirection: TextDirection.rtl,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: SwitchListTile.adaptive(
                        onChanged: (value) {},
                        value: true,
                        activeColor: Colors.black26,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    const Expanded(
                      child: Text(
                        'موعد التنبيهات لأذكار الصباح',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                    ),
                    TextButton(
                      // focusNode: FocusNode(skipTraversal: ),
                      style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) => Colors.grey[100]!)),
                      child: Text(
                        "${cubit.selectedTimeSabah.hourOfPeriod}:${((cubit.selectedTimeSabah.minute >= 0 && cubit.selectedTimeSabah.minute < 10) ? '0' : '')}${cubit.selectedTimeSabah.minute} ${(cubit.selectedTimeSabah.period.name == 'am') ? "ص" : "م"}",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.green,
                            decoration: cubit.switchNoti
                                ? TextDecoration.none
                                : TextDecoration.lineThrough,
                            decorationColor: cubit.switchNoti
                                ? Colors.transparent
                                : Colors.black,
                            decorationThickness: 4),
                      ),
                      onPressed: () async {
                        if (cubit.switchNoti == false) {
                          return;
                        }
                        final TimeOfDay? timeOfDay = await showTimePicker(
                            context: context,
                            initialTime: cubit.selectedTimeSabah,
                            initialEntryMode: TimePickerEntryMode.dial);
                        if (timeOfDay != null) {
                          cubit.changeTimePicker(
                              sabahOrMasaa: 'sabah', timeOfDay: timeOfDay);
                          // bh nkhabi fl cach wnbdl time f notification tni
                          await cubit.changeTimeAdkar(
                              sabahOrMasaa: 'sabah', timeOfDay: timeOfDay);
                          showToast(
                              msg: 'تم تعديل موعد أذكار الصباح بنجاح',
                              state: ToastStates.success);
                        }
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    const Expanded(
                      child: Text(
                        'موعد التنبيهات لأذكار المساء',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) => Colors.grey[100]!)),
                      child: Text(
                        "${cubit.selectedTimeMasaa.hourOfPeriod}:${((cubit.selectedTimeMasaa.minute >= 0 && cubit.selectedTimeMasaa.minute < 10) ? '0' : '')}${cubit.selectedTimeMasaa.minute} ${(cubit.selectedTimeMasaa.period.name == 'am') ? "ص" : "م"}",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.green,
                            decoration: cubit.switchNoti
                                ? TextDecoration.none
                                : TextDecoration.lineThrough,
                            decorationColor: cubit.switchNoti
                                ? Colors.transparent
                                : Colors.black,
                            decorationThickness: 4),
                      ),
                      onPressed: () async {
                        if (cubit.switchNoti == false) {
                          return;
                        }
                        final TimeOfDay? timeOfDay = await showTimePicker(
                            context: context,
                            initialTime: cubit.selectedTimeMasaa,
                            initialEntryMode: TimePickerEntryMode.dial);
                        if (timeOfDay != null) {
                          cubit.changeTimePicker(
                              sabahOrMasaa: 'masaa', timeOfDay: timeOfDay);
                          // bh nkhabi fl cach wnbdl time f notification tni
                          await cubit.changeTimeAdkar(
                              sabahOrMasaa: 'masaa', timeOfDay: timeOfDay);
                          showToast(
                              msg: 'تم تعديل موعد أذكار المساء بنجاح',
                              state: ToastStates.success);
                        }
                      },
                    )
                  ],
                ),
              )
            ]);
          },
        ),
      ),
    );
  }
}
