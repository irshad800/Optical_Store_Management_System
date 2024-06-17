import 'package:flutter/material.dart';

import '../../service/api_services.dart';
import '../../widgets/custom_button.dart';
import 'book_eye_specialist.dart';

class DoctorListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor List'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: ApiServiece().fetchDoctors(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<dynamic> doctors = snapshot.data!;
            return ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                var doctor = doctors[index];
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(doctor['name']),
                    subtitle: Text(doctor['email']),
                    trailing: CustomButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookEyeSpecialist(
                                    docId: doctor['login_id'])));
                      },
                      text: 'Book Now',
                    ),
                    onTap: () {
                      // Add navigation logic here
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
