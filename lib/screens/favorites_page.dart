import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:punkbeerapp/models/beer_structure.dart';

class FavoriteBeers extends StatefulWidget {
  final List<Beer> favoriteBeers;
  final Box favbox;

  FavoriteBeers(this.favoriteBeers, this.favbox);

  @override
  _FavoriteBeersState createState() => _FavoriteBeersState();
}

class _FavoriteBeersState extends State<FavoriteBeers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.color,
          title: Text(
            "Favorites",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Container(
            child: widget.favbox == null
                ? Center(child: Text("You have not added any favorites"))
                : ListView.builder(
                    itemCount: widget.favoriteBeers.length,
                    itemBuilder: (context, index) =>
                        beerFavoriteTiles(widget.favoriteBeers[index]))));
  }

  Widget beerFavoriteTiles(Beer beer) {
    return Column(children: <Widget>[
      ListTile(
        title: Text(beer.name),
        subtitle: Text(beer.tagline),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.network(beer.imageUrl),
        ),
      ),
      Divider()
    ]);
  }
}
