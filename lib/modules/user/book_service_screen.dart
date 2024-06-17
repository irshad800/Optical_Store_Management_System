import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../service/api_services.dart';
import '../../service/db_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'doctor_booking_confirmation.dart';

class BookServiceScreen extends StatefulWidget {
  const BookServiceScreen({super.key});

  @override
  State<BookServiceScreen> createState() => _BookServiceScreenState();
}

class _BookServiceScreenState extends State<BookServiceScreen> {
  final _userBookingFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _description = TextEditingController();

  DateTime? newDateTime;

  final ImagePicker picker = ImagePicker();
  XFile? image;

  void _getFromCamera() async {
    image = await picker.pickImage(source: ImageSource.camera);
  }

  void _getFromgallary() async {
    image = await picker.pickImage(source: ImageSource.gallery);
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book your Service'),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CustomButton(
            text: 'Submit',
            onPressed: () {
              _submit();
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Form(
            key: _userBookingFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //    Row(
                //   children: [
                //     Expanded(
                //       child: OutlinedButton(
                //           style: OutlinedButton.styleFrom(
                //               fixedSize: const Size(150, 50)),
                //           onPressed: () {
                //             showModalBottomSheet(
                //               backgroundColor: Colors.transparent,
                //               context: context,
                //               builder: (context) => Container(
                //                 width: MediaQuery.of(context).size.width,
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(20.0),
                //                   child: Column(
                //                     mainAxisSize: MainAxisSize.min,
                //                     children: [
                //                       OutlinedButton(
                //                           style: OutlinedButton.styleFrom(
                //                               backgroundColor: Colors.white,
                //                               fixedSize: Size(
                //                                   MediaQuery.of(context)
                //                                       .size
                //                                       .width,
                //                                   50)),
                //                           onPressed: () {
                //                             _getFromCamera();
                //                             Navigator.pop(context);
                //                           },
                //                           child: const Row(
                //                             mainAxisAlignment:
                //                                 MainAxisAlignment.center,
                //                             children: [
                //                               Icon(Icons.camera_alt_outlined),
                //                               Text("Take a photo")
                //                             ],
                //                           )),
                //                       const SizedBox(
                //                         height: 5,
                //                       ),
                //                       OutlinedButton(
                //                           style: OutlinedButton.styleFrom(
                //                               backgroundColor: Colors.white,
                //                               fixedSize: Size(
                //                                   MediaQuery.of(context)
                //                                       .size
                //                                       .width,
                //                                   50)),
                //                           onPressed: () {
                //                             _getFromgallary();
                //                             Navigator.pop(context);
                //                           },
                //                           child: const Row(
                //                             mainAxisAlignment:
                //                                 MainAxisAlignment.center,
                //                             children: [
                //                               Icon(CupertinoIcons
                //                                   .photo_on_rectangle),
                //                               Text("Upload from gallary")
                //                             ],
                //                           )),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             );
                //           },
                //           child: const Text("Add photo")),
                //     ),
                //     const SizedBox(
                //       width: 10,
                //     ),
                //     IconButton(
                //         onPressed: () {
                //           print(image!.path);
                //           showDialog(
                //             context: context,
                //             builder: (context) => AlertDialog(
                //               title: image == null
                //                   ? const Text("upload image")
                //                   : Image(image: FileImage(File(image!.path))),
                //             ),
                //           );
                //         },
                //         icon: const Icon(
                //           CupertinoIcons.eye,
                //           size: 30,
                //         ))
                //   ],
                // ),

                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    newDateTime != null
                        ? Text(
                            '${newDateTime!.day.toString()}/${newDateTime!.month.toString()}/${newDateTime!.year.toString()}')
                        : const Text('Select date'),
                    CustomButton(
                      text: newDateTime != null ? 'change' : 'select',
                      onPressed: () async {
                        newDateTime = await showRoundedDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 1),
                          lastDate: DateTime(DateTime.now().year + 1),
                          borderRadius: 16,
                        );
                        if (newDateTime != null) {
                          setState(() {});
                        }
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                const Text(
                  'Complaint',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: 'Add Complaint',
                  controller: _description,
                  borderColor: Colors.grey,
                  maxLines: 20,
                  minLines: 7,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _submit() async {
    setState(() {
      loading = true;
    });

    final date = DateFormat('dd-MM-yyyy').format(newDateTime!);
    await ApiServiece().bookService(
      context,
      DbService.getLoginId()!,
      date,
      _description.text,
    );
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DoctorBookingConfirmScreen(),
        ),
      );
    }
    setState(() {
      loading = false;
    });
  }
}
