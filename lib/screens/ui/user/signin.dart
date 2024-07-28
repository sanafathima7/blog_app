// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_bloc/screens/ui/user/home.dart';
// import 'package:hive_bloc/screens/ui/user/homepage.dart';
// import 'package:hive_bloc/screens/ui/user/signup.dart';
// import 'package:hive_bloc/models/user.dart' as userPackage;

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool _isLoading = false;
//   String? _errorMessage;
//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
//                 'Welcome Back!! \nLet\'s Login',
//                 style: TextStyle(
//                   fontSize: 30,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 200.0),
//             child: Form(
//               key: _formKey,
//               child: Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(40),
//                     topLeft: Radius.circular(40),
//                   ),
//                 ),
//                 height: double.infinity,
//                 width: double.infinity,
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                     left: 18.0,
//                     right: 18,
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       TextFormField(
//                         controller: emailController,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your email';
//                           }
//                           return null;
//                         },
//                         decoration: const InputDecoration(
//                           suffixIcon: Icon(
//                             Icons.check,
//                             color: Colors.grey,
//                           ),
//                           label: Text(
//                             'Email',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xff881736),
//                             ),
//                           ),
//                         ),
//                       ),
//                       TextFormField(
//                         controller: passwordController,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your password';
//                           }
//                           return null;
//                         },
//                         obscureText: true,
//                         obscuringCharacter: '*',
//                         decoration: const InputDecoration(
//                           suffixIcon: Icon(
//                             Icons.visibility,
//                             color: Colors.grey,
//                           ),
//                           label: Text(
//                             'Password',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xff881736),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       const Align(
//                         alignment: Alignment.centerRight,
//                         child: Text(
//                           'Forgot Password',
//                           style: TextStyle(
//                             color: Color(0xff281537),
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 50,
//                       ),
//                       GestureDetector(
//                         onTap: () async {
//                           setState(() {
//                             _isLoading = true;
//                             _errorMessage = null;
//                           });

//                           try {
//                             var box = await Hive.openBox<userPackage.userList>(
//                                 'userdata');
//                             var users = box.values.toList();

//                             var user = users.firstWhere(
//                               (u) =>
//                                   u.email == emailController.text &&
//                                   u.password == passwordController.text,
//                               orElse: () => userPackage.userList(
//                                 username: '',
//                                 email: '',
//                                 password: '',
//                               ),
//                             );

//                             if (user.email.isNotEmpty &&
//                                 user.password.isNotEmpty) {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => Homepage(),
//                                   // emailController,passwordController),
//                                 ),
//                               );
//                             } else {
//                               setState(() {
//                                 _errorMessage = 'Incorrect email or password';
//                               });
//                             }
//                           } catch (e) {
//                             setState(() {
//                               _errorMessage = 'Error accessing user data: $e';
//                             });
//                           } finally {
//                             setState(() {
//                               _isLoading = false;
//                             });
//                           }
//                         },
//                         child: Container(
//                           height: 50,
//                           width: 300,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(30),
//                             gradient: const LinearGradient(
//                               colors: [
//                                 Color(0xff881736),
//                                 Color(0xff281537),
//                               ],
//                             ),
//                           ),
//                           child: Center(
//                             child: _isLoading
//                                 ? const CircularProgressIndicator(
//                                     color: Colors.white)
//                                 : const Text(
//                                     'LOG IN',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20,
//                                     ),
//                                   ),
//                           ),
//                         ),
//                       ),
//                       if (_errorMessage != null) ...[
//                         const SizedBox(height: 10),
//                         Text(
//                           _errorMessage!,
//                           style: const TextStyle(color: Colors.red),
//                         ),
//                       ],
//                       const SizedBox(
//                         height: 50,
//                       ),
//                       const Align(
//                         alignment: Alignment.centerRight,
//                         child: Text(
//                           'Don\'t have an account?',
//                           style: TextStyle(
//                             color: Color(0xff281537),
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const Signup(),
//                             ),
//                           );
//                         },
//                         child: const Align(
//                           alignment: Alignment.centerRight,
//                           child: Text(
//                             'Signup Here',
//                             style: TextStyle(
//                               color: Color(0xff281537),
//                               fontWeight: FontWeight.bold,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
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
import 'package:hive/hive.dart';
import 'package:hive_bloc/models/user.dart' as userPackage;
import 'package:hive_bloc/screens/bloc/login_bloc.dart';
import 'package:hive_bloc/screens/bloc/login_event.dart';
import 'package:hive_bloc/screens/bloc/login_state.dart';
import 'package:hive_bloc/screens/ui/user/homepage.dart';
import 'package:hive_bloc/screens/ui/user/signup.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const MainHomepage(), // Navigate to homepage
                ),
              );
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          builder: (context, state) {
            return Stack(
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
                      'Welcome Back!! \nLet\'s Login',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 200.0),
                  child: Form(
                    key: _formKey,
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
                        padding: const EdgeInsets.only(left: 18.0, right: 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                suffixIcon:
                                    Icon(Icons.check, color: Colors.grey),
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              obscureText: true,
                              obscuringCharacter: '*',
                              decoration: const InputDecoration(
                                suffixIcon:
                                    Icon(Icons.visibility, color: Colors.grey),
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
                            const SizedBox(height: 50),
                            GestureDetector(
                              onTap: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  BlocProvider.of<LoginBloc>(context).add(
                                    LoginButtonPressed(
                                      username: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  );
                                }
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
                                  child: state is LoginLoading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white)
                                      : const Text(
                                          'LOG IN',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            if (state is LoginFailure) ...[
                              const SizedBox(height: 10),
                              Text(
                                state.error,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                            const SizedBox(height: 50),
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Don\'t have an account?',
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
                                    builder: (context) => Signup(),
                                  ),
                                );
                              },
                              child: const Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Signup Here',
                                  style: TextStyle(
                                    color: Color(0xff281537),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
