import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';

class CustomDialog extends StatelessWidget {
  final Map<String, dynamic>? itemupdate;

  final update;
  const CustomDialog(
      {super.key, required this.itemupdate, required this.update});

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpanList = [];
    print(itemupdate);
    itemupdate!.forEach((key, value) {
      textSpanList.add(TextSpan(
          text: "\n$key ",
          style: TextStyle(
              color: Colors.red[300],
              fontSize: 19,
              fontWeight: FontWeight.w700)));

      textSpanList.add(TextSpan(
          text: "$value",
          style: const TextStyle(
              color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500)));
    });
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: Text(update!['title'] ?? ''),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              update!['subTitle'] ?? '',
            ),
            const SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(children: textSpanList),
              textDirection: TextDirection.rtl,
            )
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text("لاحقا"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text("تحديث الآن"),
            onPressed: () {
              StoreRedirect.redirect(androidAppId: "com.h0774g.alhou");
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
