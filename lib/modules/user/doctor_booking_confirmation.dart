import 'package:flutter/material.dart';
import 'package:opticals/modules/user/user_root_screen.dart';

import '../../../widgets/custom_button.dart';
import '../../utils/constants.dart';

class DoctorBookingConfirmScreen extends StatefulWidget {
  const DoctorBookingConfirmScreen({super.key});

  @override
  State<DoctorBookingConfirmScreen> createState() =>
      _DoctorBookingConfirmScreenState();
}

class _DoctorBookingConfirmScreenState
    extends State<DoctorBookingConfirmScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(
      height: 20,
    );
    return Scaffold(
      backgroundColor: KButtonColor,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(
            Icons.check_circle,
            size: 80,
            color: Colors.white,
          ),
          sizedBox,
          const Text(
            'Your order has been received',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Order status',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 5,
          ),
          sizedBox,
          SizedBox(
            width: 200,
            child: CustomButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserRootScreen(),
                    ),
                    (route) => false);
              },
              text: 'Home',
              color: Colors.white,
              texColor: KButtonColor,
            ),
          )
        ]),
      ),
    );
  }
}
