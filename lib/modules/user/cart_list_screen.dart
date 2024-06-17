import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:opticals/modules/user/user_check_out_screen.dart';

import '../../service/api_services.dart';
import '../../service/db_service.dart';
import '../../widgets/cart_item_card.dart';
import '../../widgets/custom_button.dart';

class UserCartListScreen extends StatefulWidget {
  const UserCartListScreen({Key? key}) : super(key: key);

  @override
  State<UserCartListScreen> createState() => _UserCartListScreenState();
}

class _UserCartListScreenState extends State<UserCartListScreen> {
  late Future<List<dynamic>> _cartItems;

  @override
  void initState() {
    _cartItems = ApiServiece().fetchCartItems(DbService.getLoginId()!);
    getData();


    super.initState();
  }

  double total = 0;

  getData() async{

    

    List  cartitemsList = await ApiServiece().fetchCartItems(DbService.getLoginId()!);
   
   cartitemsList.forEach((element) {

    total =  double.parse(element['subtotal'].toString()) + total;

    setState(() {
      
    });
    

   });

    

  }



  int qty = 0;

  

  

  




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
                Text(
                  '₹$total',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CustomButton(
                text: 'Check Out',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckOut(total: total,),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _cartItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {

            
            final cartItems = snapshot.data!;




            
              

            return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];

                qty = item['quantity'];
                 
                
                return ItemCard(
                  name: item['brand'],
                  imageUrl: item['image'],
                  quantity: qty,
                  
                );
              },
            );
          }
        },
      ),
    );
  }
}
