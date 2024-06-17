import 'package:flutter/material.dart';
import 'package:opticals/modules/auth/user_registration.dart';

import '../../service/api_services.dart';
import '../../utils/constants.dart';
import '../../utils/validator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../doctor/doctor_home_screen.dart';
import '../staff/staff_home.dart';
import '../user/user_root_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(color: Colors.white),
  );

  String? emailError;
  String? passwordError;
  bool loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Login',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                CustomTextField(
                  hintText: 'Enter Email',
                  controller: _emailController,
                  borderColor: Colors.grey.shade300,
                  validator: (value) {
                    return validateEmail(value);
                  },
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  hintText: 'Enter password',
                  controller: _passwordController,
                  errorText: passwordError,
                  obscureText: _obscureText,
                  borderColor: Colors.grey.shade300,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  validator: (value) => validatePassword(value),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forget password',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: CustomButton(
                          text: 'LOG IN',
                          color: KButtonColor,
                          onPressed: () {
                            _loginHandler();
                          },
                        ),
                      ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Dont have an account?',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const UserRegistrationScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: KButtonColor, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loginHandler() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          loading = true;
        });

        var role = await ApiServiece().loginUser(
            _emailController.text, _passwordController.text, context);
        print(role);
        if (role == 2) {
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const UserRootScreen(),
              ),
              (route) => false,
            );
          }
        }

        if (role == 3) {
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const StaffHomeScreen(),
              ),
              (route) => false,
            );
          }
        }
        if (role == 4) {
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const DoctorHomeScreen(),
              ),
              (route) => false,
            );
          }
        }

        setState(() {
          loading = false;
        });
      } catch (e) {
        setState(() {
          loading = false;
        });

        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Somthing went wronng')));
        }
      }
    }

    // if (_emailController.text.trim() == 'user@gmail.com') {
    //   Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const UserRootScreen(),
    //     ),
    //     (route) => false,
    //   );
    // }

    // if (_emailController.text.trim() == 'staff@gmail.com') {
    //   Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const StaffHomeScreen(),
    //     ),
    //     (route) => false,
    //   );
    // }

    // if (_emailController.text.trim() == 'doctor@gmail.com') {
    //Navigator.pushAndRemoveUntil(
    // context,
    //MaterialPageRoute(
    //builder: (context) => const DoctorHomeScreen(),
    //),
    //   (route) => false,
    //);
    //  }
  }
}
