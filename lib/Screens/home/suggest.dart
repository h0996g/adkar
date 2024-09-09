import 'dart:ui';

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
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.brown.shade700, Colors.brown.shade500],
                ),
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
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
                    const SizedBox(
                      height: 20,
                    ),
                    Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        defaultForm(
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
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) => Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10,
                                      offset: Offset(0, -5),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "Choose the source:",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 10),
                                      Center(
                                        // Center the row of buttons
                                        child: Row(
                                          mainAxisSize: MainAxisSize
                                              .min, // Minimize the row size
                                          children: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                await AhadithCubit.get(context)
                                                    .imagePickerProfile(
                                                        ImageSource.camera)
                                                    .then((value) {
                                                  Navigator.pop(context);
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors
                                                    .brown, // Set the background color to brown
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10), // Rounded corners
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical:
                                                            10), // Padding
                                              ),
                                              child: const Text(
                                                "Camera",
                                                style: TextStyle(
                                                    color: Colors
                                                        .white), // White text color
                                              ),
                                            ),
                                            const SizedBox(
                                                width:
                                                    10), // Space between buttons
                                            ElevatedButton(
                                              onPressed: () async {
                                                await AhadithCubit.get(context)
                                                    .imagePickerProfile(
                                                        ImageSource.gallery)
                                                    .then((value) {
                                                  Navigator.pop(context);
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors
                                                    .brown, // Set the background color to brown
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10), // Rounded corners
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical:
                                                            10), // Padding
                                              ),
                                              child: const Text(
                                                "Gallery",
                                                style: TextStyle(
                                                    color: Colors
                                                        .white), // White text color
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.camera_alt,
                              size: 30,
                              color: Colors.brown[300]!,
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
                      },
                      text: 'ارسال',
                      fontSize: 22,
                      background: Colors.brown[400]!,
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
