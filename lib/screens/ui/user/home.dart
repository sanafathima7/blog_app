import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_bloc/models/post.dart' as postPackage;
import 'package:hive_bloc/models/post.dart';
import 'package:hive_bloc/screens/ui/user/post_question.dart';
import 'package:hive_bloc/screens/ui/user/profile.dart';

class Homepage extends StatefulWidget {
  Homepage({
    super.key,
    required this.flag,
  });
  final bool flag;
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.only(top: 30.0, left: 425),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Profile(),
                ),
              );
            },
            child: Container(
              // color: Colors.white,
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const ClipRRect(
                child: Icon(
                  Icons.person,
                  size: 30,
                ),
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
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => post(),
                          ),
                        );
                      },
                      child: Container(
                        width: 600,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 233, 232, 232),
                          border: Border.all(
                            color: Color.fromARGB(255, 87, 86, 86),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.black87,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Post question',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (widget.flag)
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 8.0, right: 8.0),
                      child: Container(
                        width: 600,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 233, 232, 232),
                          // border: Border.all(
                          //   color: Color.fromARGB(255, 87, 86, 86),
                          // ),
                        ),
                        child: const Padding(
                          padding:
                              EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image(
                                image: AssetImage('assets/zooanimal.jfif'),
                                width: 375,
                                height: 75,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Is Global warming effecting the ecosystem..?',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                                      padding: const EdgeInsets.only(top: 18.0),
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
                                              bottomRight: Radius.circular(40),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              ListTile(
                                                title: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12.0, top: 5.0),
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
                                                          left: 12.0, top: 5.0),
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
                                                          left: 12.0, top: 5.0),
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
    );
  }
}
