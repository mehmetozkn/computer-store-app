import 'package:computer_store_app/core/base/model/base_model.dart';
import 'package:computer_store_app/feature/home/model/product_model.dart';
import 'package:equatable/equatable.dart';

class BasketProductModel extends Equatable
    with IdModel, BaseModel<BasketProductModel> {
  @override
  final int? id;
  final ProductModel? product;
  int? quantity;

  BasketProductModel({
    this.id,
    this.product,
    this.quantity,
  });

  @override
  List<Object?> get props => [id, product, quantity];

  BasketProductModel copyWith({
    int? id,
    ProductModel? product,
    int? quantity,
  }) {
    return BasketProductModel(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product,
      'quantity': quantity,
    };
  }

  @override
  BasketProductModel fromJson(Map<String, dynamic> json) {
    return BasketProductModel(
      id: json['id'] as int?,
      product: json['product'] == null
          ? null
          : ProductModel().fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int?,
    );
  }
}
