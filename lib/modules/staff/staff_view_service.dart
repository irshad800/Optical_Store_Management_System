import 'package:flutter/material.dart';
import 'package:opticals/modules/staff/staff_service_details.dart';

import '../../service/api_services.dart';
import '../../widgets/custom_button.dart';

class StaffViewServiceScreen extends StatefulWidget {
  const StaffViewServiceScreen({Key? key}) : super(key: key);

  @override
  State<StaffViewServiceScreen> createState() => _StaffViewServiceScreenState();
}

class _StaffViewServiceScreenState extends State<StaffViewServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            title: const Text('Bookings'),
            centerTitle: true,
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: ApiServiece().fetchBookings(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<dynamic> bookings = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StaffServiceDeatilsScreen(
                                  details: bookings[index],
                                ),
                              ),
                            );
                          },
                          leading: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.book)),
                          title: Text(
                            bookings[index]['name'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(bookings[index]['date']),
                          trailing: CustomButton(
                            text: 'Accept',
                            onPressed: () async {
                              try {
                                await ApiServiece().updateServiceStatus(
                                  context,
                                  bookings[index]['_id'],
                                  bookings[index]['date'],
                                );

                                setState(() {});
                              } catch (e) {
                                setState(() {});
                              }
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
