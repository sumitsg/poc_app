import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poc_app/screen/circular_docList_page.dart';
import 'package:poc_app/screen/home_screen.dart';
import 'package:poc_app/screen/login_page.dart';
import 'package:poc_app/screen/otp_page.dart';

import 'screen/pdf_viewer_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const LoginScreen(title: 'Union Bank e-Circular App')
        // const PdfViewerPage(
        //     url:
        //         "https://unec.edu.az/application/uploads/2014/12/pdf-sample.pdf"),
        );
  }
}
