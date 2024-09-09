import 'package:adkar/Screens/NamesOfAllah/cubit/names_of_allah_cubit.dart';
import 'package:adkar/Screens/NamesOfAllah/explain_name.dart';
import 'package:adkar/models/names_of_allah.dart';
import 'package:adkar/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/names_of_allah_state.dart';

class NamesOfAllah extends StatelessWidget {
  const NamesOfAllah({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NamesOfAllahCubit, NamesOfAllahState>(
      listener: (context, state) {},
      builder: (context, state) {
        NamesOfAllahCubit cubit = NamesOfAllahCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(color: Colors.white),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.brown.shade700, Colors.brown.shade500],
                ),
              ),
            ),
            title: const Text(
              'أسماء ٱللَّه الحسنى',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: cubit.namesModel.length,
            itemBuilder: (context, index) {
              return _namesOfAllahItem(context, cubit.namesModel[index], index);
            },
          ),
        );
      },
    );
  }

  Widget _namesOfAllahItem(
      BuildContext context, NamesOfAllahModel model, int index) {
    return InkWell(
      onTap: () {
        navigatAndReturn(
          context: context,
          page: ExplainName(
            id: index,
            name: model.name!,
            explain: model.text!,
          ),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Text(
                model.name!,
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
              const Spacer(),
              Image.asset(
                "assets/images/languages.png",
                height: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
