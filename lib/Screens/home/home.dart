import 'package:adkar/Screens/Adkar/Adkarhome.dart';
import 'package:adkar/shared/components/components.dart';
import 'package:adkar/shared/components/helper/constant.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('حصن المسلم'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              // color: Colors.amber,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/1.jpg"),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  // width: width,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                  ),
                  child: MaterialButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Image.asset("assets/images/iconquran.png", height: 35),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          // isUpperCase ? text.toUpperCase() : text,
                          "القران الكريم",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  // width: width,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      navigatAndReturn(context: context, page: AdkarHome());
                    },
                    child: Row(
                      children: [
                        Image.asset("assets/images/open-hands.png", height: 35),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          "اذكار المسلم",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Text("\uFD3E" + replaceFarsiNumber("2") + "\uFD3F")
          ],
        ),
      ),
    );
  }
}
