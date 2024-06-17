import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:opticals/modules/user/product_list_screen.dart';

import '../../service/api_services.dart';
import '../../service/db_service.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';
import 'book_service_screen.dart';
import 'doctors_list_screen.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final categoryList = [
    'https://img.freepik.com/free-photo/sunglasses_1203-8703.jpg?size=626&ext=jpg&ga=GA1.1.1672774589.1699860837&semt=ais',
    'https://media.istockphoto.com/id/167201445/photo/eyeglasses-lenses.jpg?s=612x612&w=0&k=20&c=1c77nbfya0uJrB8JgizJzkI30VaD620ae0gxVJlHzHw=',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEX8mag8e19nKBnKr2iLF3rn3a0-YyIW049Q&usqp=CAU',
  ];

  final catNameList = ['sunglass', 'lens', 'frame'];

  final popularProduct = [
    'https://e7.pngegg.com/pngimages/299/791/png-clipart-sunglasses-eyewear-glasses-black-glasses-thumbnail.png',
    'https://img.freepik.com/free-photo/sunglasses_1203-8703.jpg?size=626&ext=jpg&ga=GA1.1.1672774589.1699860837&semt=ais',
    'https://img.freepik.com/free-photo/sunglasses_1203-8703.jpg?size=626&ext=jpg&ga=GA1.1.1672774589.1699860837&semt=ais'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: KButtonColor,
          leading: const Icon(
            Icons.shopping_cart,
            size: 30,
            color: Colors.white,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: KButtonColor,
          padding:
              const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 30),
          child: SizedBox(
            height: 49,
            child: CustomButton(
              color: Colors.white,
              texColor: Colors.teal,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookServiceScreen(),
                    ));
              },
              text: 'Book Service',
            ),
          ),
        ),
        Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 180,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    clipBehavior: Clip.hardEdge,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.amber),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        viewportFraction: 1,
                      ),
                      items: [
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-qrr9hN7mx4PugAh4vLAkACdDBSjbs3NFgA&usqp=CAU',
                      ].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return GestureDetector(
                              onTap: () {},
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(i),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 30),
                                  )),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    height: 50,
                    child: CustomButton(
                      text: 'Book  eye specialist',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DoctorListScreen(),
                          ),
                        );
                      },
                    ),
                  ),

                  //category
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Category',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    height: 150,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryList.length,
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductListNew(
                                        name: catNameList[index],
                                      ),
                                    ));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    color: KButtonColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(categoryList[index]),
                                      radius: 50,
                                    ),
                                    Text(
                                      catNameList[index],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            )),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Trending products',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),

                  FutureBuilder(
                    future: ApiServiece().fetchAllProduct(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        List<dynamic> productList =
                            snapshot.data as List<dynamic>;
                        return Container(
                          height: 150,
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: productList.length,
                            itemBuilder: (context, index) {
                              var product = productList[index];
                              print(product);
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        product['image'],
                                        width: 60,
                                        height: 60,
                                      ),
                                      Text(
                                        product['brand'],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      CustomButton(
                                        text: 'Add',
                                        onPressed: () {
                                          ApiServiece().addToCart(
                                              context,
                                              DbService.getLoginId()!,
                                              product['_id'],
                                              product['price'].toString());
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            )),
      ],
    );
  }
}
