import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_bloc/screens/ui/admin/admin_home.dart';
import 'package:hive_bloc/screens/ui/admin/admin_homepage.dart';
import 'package:hive_bloc/screens/ui/user/homepage.dart';
import 'package:hive_bloc/screens/ui/welcomescreen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_bloc/models/user.dart' as userPackage;
import 'package:hive_bloc/models/post.dart' as postPackage;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Hive.initFlutter();
    Hive.registerAdapter(userPackage.userListAdapter());
    Hive.registerAdapter(postPackage.postedQuestionAdapter());

    runApp(const MyApp());
  } catch (e) {
    print('Initialization Error: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainHomepage(),
      // Welcomscreen(),
      //     AdminMainHomepage(
      //   flag: false,
      // ),
    );
  }
}
