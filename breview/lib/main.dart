import 'package:breview/pages/create_blog_ui.dart';
import 'package:breview/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyACUL935VNkFDUp_PpFakoRPxEbGMNuh4s",
          authDomain: "breview-334103.firebaseapp.com",
          projectId: "breview-334103",
          storageBucket: "breview-334103.appspot.com",
          messagingSenderId: "934338543057",
          appId: "1:934338543057:web:25b0df1edb3072fad4b4f0",
          // measurementId: "${config.measurementId}"
      ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: HomePage(),
    );
  }
}