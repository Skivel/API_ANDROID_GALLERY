// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'full_screen_image.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  var url =
      "https://api.unsplash.com/photos/?client_id=ab3411e4ac868c2646c0ed488dfd919ef612b04c264f3374c97fff98ed253dc9";
  List<dynamic> ListD = [];
  List<String> ListImgSmall = [];
  List<String> ListImgFull = [];
  List<String> ListAuthor = [];

  @override
  void initState() {
    getJsonData();
    super.initState();
  }

  void getJsonData() async {
    final response = await http.get(Uri.parse(url));
    List<dynamic> data = json.decode(response.body);
    data.forEach((element) {
      Map obj = element;
      Map urls = obj['urls'];
      Map user = obj['user'];
      dynamic description = obj['description'];
      String ImgS = urls['thumb'];
      String ImgF = urls['regular'];
      String author = user['name'];
      ListD.add(description);
      ListImgSmall.add(ImgS);
      ListImgFull.add(ImgF);
      ListAuthor.add(author);
    });

    setState(() {
      ListD = ListD;
      ListImgSmall = ListImgSmall;
      ListImgFull = ListImgFull;
      ListAuthor = ListAuthor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Gallery')),
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            for (int i = 0; i < ListImgSmall.length.toInt(); i++)
              Column(children: [
                Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 20),
                    child: Column(children: [
                      Text(ListAuthor[i],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      InkWell(
                        child: Image.network(ListImgSmall[i]),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) {
                            return FullScreenImage(url: ListImgFull[i],);
                          },),);
                        },
                      ),
                      if (ListD[i].toString() != "null")
                        Text(
                          ListD[i].toString(),
                          textAlign: TextAlign.center,
                        ),
                    ])),
              ])
          ],
        ));
  }
}
