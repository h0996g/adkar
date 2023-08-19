import 'package:adkar/Screens/Adkar/cubit/ahadith_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/vibration.dart';

// import 'package:vibration/vibration.dart';
import '../../models/sectionDetails.dart';
import 'cubit/ahadith_state.dart';

class AdkarDetails extends StatelessWidget {
  static const _extraScrollSpeed = 80; // your "extra" scroll speed
  final ScrollController _scrollController = ScrollController();
  final String title;
  AdkarDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AhadithCubit, AhadithState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            backgroundColor: Colors.blueAccent[100],
          ),
          body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => dikrItem(
                AhadithCubit.get(context).dataDetails![index], index, context),
            itemCount: AhadithCubit.get(context).dataDetails!.length,
          ),
        );
      },
    );
  }

  Widget dikrItem(SectionDetails model, index, context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Vibration.vibrate(duration: 20);

              AhadithCubit.get(context).readAdkar(index);
            },
            child: Card(
              color: Colors.grey[50],
              child: Text('${model.content}',
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.w600)),
            ),
          ),
          Row(
            children: [
              MaterialButton(
                color: Colors.grey,
                onPressed: () {},
                child: const Row(
                  children: [
                    Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'مشاركة',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Vibration.vibrate(duration: 20);
                    AhadithCubit.get(context).readAdkar(index);
                  },
                  child: Text(
                    "التكرار ${model.count}",
                    style: const TextStyle(fontSize: 25, color: Colors.grey),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
