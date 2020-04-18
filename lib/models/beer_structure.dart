class Beer {
  final int id;
  final String name;
  final String tagline;
  final String imageUrl;
  bool favorite;
  
Beer({this.id,this.imageUrl,this.name,this.tagline,this.favorite=false});

factory Beer.fromJSON(Map<String, dynamic> mapData){ 
  return Beer(
id:mapData["id"],
name:mapData["name"],
tagline:mapData["tagline"],
imageUrl:mapData["image_url"]);

}}