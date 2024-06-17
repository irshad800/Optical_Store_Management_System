import 'package:flutter/material.dart';
import 'package:opticals/modules/user/product_Details_screen.dart';

import '../../service/api_services.dart';
import '../../service/db_service.dart';
import '../../widgets/custom_button.dart';

class ProductListNew extends StatefulWidget {
  const ProductListNew({Key? key, required this.name}) : super(key: key);

  final String? name;

  @override
  State<ProductListNew> createState() => _ProductListNewState();
}

class _ProductListNewState extends State<ProductListNew> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 70,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          widget.name ?? 'category',
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey)),
              child: const Icon(
                Icons.search,
                size: 25,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: ApiServiece().fetchglasses(widget.name!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Colors.teal));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<dynamic> products = snapshot.data!;
            return GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: products.length,
              itemBuilder: (context, index) {
                var product = products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProductDetailsScreen(
                            productDetails: product,
                          ),
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            alignment: Alignment.center,
                            child: Image.network(
                              product['image'],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 15, left: 15, bottom: 15, top: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  product['brand'],
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    product['description'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '₹${product['price']}',
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade200,
                                              spreadRadius: 1,
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: CustomButton(
                                          text: 'Add',
                                          onPressed: () async {
                                            print(DbService.getLoginId());

                                            await ApiServiece().addToCart(
                                                context,
                                                DbService.getLoginId()!,
                                                product['_id'],
                                                product['price'].toString());
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .6,
              ),
            );
          }
        },
      ),
    );
  }
}
