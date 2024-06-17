import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../service/api_services.dart';
import '../../../service/db_service.dart';
import '../../../widgets/custom_text_field.dart';
import '../../auth/login.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({Key? key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();


  Future<Map<String, dynamic>> _fetchUserData() async {
    final response = await http.get(Uri.parse('${ApiServiece.baseUrl}/api/profile/user/${DbService.getLoginId()!}'));
    print(response.body);

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'][0];
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchUserData(),
      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final userData = snapshot.data!;
          _nameController.text = userData['name'];
          _emailController.text= userData['email'];
          _phoneController.text=userData['phone'];
          // You can similarly assign other user data to respective fields

          return Center(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    Text('logout'),
                    IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
                      },
                      icon: Icon(Icons.logout),
                    )
                  ],
                ),
                const CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D'),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomTextField(
                    hintText: 'name',
                    controller: _nameController,
                    isEnabled: false,
                    borderColor: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomTextField(
                    hintText: 'email',
                    controller: _emailController,
                    isEnabled: false,
                    borderColor: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomTextField(
                    hintText: 'phone',
                    controller: _phoneController,
                    isEnabled: false,
                    borderColor: Colors.grey.shade500,
                  ),
                ),


                const SizedBox(height: 20),
                // Similar CustomTextField widgets for other user data (email, phone, etc.)
                SizedBox(height: 30),
                //Container(
                  //padding: const EdgeInsets.symmetric(horizontal: 10),
                  //width: MediaQuery.of(context).size.width,
                  //child: CustomButton(
                    //text: 'Edit',
                    //color: Colors.teal,
                    //onPressed: () {
                      //Navigator.push(
                        //context,
                        //MaterialPageRoute(
                          //builder: (context) => UserEditProfileScreen(),
                        //),
                      //);
                    //},
                 // ),
               // )
              ],
            ),
          );
        }
      },
    );
  }
}
