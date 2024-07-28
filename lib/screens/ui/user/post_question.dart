import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_bloc/models/post.dart' as postPackage;
import 'package:hive_bloc/screens/ui/user/home.dart';
import 'package:hive_bloc/screens/ui/user/homepage.dart';

class post extends StatefulWidget {
  post({super.key});

  @override
  State<post> createState() => _postState();
}

class _postState extends State<post> {
  final TextEditingController questionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authIdController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 18),
              child: const Text(
                'Post',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, left: 8.0, right: 8.0),
                      child: Container(
                        width: 600,
                        height: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 233, 232, 232),
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: titleController,
                              minLines: 1,
                              maxLines: 1,
                              textAlign: TextAlign.justify,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.title),
                                prefixIconColor: Colors.black54,
                                label: Text(
                                  'Type your Title... ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: questionController,
                              minLines: 1,
                              maxLines: 5,
                              textAlign: TextAlign.justify,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.question_answer),
                                prefixIconColor: Colors.black54,
                                label: Text(
                                  'Type your Question... ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 170.0),
                                  child: GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        _isLoading = true;
                                        _errorMessage = null;
                                      });

                                      try {
                                        var box1 = await Hive.openBox<
                                            postPackage
                                            .postedQuestion>('postdata');
                                        var newPost =
                                            postPackage.postedQuestion(
                                          content: questionController.text,
                                          title: titleController.text,
                                          authId: 1, answer: '',
                                          isPublished: false,
                                          //  id: , isBanned: null,
                                        );

                                        await box1.add(newPost);
                                        await box1.close();

                                        // ignore: use_build_context_synchronously
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MainHomepage()),
                                        );
                                      } catch (e) {
                                        setState(() {
                                          _errorMessage =
                                              'Error saving user data: $e';
                                        });
                                      } finally {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xff881736),
                                            Color(0xff281537),
                                          ],
                                        ),
                                      ),
                                      child: _isLoading
                                          ? const CircularProgressIndicator(
                                              color: Colors.white)
                                          : const Center(
                                              child: Text(
                                                'POST',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 170.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MainHomepage()),
                                      );
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xff881736),
                                            Color(0xff281537),
                                          ],
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'GO BACK',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_bloc/models/post.dart' as postPackage;
// import 'package:hive_bloc/screens/bloc/post_bloc.dart';
// import 'package:hive_bloc/screens/bloc/post_event.dart';
// import 'package:hive_bloc/screens/bloc/post_state.dart';
// import 'package:hive_bloc/screens/ui/user/homepage.dart';

// class Post extends StatelessWidget {
//   const Post({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController questionController = TextEditingController();
//     final TextEditingController titleController = TextEditingController();

//     return BlocProvider(
//       create: (_) => PostBloc(),
//       child: Scaffold(
//         body: BlocConsumer<PostBloc, PostState>(
//           listener: (context, state) {
//             if (state is PostSuccess) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => MainHomepage()),
//               );
//             } else if (state is PostError) {
//               showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: Text('Error'),
//                   content: Text(state.error),
//                   actions: [
//                     TextButton(
//                       onPressed: () => Navigator.of(context).pop(),
//                       child: Text('OK'),
//                     ),
//                   ],
//                 ),
//               );
//             }
//           },
//           builder: (context, state) {
//             return Stack(
//               children: [
//                 Container(
//                   height: double.infinity,
//                   width: double.infinity,
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Color(0xff881736),
//                         Color(0xff281537),
//                       ],
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 30.0, left: 18),
//                     child: const Text(
//                       'Post',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 25,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 100.0),
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.only(
//                         topRight: Radius.circular(40),
//                         topLeft: Radius.circular(40),
//                       ),
//                     ),
//                     height: double.infinity,
//                     width: double.infinity,
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                         left: 18.0,
//                         right: 18,
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 12.0, left: 8.0, right: 8.0),
//                             child: Container(
//                               width: 600,
//                               height: 400,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 color: const Color.fromARGB(255, 233, 232, 232),
//                               ),
//                               child: Column(
//                                 children: [
//                                   TextFormField(
//                                     controller: titleController,
//                                     minLines: 1,
//                                     maxLines: 1,
//                                     textAlign: TextAlign.justify,
//                                     decoration: InputDecoration(
//                                       prefixIcon: Icon(Icons.title),
//                                       prefixIconColor: Colors.black54,
//                                       label: Text(
//                                         'Type your Title... ',
//                                         style: TextStyle(
//                                           fontSize: 15,
//                                           color: Colors.black87,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 15,
//                                   ),
//                                   TextFormField(
//                                     controller: questionController,
//                                     minLines: 1,
//                                     maxLines: 5,
//                                     textAlign: TextAlign.justify,
//                                     decoration: const InputDecoration(
//                                       prefixIcon: Icon(Icons.question_answer),
//                                       prefixIconColor: Colors.black54,
//                                       label: Text(
//                                         'Type your Question... ',
//                                         style: TextStyle(
//                                           fontSize: 15,
//                                           color: Colors.black87,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(top: 170.0),
//                                         child: GestureDetector(
//                                           onTap: () {
//                                             final postBloc =
//                                                 BlocProvider.of<PostBloc>(
//                                                     context);
//                                             postBloc.add(PostSubmitted(
//                                               title: titleController.text,
//                                               content: questionController.text,
//                                             ));
//                                           },
//                                           child: Container(
//                                             height: 50,
//                                             width: 150,
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(30),
//                                               gradient: const LinearGradient(
//                                                 colors: [
//                                                   Color(0xff881736),
//                                                   Color(0xff281537),
//                                                 ],
//                                               ),
//                                             ),
//                                             child: state is PostLoading
//                                                 ? const CircularProgressIndicator(
//                                                     color: Colors.white)
//                                                 : const Center(
//                                                     child: Text(
//                                                       'POST',
//                                                       style: TextStyle(
//                                                         color: Colors.white,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize: 20,
//                                                       ),
//                                                     ),
//                                                   ),
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(top: 170.0),
//                                         child: GestureDetector(
//                                           onTap: () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       MainHomepage()),
//                                             );
//                                           },
//                                           child: Container(
//                                             height: 50,
//                                             width: 150,
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(30),
//                                               gradient: const LinearGradient(
//                                                 colors: [
//                                                   Color(0xff881736),
//                                                   Color(0xff281537),
//                                                 ],
//                                               ),
//                                             ),
//                                             child: const Center(
//                                               child: Text(
//                                                 'GO BACK',
//                                                 style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 20,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
