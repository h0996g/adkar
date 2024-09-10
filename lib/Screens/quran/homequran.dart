import 'package:adkar/Screens/quran/cubit/quran_cubit.dart';
import 'package:adkar/Screens/quran/sora_quran.dart';
import 'package:adkar/models/quran_api.dart';
import 'package:adkar/shared/components/components.dart';
import 'package:adkar/shared/helper/cash_helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../shared/helper/constant.dart';
import 'cubit/quran_state.dart';

class QuranHomeScreen extends StatefulWidget {
  const QuranHomeScreen({super.key});

  @override
  State<QuranHomeScreen> createState() => _QuranHomeScreenState();
}

class _QuranHomeScreenState extends State<QuranHomeScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    QuranCubit.get(context).resetValue();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuranCubit, QuranState>(
      listener: (context, state) {},
      builder: (context, state) {
        QuranCubit cubit = QuranCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.brown.shade700, Colors.brown.shade500],
                ),
              ),
            ),
            // backgroundColor: Colors.brown[800], // Primary color for the app bar
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white, // White icon
              ),
            ),
            title: const Text('القران الكريم'),
            actions: [
              IconButton(
                onPressed: () {
                  cubit.shearchTgelSora();
                },
                icon: Icon(
                  cubit.isSearchSora ? Icons.search_off : Icons.search,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              if (cubit.isSearchSora)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'اسم السورة القرانية',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    onChanged: (value) {
                      cubit.searchSora(value.toString());
                    },
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => ayaItem(
                    cubit.isSearchSora
                        ? cubit.searchSoraList![index]
                        : cubit.dataQuranApi![index],
                    context,
                  ),
                  itemCount: cubit.isSearchSora
                      ? cubit.searchSoraList!.length
                      : cubit.dataQuranApi!.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget ayaItem(QuranApi model, context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image(
          image: AssetImage(model.revelationType == 'Meccan'
              ? "assets/images/kaaba.png"
              : "assets/images/madina.png"),
        ),
      ),
      title: Text(
        model.name!,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      onTap: () {
        navigatAndReturn(
          context: context,
          page: ShowCaseWidget(
            onFinish: () async {
              await CachHelper.putcache(key: 'isFirstTimeQuran', value: false)
                  .then((value) {
                isFirstTimeQuranCH = false;
              });
            },
            builder: (context) => SoraQuran(
              id: model.number! - 1,
            ),
          ),
        );
      },
    );
  }
}
