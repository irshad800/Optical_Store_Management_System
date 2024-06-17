

import 'package:flutter/material.dart';

Color KmainColor = const Color.fromRGBO(255, 255, 255, 1);
Color KButtonColor =  Color(0xFF009688);
Color KtextColor = Colors.black;
Color kFieldBoarderColor = Colors.grey;


const indicator =  Center(
            child: CircularProgressIndicator(color: Colors.teal,),
          );


customSnackBar({
  required BuildContext context,
  required String  messsage,
}){

  return ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(messsage)));
}
