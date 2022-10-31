import 'package:flutter/material.dart';
import 'package:gallery/home_page.dart';


void main() => runApp(const Gallery());


class Gallery extends StatelessWidget {
  const Gallery({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
