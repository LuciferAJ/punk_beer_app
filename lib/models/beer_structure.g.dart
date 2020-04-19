// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beer_structure.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BeerAdapter extends TypeAdapter<Beer> {
  final typeId=0;
  @override
  Beer read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Beer(
      id: fields[0] as int,
      imageUrl: fields[3] as String,
      name: fields[1] as String,
      tagline: fields[2] as String,
      isfavorite: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Beer obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.tagline)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.isfavorite);
  }


}
