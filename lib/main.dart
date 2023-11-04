import 'package:flutter/material.dart';

import 'clases/mihomepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Layouts',
      home: MyHomePage(),
    );
  }
}
