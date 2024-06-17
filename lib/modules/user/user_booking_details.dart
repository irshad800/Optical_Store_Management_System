import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../doctor/doctor_booking_list_screen.dart';

class BookingDetailsScreen extends StatelessWidget {
  TextEditingController _prescriptionController = TextEditingController();
  BookingDetailsScreen({Key? key, required this.details}) : super(key: key);
  final Map<String, dynamic> details;

  @override
  Widget build(BuildContext context) {
    print('dddddddddddddddddddddd');
    print(details);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('Booking Details'), // Removed const here
        backgroundColor: Colors.grey.shade200,
      ),
      body: SingleChildScrollView( // Wrap your Column with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10), // Removed const here
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        details['name'],
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Divider(indent: 15, endIndent: 15), // Removed const here
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10), // Removed const here
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Phone',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        details['phone'],
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Divider(indent: 15, endIndent: 15), // Removed const here
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10), // Removed const here
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Booking Date',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        details['date'],
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  height: 200, // Adjust the height as needed
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      controller: _prescriptionController,
                      maxLines: 10,
                      decoration: InputDecoration(
                        labelText: 'Prescription',
                        hintText: 'Write prescription here...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: BorderSide(
                            color: Colors.teal, // You can change the border color here
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.teal, // You can change the border color here
                            width: 2.0, // You can adjust the border width here
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      String prescription = _prescriptionController.text;
                      // Perform any action with the prescription data here
                      print('Prescription submitted: $prescription');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorBookingListScreen(),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Prescription added successfully'), // Corrected spelling
                          duration: Duration(seconds: 2), // Adjust the duration as needed
                        ),
                      );
                    },
                    child: Text('Submit Prescription'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
