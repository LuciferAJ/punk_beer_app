import 'package:hive/hive.dart';

part 'beer_structure.g.dart';

@HiveType(typeId: 0)
class Beer {

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final String tagline;
  
  @HiveField(3)
  final String imageUrl;
  
  @HiveField(4)
  bool isfavorite;
  
Beer({this.id,this.imageUrl,this.name,this.tagline,this.isfavorite=false});

factory Beer.fromJSON(Map<String, dynamic> mapData){ 
  return Beer(
id:mapData["id"],
name:mapData["name"],
tagline:mapData["tagline"],
imageUrl:mapData["image_url"]);

}}