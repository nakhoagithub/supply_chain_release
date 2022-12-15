import 'package:equatable/equatable.dart';
import 'package:supply_chain/enum.dart';
import 'package:supply_chain/models/product.dart';

import '../../../models/ingredient.dart';

class ProductState extends Equatable {
  final Stream<List<Product>>? stream;
  final ProductStatus productStatus;
  final NameStatus nameStatus;
  final String? productName;
  final CodeStatus codeStatus;
  final String? productCode;
  final PriceStatus priceStatus;
  final String? price;
  final String? currency;
  final String? description;
  final String? linkImage;
  final LinkImageStatus? linkImageStatus;
  final String? keyProduct;
  final DeleteStatus? productDeleteStatus;
  final ProcessingProductStatus? processingProductStatus;
  final List<Product>? ingredients;
  final List<Ingredient>? ingredientOfProduct;
  const ProductState({
    required this.stream,
    required this.productStatus,
    required this.nameStatus,
    this.productName,
    required this.codeStatus,
    this.productCode,
    required this.priceStatus,
    this.price,
    this.currency,
    this.description,
    this.linkImage,
    required this.linkImageStatus,
    this.keyProduct,
    this.productDeleteStatus,
    this.processingProductStatus,
    this.ingredients,
    this.ingredientOfProduct,
  });

  ProductState copyWith({
    Stream<List<Product>>? stream,
    ProductStatus? productStatus,
    NameStatus? nameStatus,
    String? productName,
    CodeStatus? codeStatus,
    String? productCode,
    PriceStatus? priceStatus,
    String? price,
    String? currency,
    String? description,
    String? linkImage,
    LinkImageStatus? linkImageStatus,
    String? keyProduct,
    DeleteStatus? productDeleteStatus,
    ProcessingProductStatus? processingProductStatus,
    List<Product>? ingredients,
    List<Ingredient>? ingredientOfProduct,
  }) {
    return ProductState(
      stream: stream ?? this.stream,
      productStatus: productStatus ?? this.productStatus,
      nameStatus: nameStatus ?? this.nameStatus,
      productName: productName ?? this.productName,
      codeStatus: codeStatus ?? this.codeStatus,
      productCode: productCode ?? this.productCode,
      priceStatus: priceStatus ?? this.priceStatus,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      description: description ?? this.description,
      linkImage: linkImage ?? this.linkImage,
      linkImageStatus: linkImageStatus ?? this.linkImageStatus,
      keyProduct: keyProduct ?? this.keyProduct,
      productDeleteStatus: productDeleteStatus ?? this.productDeleteStatus,
      processingProductStatus:
          processingProductStatus ?? this.processingProductStatus,
      ingredients: ingredients ?? this.ingredients,
      ingredientOfProduct: ingredientOfProduct ?? this.ingredientOfProduct,
    );
  }

  @override
  List<Object?> get props => [
        stream,
        productStatus,
        nameStatus,
        productName,
        codeStatus,
        productCode,
        priceStatus,
        price,
        currency,
        description,
        linkImage,
        linkImageStatus,
        keyProduct,
        productDeleteStatus,
        processingProductStatus,
        ingredients,
        ingredientOfProduct,
      ];
}
