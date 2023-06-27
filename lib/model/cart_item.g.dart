// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartItemAdapter extends TypeAdapter<CartItem> {
  @override
  final int typeId = 0;

  @override
  CartItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartItem(
      product_name: fields[0] as String,
      product_image: fields[1] as String,
      price: fields[3] as int,
      qty: fields[2] as int,
      id: fields[4] as String,
      stock: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CartItem obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.product_name)
      ..writeByte(1)
      ..write(obj.product_image)
      ..writeByte(2)
      ..write(obj.qty)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.stock);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
