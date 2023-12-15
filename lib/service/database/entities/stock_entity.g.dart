// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StockEntityAdapter extends TypeAdapter<StockEntity> {
  @override
  final int typeId = 0;

  @override
  StockEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StockEntity(
      metaData: fields[0] as MetaDataEntity,
      values: (fields[1] as List).cast<StockValueEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, StockEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.metaData)
      ..writeByte(1)
      ..write(obj.values);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MetaDataEntityAdapter extends TypeAdapter<MetaDataEntity> {
  @override
  final int typeId = 1;

  @override
  MetaDataEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MetaDataEntity(
      information: fields[0] as String,
      symbol: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MetaDataEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.information)
      ..writeByte(1)
      ..write(obj.symbol);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MetaDataEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StockValueEntityAdapter extends TypeAdapter<StockValueEntity> {
  @override
  final int typeId = 2;

  @override
  StockValueEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StockValueEntity(
      close: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StockValueEntity obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.close);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockValueEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
