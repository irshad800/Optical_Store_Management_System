import 'package:flutter/material.dart';

import '../../service/api_services.dart';
import '../../service/db_service.dart';
import '../../widgets/custom_button.dart';
import '../user/user_booking_details.dart';

class DoctorBookingListScreen extends StatefulWidget {
  const DoctorBookingListScreen({super.key});

  @override
  State<DoctorBookingListScreen> createState() =>
      _DoctorBookingListScreenState();
}

class _DoctorBookingListScreenState extends State<DoctorBookingListScreen> {
  String doctorId =
      'your_doctor_id_here'; // Replace 'your_doctor_id_here' with the actual doctor ID
  late Future<List<dynamic>> bookings;

  @override
  void initState() {
    super.initState();
    bookings = ApiServiece().fetchDocBooking(DbService.getLoginId()!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Booking List'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: bookings,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final booking = snapshot.data![index];
                print(booking);
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.book),
                      title: Text(booking['date']),
                      trailing: CustomButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingDetailsScreen(
                                details: booking,
                              ),
                            ),
                          );
                        },
                        text: 'View More',
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
