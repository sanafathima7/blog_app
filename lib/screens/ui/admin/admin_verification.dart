import 'package:hive_bloc/models/post.dart' as postPackage;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_bloc/models/post.dart';
import 'package:hive_bloc/screens/ui/admin/admin_home.dart';
import 'package:hive_bloc/screens/ui/admin/admin_homepage.dart';

class AdminVerification extends StatefulWidget {
  AdminVerification({Key? key}) : super(key: key);

  @override
  State<AdminVerification> createState() => _AdminVerificationState();
}

class _AdminVerificationState extends State<AdminVerification> {
  final TextEditingController answerController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  Future<void> _saveAnswer(postedQuestion postedQuestion) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      var box = await Hive.openBox<postPackage.postedQuestion>('postdata');
      postedQuestion.isPublished = true;
      postedQuestion.answer = answerController.text;

      await box.put(postedQuestion.key, postedQuestion);
      await box.close();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminMainHomepage(flag: true)),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Error saving answer: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
                'Verify Post',
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
                    if (_isLoading) const CircularProgressIndicator(),
                    if (_errorMessage != null)
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
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
                                                  child: Text(
                                                      'content: ${postedQuestion.content}'),
                                                ),
                                              ),
                                              TextFormField(
                                                controller: answerController,
                                                minLines: 1,
                                                maxLines: 1,
                                                textAlign: TextAlign.justify,
                                                decoration: InputDecoration(
                                                  suffixIcon: IconButton(
                                                    icon: const Icon(
                                                      Icons.check,
                                                      color: Color.fromARGB(
                                                          255, 3, 56, 5),
                                                    ),
                                                    onPressed: () {
                                                      _saveAnswer(
                                                          postedQuestion);
                                                    },
                                                  ),
                                                  prefixIcon: const Icon(Icons
                                                      .question_answer_outlined),
                                                  prefixIconColor:
                                                      Colors.black54,
                                                  label: const Text(
                                                    'Type your Answer... ',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black87,
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
