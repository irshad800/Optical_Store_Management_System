import 'package:action_slider/action_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:opticals/modules/staff/staff_add_frames.dart';
import 'package:opticals/modules/staff/staff_add_glasses.dart';
import 'package:opticals/modules/staff/staff_add_lense_screen.dart';
import 'package:opticals/modules/staff/staff_view_orders.dart';
import 'package:opticals/modules/staff/staff_view_service.dart';

import '../../service/api_services.dart';
import '../../service/db_service.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_card.dart';
import '../auth/login.dart';

class StaffHomeScreen extends StatefulWidget {
  const StaffHomeScreen({Key? key}) : super(key: key);

  @override
  State<StaffHomeScreen> createState() => _StaffHomeScreenState();
}

class _StaffHomeScreenState extends State<StaffHomeScreen> {
  bool loading = false;
  bool isAttend = false;

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  void getProfile() async {
    try {
      setState(() {
        loading = false;
      });

      List data = await ApiServiece().getStaffProfile(DbService.getLoginId()!);

      var today =
          "${DateTime.now().day}/0${DateTime.now().month}/${DateTime.now().year}";

      data[0]['attendance'].forEach((e) {
        isAttend = e['date'] == today;
      });

      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

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
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: [
                        CardWidget(
                          iconData: Icons.add,
                          title: 'Add Glass',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StaffAddGlassScreen(),
                                ));
                          },
                        ),
                        CardWidget(
                          iconData: Icons.rectangle_outlined,
                          title: 'Add Frame',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return StaffAddFrameScreen();
                            }));
                          },
                        ),
                        CardWidget(
                          iconData: Icons.lens_outlined,
                          title: 'Add Lens',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const StaffAddLenseScreen(),
                              ),
                            );
                          },
                        ),
                        CardWidget(
                          iconData: CupertinoIcons.cart_badge_plus,
                          title: 'View Orders',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StaffViewOrdersScreen(),
                              ),
                            );
                          },
                        ),
                        CardWidget(
                          iconData: Icons.playlist_add_check,
                          title: 'View Service',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StaffViewServiceScreen(),
                              ),
                            );
                          },
                        ),
                        CardWidget(
                            iconData: Icons.logout,
                            title: 'Logout',
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                  (route) => false);
                            }),
                      ],
                    ),
                  ),
                ),
                isAttend
                    ? SizedBox()
                    : ActionSlider.standard(
                        backgroundColor: KButtonColor,
                        toggleColor: Colors.white,
                        backgroundBorderRadius: BorderRadius.circular(0.0),
                        rolling: true,
                        action: (controller) async {
                          controller.loading();
                          String url =
                              '${ApiServiece.baseUrl}/api/staff/attendance-staff/${DbService.getLoginId()}';

                          // Define the request body parameter
                          var body = {
                            'isPresent': 'true',
                          };

                          // Make the PUT request
                          var response =
                              await http.put(Uri.parse(url), body: body);

                          // Check if the request was successful
                          if (response.statusCode == 200) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Attendance recorded successfully'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              controller.success();
                            }
                          } else {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Failed to record attendance'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          }
                        },
                        child: const Text(
                          'Slide to add attendance',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
              ],
            ),
    );
  }
}
