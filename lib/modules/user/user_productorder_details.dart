import 'package:flutter/material.dart';

class UserProductOrderDetails extends StatefulWidget {
  const UserProductOrderDetails({Key? key}) : super(key: key);


  @override
  State<UserProductOrderDetails> createState() => _UserProductOrderDetailsState();
}

class _UserProductOrderDetailsState extends State<UserProductOrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Number: ABC123',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Order Date: January 1, 2022',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Products:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildProductItem('Product 1', 'Description 1', 100),
            _buildProductItem('Product 2', 'Description 2', 150),
            _buildProductItem('Product 3', 'Description 3', 200),
            SizedBox(height: 16),
            Text(
              'Total: \$450',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(String name, String description, double price) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 4),
        Text(
          'Price: \$${price.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 14),
        ),
        Divider(),
      ],
    );
  }
}
