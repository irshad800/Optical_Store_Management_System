import 'package:flutter/material.dart';

class StaffViewOrderDetailScreen extends StatefulWidget {
  const StaffViewOrderDetailScreen(
      {Key? key,
      required this.name,
      required this.email,
      required this.phone,
      required this.productdata,
        required this.quantity, required this.price});

  final String name;
  final String email;
  final String phone;
  final String quantity;
  final String price;
  final Map<String, dynamic> productdata;

  @override
  State<StaffViewOrderDetailScreen> createState() =>
      _StaffViewOrderDetailScreenState();
}

class _StaffViewOrderDetailScreenState
    extends State<StaffViewOrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              'Name: ${widget.name}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Email: ${widget.email}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'phone: ${widget.phone}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Product: ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children:  [
                  ListTile(
                    title: Text('Brand:  ${widget.productdata['brand']}'),
                    subtitle: Text(
                        'Model:${widget.productdata['model']}'), // Replace with actual product details
                  // Replace with actual product details
                  ),
                  ListTile(
                    title: Text('Type:  ${widget.productdata['type']}'),
                    subtitle: Text(
                        'Colour:${widget.productdata['color']}'), // Replace with actual product details
                    // Replace with actual product details
                  ),
                  ListTile(
                    title: Text('Quantity:  ${widget.quantity}'),
                    ), // Replace with actual product details
                    // Replace with actual product details

                  ListTile(
                    title: Text('Material:  ${widget.productdata['material']}'),
                    subtitle: Text(
                        'Price:${widget.productdata['price']}'), // Replace with actual product details
                    // Replace with actual product details
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Total Price: \₹${int.parse(widget.quantity)*int.parse(widget.price)} ', // Replace with actual total price
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
