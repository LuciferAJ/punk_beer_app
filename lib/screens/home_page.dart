import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:punkbeerapp/models/beer_structure.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url="https://api.punkapi.com/v2/beers/";
  var parsedJson;
  List<Beer> beerList = [];
  Color heartColor=Colors.grey;

  @override
  void initState() {
    super.initState();
    fetchBeerData();
  }

  void fetchBeerData() async{
    final beerClient = http.Client();
    final response = await beerClient.send(http.Request('get',Uri.parse(url)));
    final stream = response.stream.transform(utf8.decoder).transform(json.decoder).expand((beerData) => (beerData as List))
      .map((data) => Beer.fromJSON(data));
    stream.listen((Beer beer) => setState(()=>beerList.add(beer)));

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.color,
        title: Text("Top Beer",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        ),
      body: ListView.builder(itemCount:beerList.length,itemBuilder: (context,index)=>  beerListTile(beerList[index]),cacheExtent: 10,)
      );

  }

Widget beerListTile(Beer beer){
   return Column(
     children: <Widget>[
       ListTile(
         title:Text(beer.name),
         subtitle: Text(beer.tagline),
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.network(beer.imageUrl),
          ),
          trailing: IconButton(icon: Icon(Icons.favorite,color: heartColor,), onPressed: (){
            setState(() {
              beer.favorite=true;
              heartColor=(heartColor==Colors.grey)?Colors.red:Colors.grey;
              
            });
          }),



  ),
  Divider()
     ],
   );

}

}

