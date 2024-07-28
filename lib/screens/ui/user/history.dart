import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_bloc/models/post.dart';
import 'package:hive_bloc/screens/ui/user/homepage.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
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
                'History',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          // User Icon
          const Padding(
            padding: EdgeInsets.only(top: 30.0, left: 425),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: Icon(
                Icons.person,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
          // History Content
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
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Expanded(
                      child: FutureBuilder<Box<postedQuestion>>(
                        future: Hive.openBox<postedQuestion>('postdata'),
                        builder: (BuildContext context,
                            AsyncSnapshot<Box<postedQuestion>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            }

                            var box1 = snapshot.data;
                            if (box1 != null && box1.isNotEmpty) {
                              return ListView.builder(
                                itemCount: box1.length,
                                itemBuilder: (context, index) {
                                  var postedQuestion = box1.getAt(index);
                                  if (postedQuestion != null) {
                                    return ListTile(
                                      title: Text(
                                        'title: ${postedQuestion.title}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                          'content: ${postedQuestion.content}'),
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
