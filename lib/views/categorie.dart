import 'package:flutter/material.dart';
import 'package:aesthetics/widget/widget.dart';
import 'package:http/http.dart' as http;
import 'package:aesthetics/data/data.dart';
import 'package:aesthetics/model/wallpaper_model.dart';
import 'dart:convert';

class Categorie extends StatefulWidget {
  final String categorieName;
  Categorie({this.categorieName});

  @override
  _CategorieState createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  List<WallpaperModel> wallpapers = new List();

  getSearchWallpapers() async {
    var response = await http.get(
        "https://api.pexels.com/v1/search?query=${widget.categorieName}&per_page=15&page=1",
        headers: {"Authorization": apikey});

    //print(response.body.toString());

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      // print(element);
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });
    setState(() {});
  }

  @override
  void initState() {
    getSearchWallpapers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: 16,
            ),
            wallpapersList(wallpapers: wallpapers, context: context)
          ],
        )),
      ),
    );
  }
}
