import 'package:adkar/Screens/settings/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/settings_state.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        'موعد التنبيهات لاذكار الصباح',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                    ),
                    TextButton(
                      child: const Text(
                        "5:00 " + "ص",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 19),
                      ),
                      onPressed: () {},
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
                        'موعد التنبيهات لاذكار المساء',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                    ),
                    TextButton(
                      child: const Text(
                        "6:00 " + "م",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 19),
                      ),
                      onPressed: () {},
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
