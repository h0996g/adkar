import 'package:adkar/Screens/quran/cubit/quran_cubit.dart';
import 'package:adkar/Screens/quran/sora_quran.dart';
import 'package:adkar/models/quran_api.dart';
import 'package:adkar/shared/components/components.dart';
import 'package:adkar/shared/components/functions.dart';
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
              actions: [
                IconButton(
                    onPressed: () {
                      cubit.shearchTgelSora();
                    },
                    icon: Icon(
                        cubit.isSearchSora ? Icons.search_off : Icons.search))
              ],
              // iconTheme: IconThemeData(color: Colors.white),
              title: const Text('القران الكريم'),
              backgroundColor: Colors.white),
          body: Column(
            children: [
              if (cubit.isSearchSora)
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: defaultForm(
                    onChanged: (value) {
                      cubit.searchSora(value.toString());
                    },
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'اسم السورة القرانية',
                    controller: searchController,
                    textInputAction: TextInputAction.done,
                    validator: () {},
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
    return Card(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image(
            image: AssetImage(model.revelationType == 'مكية'
                ? "assets/images/kaaba.png"
                : "assets/images/madina.png"),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              navigatAndReturn(
                context: context,
                page: ShowCaseWidget(
                  onFinish: () async {
                    await CachHelper.putcache(
                            key: 'isFirstTimeQuran', value: false)
                        .then((value) {
                      isFirstTimeQuranCH = false;
                    });
                  },
                  builder: Builder(
                    builder: (context) => SoraQuran(
                      id: model.number! - 1,
                    ),
                  ),
                ),
              );
            },
            child: Row(
              children: [
                const Spacer(),
                Text(
                  model.name!,
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
