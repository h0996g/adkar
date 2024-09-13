import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';

Widget buildShareAppSection(BuildContext context) {
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'مشاركة التطبيق',
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.share, color: Colors.white),
              label: const Text(
                'مشاركة الرابط',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _shareApp();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.qr_code, color: Colors.white),
              label: const Text(
                'عرض رمز QR',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _showQRCode(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

void _shareApp() {
  Share.share('تطبيق الأذكار - رفيقك اليومي \n\n'
      '• أذكار الصباح والمساء\n'
      '• التسبيح الإلكتروني\n'
      '• القرآن الكريم مع التفسير\n'
      '• تلاوات قرآنية صوتية لقراء مختلفين\n'
      '• إشعارات يومية للتذكير\n'
      '• أسماء الله الحسنى مع الشرح\n'
      '• واجهة سهلة الاستخدام وتصميم جميل\n\n'
      'حمّل التطبيق الآن :\n'
      'https://play.google.com/store/apps/details?id=com.h0774g.alhou');
}

void _showQRCode(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: contentBox(context),
      );
    },
  );
}

Widget contentBox(BuildContext context) {
  return Stack(
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(
            left: 20.w, top: 65.h + 20.h, right: 20.w, bottom: 20.h),
        margin: EdgeInsets.only(top: 45.h),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.brown[50]!,
              Colors.brown[100]!,
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'مسح الرمز لتحميل التطبيق',
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15.h),
            QrImageView(
              data:
                  'https://play.google.com/store/apps/details?id=com.h0774g.alhou',
              version: QrVersions.auto,
              size: 200.0.r,
              backgroundColor: Colors.white,
            ),
            SizedBox(height: 15.h),
            Text(
              'شارك التطبيق مع أصدقائك',
              style: TextStyle(fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'إغلاق',
                  style: TextStyle(fontSize: 18.sp, color: Colors.brown),
                ),
              ),
            ),
          ],
        ),
      ),
      Positioned(
        left: 20.w,
        right: 20.w,
        child: CircleAvatar(
          backgroundColor: Colors.brown,
          radius: 45.r,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(45.r)),
            child: Icon(
              Icons.qr_code,
              color: Colors.white,
              size: 50.r,
            ),
          ),
        ),
      ),
    ],
  );
}
