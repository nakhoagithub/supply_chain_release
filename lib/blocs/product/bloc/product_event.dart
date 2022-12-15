import 'package:equatable/equatable.dart';
import 'package:supply_chain/models/ingredient.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object?> get props => [];
}

class ProductInitEvent extends ProductEvent {}

class ProductManagerInitEvent extends ProductEvent {
  final String keyProduct;
  const ProductManagerInitEvent({
    required this.keyProduct,
  });

  @override
  List<Object?> get props => [keyProduct];
}

class ProductChangeNameEvent extends ProductEvent {
  final String productName;
  const ProductChangeNameEvent({
    required this.productName,
  });

  @override
  List<Object?> get props => [productName];
}

class ProductChangeCodeEvent extends ProductEvent {
  final String productCode;
  const ProductChangeCodeEvent({
    required this.productCode,
  });

  @override
  List<Object?> get props => [productCode];
}

class ProductChangePriceEvent extends ProductEvent {
  final String price;
  const ProductChangePriceEvent({
    required this.price,
  });

  @override
  List<Object?> get props => [price];
}

class ProductChangeCurrencyEvent extends ProductEvent {
  final String currency;
  const ProductChangeCurrencyEvent({
    required this.currency,
  });

  @override
  List<Object?> get props => [currency];
}

class ProductChangeDescriptionEvent extends ProductEvent {
  final String description;
  const ProductChangeDescriptionEvent({
    required this.description,
  });

  @override
  List<Object?> get props => [description];
}

class ProductChangeLinkImageEvent extends ProductEvent {
  final String link;
  const ProductChangeLinkImageEvent({
    required this.link,
  });

  @override
  List<Object?> get props => [link];
}

class ProductSubmitedEvent extends ProductEvent {
  const ProductSubmitedEvent();
}

class ProductChangeSubmitedEvent extends ProductEvent {
  const ProductChangeSubmitedEvent();
}

class ProductDeleteEvent extends ProductEvent {
  final String? idProduct;
  const ProductDeleteEvent({required this.idProduct});

  @override
  List<Object?> get props => [idProduct];
}

class IngredientInitEvent extends ProductEvent {}

class ProductChangeIngredientEvent extends ProductEvent {
  final List<Ingredient>? ingredients;
  const ProductChangeIngredientEvent({required this.ingredients});
}
