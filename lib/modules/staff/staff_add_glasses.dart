import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:opticals/modules/staff/staff_home.dart';

import '../../service/api_services.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class StaffAddGlassScreen extends StatefulWidget {
  const StaffAddGlassScreen({Key? key}) : super(key: key);

  @override
  State<StaffAddGlassScreen> createState() => _StaffAddGlassScreenState();
}

class _StaffAddGlassScreenState extends State<StaffAddGlassScreen> {
  final ImagePicker picker = ImagePicker();
  XFile? image;

  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController materialController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
        title: Text('Add Glass'),
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
                type: 'sunglass',
                description: descriptionController.text,
                imagePath: image!.path,
              );
              // Navigate to StaffHomeScreen after successful addition
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => StaffHomeScreen()),
              );
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
                          fixedSize: const Size(150, 50),
                        ),
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
                                          MediaQuery.of(context).size.width,
                                          50,
                                        ),
                                      ),
                                      onPressed: _getFromCamera,
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.camera_alt_outlined),
                                          Text("Take a photo")
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        fixedSize: Size(
                                          MediaQuery.of(context).size.width,
                                          50,
                                        ),
                                      ),
                                      onPressed: _getFromGallery,
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(CupertinoIcons
                                              .photo_on_rectangle),
                                          Text("Upload from gallery")
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: const Text("Add photo"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: image == null
                                ? const Text("Upload image")
                                : Image(
                                    image: FileImage(File(image!.path)),
                                  ),
                          ),
                        );
                      },
                      icon: const Icon(
                        CupertinoIcons.eye,
                        size: 30,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Enter brand',
                  controller: brandController,
                  borderColor: Colors.grey,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Enter description',
                  controller: descriptionController,
                  borderColor: Colors.grey,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Enter model',
                  controller: modelController,
                  borderColor: Colors.grey,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Enter color',
                  controller: colorController,
                  borderColor: Colors.grey,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Enter material',
                  controller: materialController,
                  borderColor: Colors.grey,
                ),
                SizedBox(height: 20),
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

  Future<void> _getFromCamera() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.camera);
    setState(() {
      image = pickedImage;
    });
  }

  Future<void> _getFromGallery() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = pickedImage;
    });
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
