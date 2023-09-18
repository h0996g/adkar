import 'package:flutter/material.dart';

class ExplainName extends StatelessWidget {
  const ExplainName(
      {super.key, required this.id, required this.name, required this.explain});
  final int id;
  final String name;
  final String explain;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              name,
              style: TextStyle(fontSize: 100, fontWeight: FontWeight.w700),
            ),
          ),
          Text(
            explain,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              fontFamily: 'Amiri',
            ),
          )
        ]),
      ),
    );
  }
}
