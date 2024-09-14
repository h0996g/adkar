import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_redirect/store_redirect.dart';

class CustomDialog extends StatelessWidget {
  final Map<String, dynamic>? itemupdate;
  final Map<String, dynamic>? update;

  const CustomDialog({Key? key, required this.itemupdate, required this.update})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> updateItems = [];
    itemupdate?.forEach((key, value) {
      updateItems.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.star, color: Colors.amber, size: 16.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "$key: ",
                        style: TextStyle(
                            color: Colors.brown[700],
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "$value",
                        style: TextStyle(
                            color: Colors.brown[600], fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: SingleChildScrollView(
          child: Container(
            width: 0.9.sw, // 90% of screen width
            constraints: BoxConstraints(maxWidth: 400.w), // Maximum width
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.brown[50]!, Colors.brown[100]!],
              ),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.system_update,
                      color: Colors.white, size: 30.sp),
                ),
                SizedBox(height: 16.h),
                Text(
                  update!['title'] ?? 'تحديث جديد متاح!',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[800]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12.h),
                Text(
                  update!['subTitle'] ??
                      'قم بتحديث التطبيق للحصول على أحدث الميزات والتحسينات',
                  style: TextStyle(fontSize: 14.sp, color: Colors.brown[600]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Text(
                            "لاحقا",
                            style: TextStyle(
                                fontSize: 14.sp, color: Colors.brown[700]),
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Text(
                            "تحديث الآن",
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                          StoreRedirect.redirect(
                              androidAppId: "com.h0774g.alhou");
                          Navigator.of(context).pop();
                        },
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
