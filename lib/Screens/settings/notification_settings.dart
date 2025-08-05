import 'package:adkar/Screens/settings/cubit/settings_cubit.dart';
import 'package:adkar/Screens/settings/cubit/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  @override
  void initState() {
    SettingsCubit.get(context).loadNotificationSettings();
    _showCustomNotification(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'إعدادات التنبيهات',
          style: TextStyle(color: Colors.white, fontSize: 20.sp),
        ),
        backgroundColor: Colors.brown,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state is ChangeNotificationSettingsState) {
            _showCustomNotification(context);
          }
        },
        builder: (context, state) {
          SettingsCubit cubit = SettingsCubit.get(context);
          if (state is NotificationSettingsLoaded ||
              state is ChangeNotificationSettingsState) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.brown.shade50, Colors.white],
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 80.h),
                    _buildSettingItem(
                      title: 'حجم النص',
                      child: _buildTextSizeSlider(cubit),
                    ),
                    // SizedBox(height: 20.h),
                    _buildSettingItem(
                      title: 'لون النص',
                      child: _buildColorPicker(context, cubit),
                    ),
                    // SizedBox(height: 20.h),
                    _buildSettingItem(
                      title: 'شفافية الخلفية',
                      child: _buildTransparencySlider(cubit),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.brown),
          ),
          SizedBox(height: 12.h),
          child,
        ],
      ),
    );
  }

  Widget _buildTextSizeSlider(SettingsCubit cubit) {
    return Column(
      children: [
        Slider(
          value: cubit.notificationTextSize,
          min: 12,
          max: 30,
          divisions: 18,
          label: '${cubit.notificationTextSize.toStringAsFixed(1)} sp',
          onChanged: (value) => cubit.changeNotificationTextSize(value),
          activeColor: Colors.brown,
        ),
        Text('${cubit.notificationTextSize.toStringAsFixed(1)} sp',
            style: TextStyle(fontSize: 14.sp)),
      ],
    );
  }

  Widget _buildColorPicker(BuildContext context, SettingsCubit cubit) {
    return ColorPicker(
      pickerColor: cubit.notificationTextColor,
      onColorChanged: (color) => cubit.changeNotificationTextColor(color),
      pickerAreaHeightPercent: 0.2,
      displayThumbColor: true,
      showLabel: false,
      paletteType: PaletteType.hsvWithHue,
    );
  }

  Widget _buildTransparencySlider(SettingsCubit cubit) {
    return Column(
      children: [
        Slider(
          value: cubit.notificationTransparency,
          min: 0,
          max: 1,
          divisions: 10,
          label:
              '${(cubit.notificationTransparency * 100).toStringAsFixed(0)}%',
          onChanged: (value) => cubit.changeNotificationTransparency(value),
          activeColor: Colors.brown,
        ),
        Text('${(cubit.notificationTransparency * 100).toStringAsFixed(0)}%',
            style: TextStyle(fontSize: 14.sp)),
      ],
    );
  }

  void _showCustomNotification(BuildContext context) {
    const platform = MethodChannel('com.h0774g.alhou/custom_notification');
    platform.invokeMethod('showCustomNotification', {
      'message':
          'اللَّهُمَّ إنِّي أَسْأَلُكَ الهُدَى وَالتُّقَى، وَالْعَفَافَ وَالْغِنَى',
    });
  }
}
