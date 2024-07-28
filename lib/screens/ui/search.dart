import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_bloc/models/post.dart' as postPackage;
import 'package:hive_bloc/screens/ui/user/homepage.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();
  late Future<Box<postPackage.postedQuestion>> _boxFuture;
  List<postPackage.postedQuestion> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _boxFuture = Hive.openBox<postPackage.postedQuestion>('postdata');
  }

  void _search(String query) async {
    final box = await _boxFuture;
    final results = box.values
        .where((question) =>
            question.title.contains(query) ||
            question.content.contains(query) ||
            (question.answer?.contains(query) ?? false))
        .toList();
    setState(() {
      _searchResults = results;
    });
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
                'Search',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70.0),
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, left: 8.0, right: 8.0),
                      child: Container(
                        width: 600,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 233, 232, 232),
                        ),
                        child: TextFormField(
                          controller: searchController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                _search(searchController.text);
                              },
                            ),
                            prefixIcon: const Icon(Icons.search),
                            labelText: 'Search here',
                            labelStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder<Box<postPackage.postedQuestion>>(
                        future: _boxFuture,
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
                            if (_searchResults.isNotEmpty) {
                              return ListView.builder(
                                itemCount: _searchResults.length,
                                itemBuilder: (context, index) {
                                  var postedQuestion = _searchResults[index];
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
                                                padding: const EdgeInsets.only(
                                                    left: 12.0, top: 5.0),
                                                child: Text(
                                                  'Title: ${postedQuestion.title}',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12.0, top: 5.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        'Content: ${postedQuestion.content}'),
                                                    if (postedQuestion
                                                        .isPublished)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5.0),
                                                        child: Text(
                                                            'Answer: ${postedQuestion.answer}'),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                child: Text('No results found'),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainHomepage()),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
