import 'package:flutter/material.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class DoctorBookingDetailsScreen extends StatefulWidget {
  const DoctorBookingDetailsScreen({super.key, required this.image});

  final String image;

  @override
  State<DoctorBookingDetailsScreen> createState() =>
      _DoctorBookingDetailsScreenState();
}

class _DoctorBookingDetailsScreenState
    extends State<DoctorBookingDetailsScreen> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(
                child: CustomButton(
              text: 'Reject',
              color: Colors.redAccent,
              onPressed: () {},
            )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: CustomButton(
              color: Colors.greenAccent,
              text: 'Accept',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Add commission'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextField(
                            borderColor: Colors.grey,
                            hintText: 'add',
                            controller: _controller),
                        CustomButton(
                          text: 'Add',
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(widget.image),
                ),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Card(
                child: Column(
                  children: [
                    const Text(
                      'Specification',
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
                                style: TextStyle(color: Colors.grey.shade500),
                              ),
                              const Spacer(),
                              const Text(
                                'sunglass',
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
                                'Booking date',
                                style: TextStyle(color: Colors.grey.shade500),
                              ),
                              const Spacer(),
                              const Text(
                                '10-3-2023',
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
                                'Description',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Description',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.grey.shade500),
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
