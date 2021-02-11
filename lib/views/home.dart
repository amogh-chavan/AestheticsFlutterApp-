import 'dart:convert';

import 'package:aesthetics/data/data.dart';
import 'package:aesthetics/model/wallpaper_model.dart';
import 'package:aesthetics/views/categorie.dart';
//import 'package:aesthetics/views/image_view.dart';
import 'package:flutter/material.dart';
import 'package:aesthetics/widget/widget.dart';
import 'package:aesthetics/model/categories_model.dart';
import 'package:http/http.dart' as http;
import 'search.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModel> categories = new List();
  List<WallpaperModel> wallpapers = new List();
  TextEditingController searchcontroller = new TextEditingController();
  getTrendingWallpapers() async {
    var response = await http.get(
        "https://api.pexels.com/v1/curated?per_page=15&page=1",
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
    getTrendingWallpapers();
    categories = getCategories();
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
        child: Column(
          children: <Widget>[
            
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              margin: EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: searchcontroller,
                      decoration: InputDecoration(
                          hintText: "search", border: InputBorder.none),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Search(
                                    searchQuery: searchcontroller.text,
                                  )));
                    },
                    child: Container(child: Icon(Icons.search)),
                  )
                ],
              ),
            ),
            Container(
              //orignal 16 amogh changed to 8
              height: 30,
              margin: EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Made by "),
                  Text("Amogh Chavan",
                      style: TextStyle(
                          color: Colors.black87, fontFamily: 'Overpass'))
                ],
              ),
            ),
            Container(
              height: 80,
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoriesTile(
                        title: categories[index].categorieName,
                        imgUrl: categories[index].imgUrl);
                  }),
            ),
            SizedBox(
              height: 16,
            ),
            wallpapersList(wallpapers: wallpapers, context: context),
            Container(
              //orignal 16 amogh changed to 8
              height: 16,
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Powered by "),
                  Text("pexels",
                      style:
                          TextStyle(color: Colors.blue, fontFamily: 'Overpass'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imgUrl, title;
  CategoriesTile({@required this.title, @required this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Categorie(
                        categorieName: title.toLowerCase(),
                      )));
        },
        child: Container(
            margin: EdgeInsets.only(right: 4),
            child: Stack(
              children: <Widget>[
                // GestureDetector(
                // onTap: () {
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (Context) => ImageView()));
                // },
                // child: Hero(
                //   tag: imgUrl,
                //  child:
                ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      imgUrl,
                      height: 50,
                      width: 100,
                      fit: BoxFit.cover,
                    )),
                //    ),
                //   ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black26,
                  ),
                  height: 50,
                  width: 100,
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            )));
  }
}
