import 'dart:io';
import 'dart:ui';

import 'package:events_dashboard/core/config/extensions/widget_extensions.dart';
import 'package:events_dashboard/core/utils/main_button.dart';
import 'package:events_dashboard/core/utils/main_text_field.dart';
import 'package:events_dashboard/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:events_dashboard/features/categories/presentation/pages/category_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    context.read<CategoriesBloc>().add(GetCategories());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          isExtended: true,
          child: const Icon(Icons.add),
          onPressed: () {
            ValueNotifier<File?> image = ValueNotifier(null);
            final controller = TextEditingController();
            final descriptionController = TextEditingController();
            final formKey = GlobalKey<FormState>();
            showAdaptiveDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 10),
                            MainTextField(
                              text: 'Title',
                              controller: controller,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a title';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            MainTextField(
                              text: 'Description',
                              controller: descriptionController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a description';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            ValueListenableBuilder(
                              valueListenable: image,
                              builder: (BuildContext context, dynamic value,
                                  Widget? child) {
                                return GestureDetector(
                                  onTap: () {
                                    ImagePicker()
                                        .pickImage(source: ImageSource.gallery)
                                        .then((v) {
                                      if (v != null) {
                                        image.value = File(v.path);
                                      }
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    width: 100,
                                    height: 100,
                                    child: value == null
                                        ? const Icon(Icons.camera_alt, size: 40)
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.file(
                                              value,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            MainButton(
                              text: 'Add',
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  if (image.value == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Please select an image')),
                                    );
                                    return;
                                  }
                                  context.read<CategoriesBloc>().add(
                                        AddCategory(
                                          name: controller.text,
                                          description:
                                              descriptionController.text,
                                          image: image.value!,
                                        ),
                                      );
                                  Navigator.pop(context);
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          return switch (state.status) {
            CubitStatus.success => GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    clipBehavior: Clip.hardEdge,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.network(
                          state.categories[index]['image'],
                          fit: BoxFit.cover,
                          width: 1.sw,
                          height: 1.sw,
                        ),
                        Container(
                          width: 1.sw,
                          height: 40,
                          alignment: Alignment.center,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100.withOpacity(.1),
                              borderRadius: BorderRadius.circular(12)),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                            child: Text(
                              state.categories[index]['name'],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ).onTap(() {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return CategoryDetails(
                          id: state.categories[index].id,
                        );
                      },
                    ));
                  });
                }),
            CubitStatus.failed => MainErrorWidget(onTap: () {
                context.read<CategoriesBloc>().add(GetCategories());
              }),
            _ => const Center(
                child: CircularProgressIndicator.adaptive(),
              )
          };
        },
      ),
    );
  }
}

class MainErrorWidget extends StatelessWidget {
  const MainErrorWidget({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('Something Wrong'),
          MainButton(text: 'Try Again', onPressed: onTap)
        ],
      ),
    );
  }
}
