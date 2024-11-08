import 'package:flutter/material.dart';

class MySearchController extends StatefulWidget {
  const MySearchController({
    super.key,
    required this.query,
  });

  final String query;

  @override
  State<MySearchController> createState() => _MySearchControllerState();
}

class _MySearchControllerState extends State<MySearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F6),
      body: ListView(),
    );
  }
}
