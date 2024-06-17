import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:opticals/modules/staff/staff_view_order_details.dart';

import '../../service/api_services.dart';
import '../../widgets/custom_button.dart';

class StaffViewOrdersScreen extends StatefulWidget {
  const StaffViewOrdersScreen({Key? key}) : super(key: key);

  @override
  State<StaffViewOrdersScreen> createState() => _StaffViewOrdersScreenState();
}

class _StaffViewOrdersScreenState extends State<StaffViewOrdersScreen> {
  late Future<List<dynamic>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = fetchOrders();
  }

  Future<List<dynamic>> fetchOrders() async {
    print(Uri.parse('${ApiServiece.baseUrl}/api/staff/view-orders'));

    final response = await http
        .get(Uri.parse('${ApiServiece.baseUrl}/api/staff/view-orders'));
    print(response.body);

    if (response.statusCode == 200) {
      return json.decode(response.body)['Data'];
    } else {
      throw Exception('Failed to load orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Orders'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<dynamic> serviceBookings = snapshot.data!;
            print(serviceBookings);
            return ListView.builder(
              itemCount: serviceBookings.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.event),
                      title: Text(
                          'Name: ${serviceBookings[index]['address']['name']}'),
                      trailing: CustomButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    StaffViewOrderDetailScreen(
                                  name: serviceBookings[index]['address']
                                      ['name'],
                                  email: serviceBookings[index]['login_data']
                                      ['email'],
                                  phone: serviceBookings[index]['address']
                                      ['phone'],
                                  productdata: serviceBookings[index]
                                      ['products_data'],
                                  price: serviceBookings[index]['price']
                                      .toString(),
                                  quantity: serviceBookings[index]['quantity']
                                      .toString(),
                                ),
                              ));
                        },
                        text: 'view more',
                      ),
                      // Add more ListTile content here based on your API response
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
