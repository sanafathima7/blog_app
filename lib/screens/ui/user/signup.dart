// import 'package:flutter/material.dart';
// import 'package:hive_bloc/models/user.dart' as userPackage;
// import 'package:hive_bloc/screens/ui/user/signin.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hive/hive.dart';

// class Signup extends StatefulWidget {
//   const Signup({super.key});

//   @override
//   State<Signup> createState() => _SignupState();
// }

// class _SignupState extends State<Signup> {
//   final TextEditingController userNameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool _isLoading = false;
//   String? _errorMessage;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             height: double.infinity,
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Color(0xff881736),
//                   Color(0xff281537),
//                 ],
//               ),
//             ),
//             child: const Padding(
//               padding: EdgeInsets.only(top: 66.0, left: 20),
//               child: Text(
//                 'Hello!! \nLet\'s Register',
//                 style: TextStyle(
//                   fontSize: 30,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 180.0),
//             child: Container(
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(40),
//                   topLeft: Radius.circular(40),
//                 ),
//               ),
//               height: double.infinity,
//               width: double.infinity,
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   left: 18.0,
//                   right: 18,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     TextFormField(
//                       controller: userNameController,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your username';
//                         }
//                         return null;
//                       },
//                       decoration: const InputDecoration(
//                         suffixIcon: Icon(
//                           Icons.check,
//                           color: Colors.grey,
//                         ),
//                         label: Text(
//                           'Username',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xff881736),
//                           ),
//                         ),
//                       ),
//                     ),
//                     TextFormField(
//                       controller: emailController,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your email';
//                         }
//                         return null;
//                       },
//                       decoration: const InputDecoration(
//                         suffixIcon: Icon(
//                           Icons.check,
//                           color: Colors.grey,
//                         ),
//                         label: Text(
//                           'Email',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xff881736),
//                           ),
//                         ),
//                       ),
//                     ),
//                     TextFormField(
//                       controller: passwordController,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your password';
//                         }
//                         return null;
//                       },
//                       obscureText: true,
//                       obscuringCharacter: '*',
//                       decoration: const InputDecoration(
//                         suffixIcon: Icon(
//                           Icons.visibility,
//                           color: Colors.grey,
//                         ),
//                         label: Text(
//                           'Password',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xff881736),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     const Align(
//                       alignment: Alignment.centerRight,
//                       child: Text(
//                         'Forgot Password',
//                         style: TextStyle(
//                           color: Color(0xff281537),
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     GestureDetector(
//                       onTap: () async {
//                         setState(() {
//                           _isLoading = true;
//                           _errorMessage = null;
//                         });

//                         try {
//                           var box = await Hive.openBox<userPackage.userList>(
//                               'userdata');
//                           var newUser = userPackage.userList(
//                             username: userNameController.text,
//                             email: emailController.text,
//                             password: passwordController.text,
//                             //  id: , isBanned: null,
//                           );

//                           await box.add(newUser);
//                           await box.close();

//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => Login()),
//                           );
//                         } catch (e) {
//                           setState(() {
//                             _errorMessage = 'Error saving user data: $e';
//                           });
//                         } finally {
//                           setState(() {
//                             _isLoading = false;
//                           });
//                         }
//                       },
//                       child: Container(
//                         height: 50,
//                         width: 300,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           gradient: const LinearGradient(
//                             colors: [
//                               Color(0xff881736),
//                               Color(0xff281537),
//                             ],
//                           ),
//                         ),
//                         child: Center(
//                           child: _isLoading
//                               ? const CircularProgressIndicator(
//                                   color: Colors.white)
//                               : const Text(
//                                   'Sign Up',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 20,
//                                   ),
//                                 ),
//                         ),
//                       ),
//                     ),
//                     if (_errorMessage != null) ...[
//                       const SizedBox(height: 10),
//                       Text(
//                         _errorMessage!,
//                         style: const TextStyle(color: Colors.red),
//                       ),
//                     ],
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     const Align(
//                       alignment: Alignment.centerRight,
//                       child: Text(
//                         'Already have an account?',
//                         style: TextStyle(
//                           color: Color(0xff281537),
//                           fontSize: 12,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => Login()),
//                         );
//                       },
//                       child: const Align(
//                         alignment: Alignment.centerRight,
//                         child: Text(
//                           'SignIn Here',
//                           style: TextStyle(
//                             color: Color(0xff281537),
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_bloc/screens/bloc/register_bloc.dart';
import 'package:hive_bloc/screens/bloc/register_event.dart';
import 'package:hive_bloc/screens/bloc/register_state.dart';
import 'package:hive_bloc/screens/ui/user/signin.dart';

class Signup extends StatelessWidget {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SignupBloc(),
        child: Stack(
          children: [
            Container(
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
              child: const Padding(
                padding: EdgeInsets.only(top: 66.0, left: 20),
                child: Text(
                  'Hello!! \nLet\'s Register',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 180.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                    right: 18,
                  ),
                  child: BlocConsumer<SignupBloc, SignupState>(
                    listener: (context, state) {
                      if (state is SignupSuccess) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      } else if (state is SignupFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is SignupLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: userNameController,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.check,
                                color: Colors.grey,
                              ),
                              label: Text(
                                'Username',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff881736),
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.check,
                                color: Colors.grey,
                              ),
                              label: Text(
                                'Email',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff881736),
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            obscuringCharacter: '*',
                            decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.visibility,
                                color: Colors.grey,
                              ),
                              label: Text(
                                'Password',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff881736),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                color: Color(0xff281537),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<SignupBloc>(context).add(
                                SignupButtonPressed(
                                  username: userNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                            },
                            child: Container(
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xff881736),
                                    Color(0xff281537),
                                  ],
                                ),
                              ),
                              child: Center(
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Already have an account?',
                              style: TextStyle(
                                color: Color(0xff281537),
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                            child: const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'SignIn Here',
                                style: TextStyle(
                                  color: Color(0xff281537),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
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
