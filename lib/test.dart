import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Muslim Azkar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AzkarScreen(),
    );
  }
}

class AzkarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Muslim Azkar'),
      ),
      body: Center(
        child: AzkarContainer(),
      ),
    );
  }
}

class AzkarContainer extends StatelessWidget {
  final List<String> azkarList = [
    'SubhanAllah (سبحان الله)',
    'Alhamdulillah (الحمد لله)',
    'Allahu Akbar (الله أكبر)',
    // Add more Azkar here
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Daily Azkar',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            itemCount: azkarList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  azkarList[index],
                  style: TextStyle(fontSize: 18),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
