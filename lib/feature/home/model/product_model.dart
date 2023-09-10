import 'package:computer_store_app/core/base/model/base_model.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable with IdModel, BaseModel<ProductModel> {
  @override
  final int? id;
  final String? name;
  final int? price;
  final int? ram;
  final int? storage;
  final String? processor;
  final String? imageUrl;

  ProductModel({
    this.id,
    this.name,
    this.price,
    this.ram,
    this.storage,
    this.processor,
    this.imageUrl,
  });

  @override
  List<Object?> get props =>
      [id, name, price, ram, storage, processor, imageUrl];

  ProductModel copyWith({
    int? id,
    String? name,
    int? price,
    int? ram,
    int? storage,
    String? processor,
    String? imageUrl,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      ram: ram ?? this.ram,
      storage: storage ?? this.storage,
      processor: processor ?? this.processor,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'ram': ram,
      'storage': storage,
      'processor': processor,
      'imageUrl': imageUrl,
    };
  }

  @override
  ProductModel fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      price: json['price'] as int?,
      ram: json['ram'] as int?,
      storage: json['storage'] as int?,
      processor: json['processor'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }
}
