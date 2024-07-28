import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_bloc/models/post.dart';
import 'package:hive_bloc/screens/ui/admin/admin_user.dart';
import 'package:hive_bloc/screens/ui/admin/admin_verification.dart';
import 'package:hive_bloc/screens/ui/search.dart';
import 'package:hive_bloc/models/post.dart' as postPackage;

class AdminHomepage extends StatefulWidget {
  final bool flag;
  const AdminHomepage({Key? key, required this.flag}) : super(key: key);

  @override
  _AdminHomepageState createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    AdminVerification(),
    AdminUserList(),
    Search(),
  ];

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
            child: const Padding(
              padding: EdgeInsets.only(top: 30.0, left: 18),
              child: Text(
                'Homepage',
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
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    if (widget.flag)
                      const Center(
                        child: Text('No saved questions'),
                      )
                    else
                      Expanded(
                        child: FutureBuilder<Box<postPackage.postedQuestion>>(
                          future: Hive.openBox<postPackage.postedQuestion>(
                              'postdata'),
                          builder: (BuildContext context,
                              AsyncSnapshot<Box<postPackage.postedQuestion>>
                                  snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              }

                              var box = snapshot.data;
                              if (box != null && box.isNotEmpty) {
                                return ListView.builder(
                                  itemCount: box.length,
                                  itemBuilder: (context, index) {
                                    var postedQuestion = box.getAt(index);
                                    if (postedQuestion != null) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(top: 18.0),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: Container(
                                            height: 100,
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 204, 204, 204),
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(40),
                                                topLeft: Radius.circular(40),
                                                bottomLeft: Radius.circular(40),
                                                bottomRight:
                                                    Radius.circular(40),
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  title: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12.0,
                                                            top: 5.0),
                                                    child: Text(
                                                      'title: ${postedQuestion.title}',
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  subtitle: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12.0,
                                                            top: 5.0),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                            'content: ${postedQuestion.content}'),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                if (postedQuestion.isPublished)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12.0,
                                                            top: 5.0),
                                                    child: Text(
                                                        'Answer: ${postedQuestion.answer}'),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                );
                              } else {
                                return const Center(
                                  child: Text('No saved questions'),
                                );
                              }
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
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
