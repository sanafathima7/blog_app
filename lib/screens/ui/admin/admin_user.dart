import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_bloc/models/user.dart';
import 'package:hive_bloc/screens/ui/user/profile.dart';

class AdminUserList extends StatelessWidget {
  const AdminUserList({super.key});

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
                'User List',
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
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    Expanded(
                      child: FutureBuilder<Box<userList>>(
                        future: Hive.openBox<userList>('userdata'),
                        builder: (BuildContext context,
                            AsyncSnapshot<Box<userList>> snapshot) {
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
                                  var userList = box.getAt(index);
                                  if (userList != null) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 18.0),
                                      child: Material(
                                        color: Colors
                                            .transparent, // Makes sure the Material background is transparent
                                        child: Container(
                                          height: 150,
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
                                                    'username: ${userList.username}',
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
                                                  child: Text(
                                                      'email: ${userList.email}'),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 28.0),
                                                child: Container(
                                                  height: 30,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),

                                                    // gradient:
                                                    //     const LinearGradient(
                                                    //   colors: [
                                                    //     Color(0xff881736),
                                                    //     Color(0xff281537),
                                                    //   ],
                                                    // ),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      'Ban user',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ),
                                                ),
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
