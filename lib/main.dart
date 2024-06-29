import 'package:flutter/material.dart';
import 'package:gestion_des_factures/screens/file_upload_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gestion facture',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: FileUploadScreen());
  }
}
