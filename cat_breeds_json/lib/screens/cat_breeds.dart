import 'dart:convert';

import 'package:cat_breeds_json/models/cats.dart';
import 'package:flutter/material.dart';
import 'package:cat_breeds_json/api/cats_api.dart';
import 'package:cat_breeds_json/screens/cat_info.dart';

class CatBreedsPage extends StatefulWidget {
  CatBreedsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CatBreedsPageState createState() => _CatBreedsPageState();
}

class _CatBreedsPageState extends State<CatBreedsPage> {
  BreedList breedList = BreedList();
  @override
  void initState() {
    super.initState();
    getCatData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: (breedList == null || breedList.breeds == null || breedList.breeds.length == 0) ? 0 : breedList.breeds.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CatInfo(catId: breedList.breeds[index].id, catBreed: breedList.breeds[index].name);
                }));
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(breedList.breeds[index].name),
                    subtitle: Text(breedList.breeds[index].description),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void getCatData() async {
    var result = await CatAPI().getCatBreeds();
    print(result);
    var catMap = json.decode(result);
    setState(() {
      breedList = BreedList.fromJson(catMap);
    });
  }
}