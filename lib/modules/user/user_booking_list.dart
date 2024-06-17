import 'package:flutter/material.dart';

import '../../service/api_services.dart';
import '../../service/db_service.dart';

class UserBookingList extends StatefulWidget {
  final String loginId;

  UserBookingList({Key? key, required this.loginId}) : super(key: key);

  @override
  _UserBookingListState createState() => _UserBookingListState();
}

class _UserBookingListState extends State<UserBookingList> {
  late Future<List<dynamic>> futureAppointments;
  late Future<List<dynamic>> futureDocServiceList;

  @override
  void initState() {
    super.initState();
    futureDocServiceList =
        ApiServiece().fetchDocBookings(DbService.getLoginId()!);
  }

  @override
  Widget build(BuildContext context) {
    print('dd');
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User Booking List'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Orders'),
              Tab(text: 'Service Booking'),
              Tab(text: 'Doctor Booking'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FutureBuilder<List<dynamic>>(
              future: ApiServiece().fetchOrdes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<dynamic> orders =
                      snapshot.data!.isEmpty ? [] : snapshot.data!;
                  return ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.teal),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.event),
                            title:
                                Text(orders[index]['products_data']['brand']),
                            subtitle: Text(
                                'Type: ${orders[index]['products_data']['type']}'),
                            trailing: Text(
                              'Price: र${orders[index]['products_data']['price']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
            // Placeholder for Service Booking tab
            FutureBuilder<List<dynamic>>(
              future: ApiServiece().fetchServiceBookings(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<dynamic> serviceBookings = snapshot.data!;
                  return ListView.builder(
                    itemCount: serviceBookings.length,
                    itemBuilder: (context, index) {
                      final booking = serviceBookings[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.teal),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.event),
                            title:
                                Text('Date ${serviceBookings[index]["date"]}'),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
            // Placeholder for Doctor Booking tab
            FutureBuilder<List<dynamic>>(
              future: ApiServiece().fetchDocBookingList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.teal,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return snapshot.data!.length == 0
                      ? const Center(
                          child: Text('no  data'),
                        )
                      : ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final appointment = snapshot.data![index];

                            print('==================================');

                            print(appointment);

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.teal),
                                ),
                                child: ListTile(
                                  leading: const Icon(Icons.event),
                                  title: Text('Name:${appointment['name']}'),
                                  subtitle: Text('Date:${appointment['date']}'),
                                ),
                              ),
                            );
                          },
                        );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
