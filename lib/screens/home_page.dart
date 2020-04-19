import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:punkbeerapp/models/beer_structure.dart';
import 'package:punkbeerapp/screens/favorites_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url = "https://api.punkapi.com/v2/beers/";
  var parsedJson;
  List<Beer> beerList = [];
  List<Beer> favoriteBeer = [];
  Color heartColor = Colors.grey;
 Box _favoritesbox;

  toggleFavorite(int favId) {
    final existingIndex = favoriteBeer.indexWhere((beer) => beer.id == favId);


    if (existingIndex >= 0) {
      setState(() {
        favoriteBeer.removeAt(existingIndex);
        // int lastIndex = _favoritesbox.toMap().length - 1;
        //           if (lastIndex >= 0) _favoritesbox.deleteAt(lastIndex);
      });
    } else {
      setState(() {
        favoriteBeer.add(beerList.firstWhere((beer) => beer.id==favId));
      
        // Beer beer= Beer(id:favbeer.id,name: favbeer.name,tagline: favbeer.tagline,imageUrl: favbeer.imageUrl);
        // _favoritesbox.add(beer);
      });
    }
  }

  bool isBeerFavorite(int id) {
    return favoriteBeer.any((beer) => beer.id == id);

  }


  Future _openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    _favoritesbox = await Hive.openBox('favoritesbox');
    return;
  }
  @override
  void initState() {
    super.initState();
     Hive.registerAdapter(BeerAdapter());
    _openBox();
    fetchBeerData();
  }

  void fetchBeerData() async {
    final beerClient = http.Client();
    final response = await beerClient.send(http.Request('get', Uri.parse(url)));
    final stream = response.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .expand((beerData) => (beerData as List))
        .map((data) => Beer.fromJSON(data));
    stream.listen((Beer beer) => setState(() => beerList.add(beer)));
  }

 

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Theme.of(context).appBarTheme.color,
          title: Text(
            "Top Beer",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.favorite,color: Colors.red,), onPressed:() {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => FavoriteBeers(favoriteBeer,_favoritesbox),
    ));
})
          ],
        ),
        body: ListView.builder(
            itemCount: beerList.length,
            itemBuilder: (context, index) => beerListTile(beerList[index])));
  }

  Widget beerListTile(Beer beer) {
    return Column(children: <Widget>[
      ListTile(
        title: Text(beer.name),
        subtitle: Text(beer.tagline),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.network(beer.imageUrl),
        ),
        trailing: IconButton(
            icon: isBeerFavorite(beer.id)
                ? Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : Icon(
                    Icons.favorite_border,
                    color: Colors.grey,
                  ),
            onPressed: (){toggleFavorite(beer.id);print("buttonpressed");}),
      ),
      Divider()
    ]);
  }
}
