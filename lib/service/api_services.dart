import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../modules/staff/staff_home.dart';
import '../modules/user/cart_list_screen.dart';
import '../modules/user/user_order_confirm_screen.dart';
import 'db_service.dart';

class ApiServiece {
  static const baseUrl = 'https://optical-management-system.onrender.com';

  Future<void> registerUser(String name, String email, String phone,
      String password, BuildContext context) async {
    final url = Uri.parse('$baseUrl/api/register/user');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
        },
      );

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data['Message'])));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data['Message'])));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> loginUser(
      String email, String password, BuildContext context) async {
    final url = Uri.parse('$baseUrl/api/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'email': email,
          'password': password,
        },
      );

      print(url);

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        DbService.setLoginId(data['login_id']);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data['message'])));

        return data['role'];
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data['Message'])));
      }
    } catch (e) {
      rethrow;
    }
  }

//change password
  Future<void> changePassword(BuildContext context, String loginId,
      String password, String newPassword) async {
    final url = Uri.parse('$baseUrl/api/register/pass-change/$loginId');
    final body = {'password': password, 'new_password': newPassword};

    try {
      final response = await http.put(
        url,
        body: body,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        encoding: Encoding.getByName('utf-8'),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password changed successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to change password. Error: ${response.statusCode}'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error occurred: $e'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

//

  Future<List<dynamic>> fetchglasses(String cat) async {
    final url = Uri.parse('$baseUrl/api/view-prod/$cat');
    final response = await http.get(url);
    print(url);

    print(response.body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load!!!!');
    }
  }

  //view doctores

  Future<List<dynamic>> fetchDoctors() async {
    final response = await http.get(Uri.parse('$baseUrl/api/view-doctors'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return parsed['data'];
    } else {
      throw Exception('Failed to load doctors');
    }
  }

  //add cart

  Future<void> addToCart(BuildContext context, String loginId, String productId,
      String price) async {
    try {
      var url = Uri.parse('$baseUrl/api/user/add-cart/$loginId/$productId');

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: <String, String>{
          'price': price,
        },
      );

      if (response.statusCode == 200) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Item added'),
              action: SnackBarAction(
                label: 'go to cart',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserCartListScreen(),
                      ));
                },
              ),
            ),
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to add item to cart'),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error adding item to cart: $e'),
          ),
        );
      }
    }
  }

  Future<void> addUserAddress(
      String loginId, Map<String, dynamic> data, BuildContext context) async {
    final url = Uri.parse('$baseUrl/api/user/add-address/$loginId');

    print(url);
    try {
      final response = await http.post(
        url,
        body: data,
      );

      if (response.statusCode == 201) {
        // Request successful
        var data = jsonDecode(response.body)['data'];

        Navigator.pop(context, data);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Address added successfully')),
        );
      } else {
        // Request failed
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to add address. Please try again later.')),
        );
      }
    } catch (e) {
      // Exception occurred
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'An error occurred while adding the address. Please try again later.')),
      );
    }
  }

//place order

  Future<void> placeOrder(BuildContext context) async {
    try {
      var url = Uri.parse(
          '$baseUrl/api/user/place-order-prod/${DbService.getLoginId()}');
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Order placed sccessfully')),
          );

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OrderConfirmScreen(),
              ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Error placing order. Please try again later.')),
        );
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Error placing order. Please try again later.')),
      );
    }
  }

  Future<List<dynamic>> fetchUserOrdes() async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/view-order/${DbService.getLoginId()}'),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      print(jsonData);
      final List<dynamic> data = jsonData['Data'];
      return data;
    } else {
      throw Exception('Failed to load appointments');
    }
  }

  //
  Future<List<dynamic>> fetchCartItems(String loginId) async {
    final url = Uri.parse('$baseUrl/api/user/view-cart/$loginId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      return jsonData['data'];
    } else {
      throw Exception('Failed to load cart items');
    }
  }

  //fetch
  Future<List<dynamic>> fetchDocBookings(String loginId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/user/view-doc-booking/$loginId'),
    );

    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  //doc booking

  Future<void> bookDoctor(
      BuildContext context, String docId, String date) async {
    try {
      final response = await http.post(
        Uri.parse(
            '$baseUrl/api/user/doctor-booking/${DbService.getLoginId()}/$docId'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'date': date,
        },
      );

      print(docId);

      print(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('successful'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error making POST request: $e'),
        ),
      );
    }
  }

  //fetch all product
  Future<List<dynamic>> fetchAllProduct() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/view-prod'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  //book service
  Future<void> bookService(BuildContext context, String loginId, String date,
      String complaint) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/user/service-booking/$loginId'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'date': date,
          'complaint': complaint,
        },
      );

      print(Uri.parse('$baseUrl/api/user/service-booking/$loginId'));

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Service booking successful'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to make service booking. Status code: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error making service booking: $e'),
        ),
      );
    }
  }

//fetch orders
  Future<List<dynamic>> fetchOrdes() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/user/view-order/${DbService.getLoginId()}'),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body)['Data'];
    } else {
      throw Exception('Failed to load products');
    }
  }

  //view service
  Future<List<dynamic>> fetchServiceBookings() async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/api/user/view-service-booking/${DbService.getLoginId()}'),
    );

    print(Uri.parse(
        '$baseUrl/api/user/view-service-booking/${DbService.getLoginId()}'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load service bookings');
    }
  }

  //view doctor booking list
  Future<List<dynamic>> fetchDocBookingList() async {
    final url = Uri.parse(
        '${baseUrl}/api/user/view-doc-booking/${DbService.getLoginId()}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Request was successful
      // Parse the response body here if needed
      print('Response: ${response.body}');

      var data = jsonDecode(response.body)['data'];

      return data;
    } else {
      // Request failed

      throw Exception('Faild');
    }
  }

  //add
  Future<void> updateCartQuantity(BuildContext context, String loginId,
      String productId, int quantity) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/user/update-cart-quantity/$loginId/$productId'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'quantity': quantity.toString(),
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cart quantity updated successfully'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to update cart quantity. Status code: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating cart quantity: $e'),
        ),
      );
    }
  }

//add product

  Future<void> addProduct(
      {required BuildContext context,
      required String brand,
      required String model,
      required String color,
      required String material,
      required String price,
      required String type,
      required String description,
      required String imagePath}) async {
    // Define the URL
    Uri url = Uri.parse('$baseUrl/api/staff/new-prod');

    print(url);

    // Define the request body parameters
    var body = {
      'brand': brand,
      'model': model,
      'color': color,
      'material': material,
      'price': price,
      'description': description,
      'type': type,
    };

    try {
      // Show loading Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Adding product..."),
            ],
          ),
          duration: Duration(minutes: 1),
        ),
      );

      // Make the POST request
      var request = http.MultipartRequest('POST', url);

      request.files.add(
        await http.MultipartFile.fromPath('image', imagePath),
      );
      print(imagePath);

      request.fields.addAll(body);
      // Send the request
      var response = await request.send();
      print(response.statusCode);

      // Check if the request was successful
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Text("Success"),
              ],
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Text("Failed"),
              ],
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Text("failed"),
            ],
          ),
        ),
      );
    } finally {
      // Hide loading Snackbar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
  }

  //view services staff
  Future<List<dynamic>> fetchBookings() async {
    final response =
        await http.get(Uri.parse('$baseUrl/api/staff/view-service-bookings'));
    print(Uri.parse('$baseUrl/api/staff/view-service-bookings'));
    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  //update
  Future<void> updateServiceStatus(
      BuildContext context, String id, String bookedDate) async {
    // Define the URL
    String url = '$baseUrl/api/staff/update-service-stat/$id/$bookedDate';

    try {
      var response = await http.put(Uri.parse(url));

      if (response.statusCode == 200) {
        print(response.body);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Service status updated successfully'),
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => StaffHomeScreen(),
              ),
              (route) => false);
        }
      } else {
        // Show an error Snackbar
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Failed to update service status. Status code: ${response.statusCode}'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      // Show an error Snackbar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating service status: $e'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  //upadte attenedence
  Future<void> updateAttendance(
      String loginId, bool isPresent, BuildContext context) async {
    // Define the URL
    String url = '$baseUrl/api/staff/attendance-med/$loginId';

    // Define the request body parameter
    var body = {
      'isPresent': isPresent.toString(),
    };

    try {
      // Make the PUT request
      var response = await http.put(Uri.parse(url), body: body);

      // Check if the request was successful
      if (response.statusCode == 200) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Attendedns successfully'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Faild'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Attendedns faild!!!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

//get profile
  Future<List<dynamic>> getStaffProfile(String loginId) async {
    final url = '$baseUrl/api/profile/staff/$loginId';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['data'];
      } else {
        throw Exception('Somthing went wrong');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> fetchDocBooking(String doctorId) async {
    final response = await http
        .get(Uri.parse('$baseUrl/api/doctor/view-bookings/$doctorId'));

    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  Future<void> updateBookingStatus(
      BuildContext context, String id, String bookedDate) async {
    // Show loading snack bar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16.0),
            Text('Updating booking status...'),
          ],
        ),
      ),
    );

    // Replace the URL with your actual API endpoint
    final url =
        Uri.parse('$baseUrl/api/doctor/update-booking-stat/$id/$bookedDate');

    try {
      // Make the PUT request
      final response = await http.put(url);

      // Check the response status code
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Booking status updated successfully'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to update booking status. Status code: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      // Hide the loading snack bar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
        ),
      );
    }
  }
}
