import 'package:flutter/material.dart';

import '../../service/api_services.dart';
import '../../service/db_service.dart';
import '../../widgets/custom_button.dart';

class UserProductDetailsScreen extends StatelessWidget {
  const UserProductDetailsScreen({Key? key, required this.productDetails})
      : super(key: key);

  final Map<String, dynamic> productDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: Card(
                color: Colors.white,
                elevation: .6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image: NetworkImage(productDetails['image']),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
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
                          productDetails['description'],
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
                            '${productDetails['price']}',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CustomButton(
                          text: 'Add to Cart',
                          onPressed: () async {
                            ApiServiece().addToCart(
                                context,
                                DbService.getLoginId()!,
                                productDetails['_id'],
                                productDetails['price'].toString());
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
