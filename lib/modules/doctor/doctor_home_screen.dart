import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../widgets/custom_card.dart';
import '../auth/login.dart';
import 'doctor_booking_list_screen.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: KButtonColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
          child: Center(
        child: Row(
          children: [
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width / 2,
              child: CardWidget(
                iconData: CupertinoIcons.eye,
                title: 'View Booking',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorBookingListScreen(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width / 2,
              child: CardWidget(
                iconData: Icons.logout,
                title: 'Logout',
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      (route) => false);
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
