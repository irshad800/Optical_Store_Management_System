import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../service/api_services.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class StaffAddLenseScreen extends StatefulWidget {
  const StaffAddLenseScreen({super.key});

  @override
  State<StaffAddLenseScreen> createState() => _StaffAddLenseScreenState();
}

class _StaffAddLenseScreenState extends State<StaffAddLenseScreen> {
  final ImagePicker picker = ImagePicker();
  XFile? image;

  void _getFromCamera() async {
    image = await picker.pickImage(source: ImageSource.camera);
  }

  void _getFromgallary() async {
    image = await picker.pickImage(source: ImageSource.gallery);
  }

  String selectedGlass = 'EYE GLASS';

  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController materialController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  @override
  void dispose() {
    brandController.dispose();
    modelController.dispose();
    colorController.dispose();
    materialController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    imageController.dispose();
    typeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Lenses'),
      ),
      bottomSheet: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: CustomButton(
          text: 'Add',
          onPressed: () async {
            if (!areControllersEmpty()) {
              await ApiServiece().addProduct(
                  context: context,
                  brand: brandController.text,
                  model: modelController.text,
                  color: colorController.text,
                  material: materialController.text,
                  price: priceController.text,
                  type: 'lens',
                  description: descriptionController.text,
                  imagePath: image!.path);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All fields are required'),
                ),
              );
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              fixedSize: const Size(150, 50)),
                          onPressed: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => Container(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              fixedSize: Size(
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  50)),
                                          onPressed: () {
                                            _getFromCamera();
                                            Navigator.pop(context);
                                          },
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.camera_alt_outlined),
                                              Text("Take a photo")
                                            ],
                                          )),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              fixedSize: Size(
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  50)),
                                          onPressed: () {
                                            _getFromgallary();
                                            Navigator.pop(context);
                                          },
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(CupertinoIcons
                                                  .photo_on_rectangle),
                                              Text("Upload from gallery")
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: const Text("Add photo")),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: image == null
                                  ? const Text("upload image")
                                  : Image(image: FileImage(File(image!.path))),
                            ),
                          );
                        },
                        icon: const Icon(
                          CupertinoIcons.eye,
                          size: 30,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hintText: 'Enter brand',
                  controller: brandController,
                  borderColor: Colors.grey,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hintText: 'Enter description',
                  controller: descriptionController,
                  borderColor: Colors.grey,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hintText: 'Enter model',
                  controller: modelController,
                  borderColor: Colors.grey,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hintText: 'Enter color',
                  controller: colorController,
                  borderColor: Colors.grey,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hintText: 'Enter material ',
                  controller: materialController,
                  borderColor: Colors.grey,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hintText: 'Enter price',
                  controller: priceController,
                  borderColor: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool areControllersEmpty() {
    return brandController.text.isEmpty &&
        modelController.text.isEmpty &&
        colorController.text.isEmpty &&
        materialController.text.isEmpty &&
        priceController.text.isEmpty &&
        descriptionController.text.isEmpty &&
        imageController.text.isEmpty &&
        typeController.text.isEmpty;
  }
}
