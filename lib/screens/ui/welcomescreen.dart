import 'package:flutter/material.dart';
import 'package:hive_bloc/screens/ui/admin/admin_login.dart';
import 'package:hive_bloc/screens/ui/user/signin.dart';
import 'package:hive_bloc/screens/ui/user/signup.dart';

class Welcomscreen extends StatelessWidget {
  const Welcomscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff881736),
              Color(0xff281537),
            ],
          ),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 80.0),
              child:
                  // Image(
                  //   image: AssetImage('assets/letsconnect.jpg'),
                  //   height: 100,
                  //   width: 50,r
                  // ),
                  Text(
                'Let\'s Connect',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            const Text(
              'Welcome Back',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminLogin(),
                  ),
                );
              },
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.white,
                  ),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff881736),
                      Color(0xff281537),
                    ],
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Admin',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,

                  // gradient: const LinearGradient(
                  //   colors: [
                  //     Color(0xff881736),
                  //     Color(0xff281537),
                  //   ],
                  // ),
                ),
                child: const Center(
                  child: Text(
                    'User',
                    style: TextStyle(
                      color: Colors.black,
                      // fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 90,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Don\'t have an account???',
                style: TextStyle(
                  color: Colors.white,
                  // fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Signup(),
                  ),
                );
              },
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  'SignIn Here',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
