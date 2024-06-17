import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';

import '../../service/api_services.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'doctor_booking_confirmation.dart';

class BookEyeSpecialist extends StatefulWidget {
  const BookEyeSpecialist({super.key, required this.docId});

  final String docId;

  @override
  State<BookEyeSpecialist> createState() => _BookEyeSpecialistState();
}

class _BookEyeSpecialistState extends State<BookEyeSpecialist> {
  final _userBookingFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  DateTime? newDateTime;

  bool loading =  false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book your doctor'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Form(
            key: _userBookingFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  'Name',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: 'Name',
                  controller: _nameController,
                  borderColor: Colors.grey,
                ),
                const Text(
                  'your age',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: 'Add your age',
                  controller: _ageController,
                  borderColor: Colors.grey,
                ),
                const SizedBox(
                  height: 20,
                ),
                loading ?  Center(child: CircularProgressIndicator(color: Colors.teal,),)  : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CustomButton(
                    text: 'Submit',
                    onPressed: () {
                      _submit();
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _submit() async{

    setState(() {
      loading = true;
    });

    String date =  DateFormat('dd-MM-yyyy').format(newDateTime!);

    

    

    await ApiServiece().bookDoctor(
      context,
      widget.docId,
      date
      );

      setState(() {
      loading = false;
    });


    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DoctorBookingConfirmScreen(),
      ),
    );
  }
}
