import 'package:flutter/material.dart';

import '../../service/api_services.dart';
import '../../widgets/custom_button.dart';

class StaffServiceDeatilsScreen extends StatefulWidget {
  const StaffServiceDeatilsScreen({super.key, required this.details});

  final Map<String, dynamic> details;

  @override
  State<StaffServiceDeatilsScreen> createState() =>
      _StaffServiceDeatilsScreenState();
}

class _StaffServiceDeatilsScreenState extends State<StaffServiceDeatilsScreen> {
  final _controller = TextEditingController();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            //Expanded(child: CustomButton(
            // text: 'Reject',
            // color: Colors.redAccent,
            // onPressed: () {

            //},
            //)),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: CustomButton(
              color: Colors.greenAccent,
              text: 'Accept',
              onPressed: () async {
                try {
                  setState(() {
                    loading = true;
                  });

                  await ApiServiece().updateServiceStatus(
                      context, widget.details['_id'], widget.details['date']);

                  setState(() {
                    loading = false;
                  });
                } catch (e) {
                  setState(() {
                    loading = false;
                  });
                }
              },
            ))
          ],
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    child: Card(
                      child: Column(
                        children: [
                          const Text(
                            'Details',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Name',
                                      style: TextStyle(
                                          color: Colors.grey.shade500),
                                    ),
                                    const Spacer(),
                                    Text(
                                      widget.details['name'],
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.black),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'phone',
                                      style: TextStyle(
                                          color: Colors.grey.shade500),
                                    ),
                                    const Spacer(),
                                    Text(
                                      widget.details['phone'],
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Booking date',
                                      style: TextStyle(
                                          color: Colors.grey.shade500),
                                    ),
                                    const Spacer(),
                                    Text(
                                      widget.details['date'],
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.black),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Complaint',
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget.details['complaint'],
                                      maxLines: 20,
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey.shade500),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ),
    );
  }
}
