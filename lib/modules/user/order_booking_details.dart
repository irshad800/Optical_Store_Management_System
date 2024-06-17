import 'package:flutter/material.dart';

import '../../widgets/custom_button.dart';

class OrderBookingDetailsScreen extends StatefulWidget {
  const OrderBookingDetailsScreen({super.key});

  @override
  State<OrderBookingDetailsScreen> createState() =>
      _OrderBookingDetailsScreenState();
}

class _OrderBookingDetailsScreenState extends State<OrderBookingDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Card(
              elevation: .6,
              color: Colors.white,
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(fontSize: 18),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                      thickness: .6,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Expanded(
                      child: Text(
                        'werty',
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 6,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'price',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CustomButton(
                        text: 'Add to Cart',
                        onPressed: () async {},
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
