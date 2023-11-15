import 'package:adkar/Screens/Adkar/cubit/ahadith_cubit.dart';
import 'package:adkar/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../Adkar/cubit/ahadith_state.dart';

class Suggest extends StatefulWidget {
  const Suggest({super.key});

  @override
  State<Suggest> createState() => _SuggestState();
}

class _SuggestState extends State<Suggest> {
  final formKey = GlobalKey<FormState>();
  final suggestController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AhadithCubit, AhadithState>(
      listener: (context, state) {
        if (state is UploadSeggestStateGood) {
          showToast(msg: 'تم الارسال بنجاح', state: ToastStates.success);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('ابلاغ'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: defaultForm(
                            autofocus: false,
                            controller: suggestController,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "يجب ان لا يكون الموضوع فارغ";
                              }
                            },
                            maxLines: 5,
                            hintText: 'ابلاغ عن خطا او اقتراح تعديل',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Choose the source :"),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        await AhadithCubit.get(context)
                                            .imagePickerProfile(
                                                ImageSource.camera)
                                            .then((value) {
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: const Text("Camera")),
                                  TextButton(
                                    onPressed: () async {
                                      await AhadithCubit.get(context)
                                          .imagePickerProfile(
                                              ImageSource.gallery)
                                          .then((value) {
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: const Text("Gallery"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.camera_alt,
                              size: 30,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (AhadithCubit.get(context).imageCompress != null)
                      Column(
                        children: [
                          Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              SizedBox(
                                width: 100,
                                height: 140,
                                child: Image.file(
                                  AhadithCubit.get(context).imageCompress!,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  AhadithCubit.get(context)
                                      .deleteImageSuggest();
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: Icon(
                                    Icons.delete_rounded,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (state is LoadingSeggustUpload)
                      const Column(
                        children: [
                          LinearProgressIndicator(),
                          SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                    defaultSubmit2(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AhadithCubit.get(context)
                              .uploadSuggestImg(text: suggestController.text)
                              .then((value) => {
                                    AhadithCubit.get(context)
                                        .resetValueSuggest(),
                                    setState(() {
                                      suggestController.text = '';
                                    })
                                  });
                        }

                        //     .then((value) {
                        //   // AhadithCubit.get(context).ResetValueSuggest();
                        //   // suggestController.dispose();
                        // });
                      },
                      text: 'ارسال',
                      fontSize: 22,
                      background: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
