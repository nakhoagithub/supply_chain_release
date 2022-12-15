import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain/blocs/product/bloc/product_event.dart';
import 'package:supply_chain/blocs/product/bloc/product_state.dart';
import 'package:supply_chain/models/ingredient.dart';
import 'package:supply_chain/repository/product_repository.dart';

import '../../../enum.dart';
import '../../../models/product.dart';
import '../../../models/validate.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc()
      : super(const ProductState(
          stream: null,
          productStatus: ProductStatus.initialize,
          nameStatus: NameStatus.initialize,
          codeStatus: CodeStatus.initialize,
          priceStatus: PriceStatus.initialize,
          linkImageStatus: LinkImageStatus.initialize,
        )) {
    on<ProductInitEvent>((event, emit) => _onInit(event, emit));
    on<ProductManagerInitEvent>(
        (event, emit) => _onInitProductManager(event, emit));
    on<ProductChangeNameEvent>(
        (event, emit) => _onProductChangeName(event, emit));
    on<ProductChangeCodeEvent>(
        (event, emit) => _onProductChangeCode(event, emit));
    on<ProductChangeDescriptionEvent>(
        (event, emit) => _onProductChangeDescription(event, emit));
    on<ProductChangeLinkImageEvent>(
        (event, emit) => _onProductChangeLinkImage(event, emit));
    on<ProductSubmitedEvent>((event, emit) => _onProductSubmited(event, emit));
    on<ProductChangeSubmitedEvent>(
        (event, emit) => _onProductChangeSubmited(event, emit));

    on<ProductDeleteEvent>((event, emit) => _onDeleteProduct(event, emit));
    on<IngredientInitEvent>((event, emit) => _onInitIngredient(event, emit));
    on<ProductChangeIngredientEvent>(
        (event, emit) => _onChangeProductIngredient(event, emit));
  }

  void _onInit(ProductInitEvent event, Emitter<ProductState> emit) async {
    ProductRepository productRepository = await ProductRepository.initialize();
    Stream<List<Product>> stream = productRepository.streamProduct();
    emit(state.copyWith(
      stream: stream,
      productStatus: ProductStatus.success,
    ));
  }

  void _onInitProductManager(
      ProductManagerInitEvent event, Emitter<ProductState> emit) async {
    String keyProduct = event.keyProduct;
    ProductRepository productRepository = await ProductRepository.initialize();

    Product product = await productRepository.getProduct(keyProduct);

    emit(state.copyWith(
      productName: product.name,
      productCode: product.code,
      description: product.description,
      linkImage: product.linkImage,
      keyProduct: keyProduct,
    ));
  }

  void _onProductChangeName(
      ProductChangeNameEvent event, Emitter<ProductState> emit) {
    final productName = event.productName;
    if (Validate.textValid(productName)) {
      emit(state.copyWith(
        nameStatus: NameStatus.valid,
        productStatus: ProductStatus.initialize,
        productName: productName,
      ));
    } else {
      emit(state.copyWith(
        nameStatus: NameStatus.invalid,
        productStatus: ProductStatus.failure,
        productName: productName,
      ));
    }
  }

  void _onProductChangeCode(
      ProductChangeCodeEvent event, Emitter<ProductState> emit) {
    final productCode = event.productCode;
    if (Validate.textValid(productCode)) {
      emit(state.copyWith(
        codeStatus: CodeStatus.valid,
        productStatus: ProductStatus.initialize,
        productCode: productCode,
      ));
    } else {
      emit(state.copyWith(
        codeStatus: CodeStatus.codeInvalid,
        productStatus: ProductStatus.failure,
        productCode: productCode,
      ));
    }
  }

  void _onProductChangeDescription(
      ProductChangeDescriptionEvent event, Emitter<ProductState> emit) {
    emit(state.copyWith(
      description: event.description,
      productStatus: ProductStatus.initialize,
    ));
  }

  void _onProductChangeLinkImage(
      ProductChangeLinkImageEvent event, Emitter<ProductState> emit) {
    final linkImage = event.link;
    if (Validate.linkValid(linkImage)) {
      emit(state.copyWith(
        linkImageStatus: LinkImageStatus.valid,
        productStatus: ProductStatus.initialize,
        linkImage: linkImage,
      ));
    } else {
      emit(state.copyWith(
        linkImageStatus: LinkImageStatus.invalid,
        productStatus: ProductStatus.failure,
        linkImage: linkImage,
      ));
    }
  }

  void _onProductSubmited(
      ProductSubmitedEvent event, Emitter<ProductState> emit) async {
    if (state.nameStatus == NameStatus.valid &&
        state.codeStatus == CodeStatus.valid) {
      emit(state.copyWith(productStatus: ProductStatus.loading));
      String? name = state.productName;
      String? code = state.productCode;
      String? description = state.description;
      String? linkImage = state.linkImage;
      List<Ingredient>? ingredients = state.ingredientOfProduct;
      ProductRepository productRepository =
          await ProductRepository.initialize();

      if (name != null && code != null && linkImage != null) {
        int result = await productRepository.addProduct(
          code: code,
          name: name,
          description: description,
          linkImage: linkImage,
          ingredients: ingredients,
        );
        switch (result) {
          case 1:
            emit(state.copyWith(productStatus: ProductStatus.success));
            await Future.delayed(const Duration(milliseconds: 1500));
            emit(state.copyWith(productStatus: ProductStatus.initialize));
            break;
          case 2:
            emit(state.copyWith(productStatus: ProductStatus.failure));
            break;
        }
      }
    } else {
      emit(state.copyWith(productStatus: ProductStatus.failure));
    }
  }

  void _onProductChangeSubmited(
      ProductChangeSubmitedEvent event, Emitter<ProductState> emit) async {
    String? name = state.productName;
    String? code = state.productCode;
    String? des = state.description;
    String? linkImage = state.linkImage;
    String? key = state.keyProduct;

    emit(state.copyWith(productStatus: ProductStatus.loading));
    ProductRepository productRepository = await ProductRepository.initialize();
    if (name != null && code != null && key != null && linkImage != null) {
      int result = await productRepository.updateProduct(
          key: key,
          code: code,
          name: name,
          description: des,
          linkImage: linkImage);
      switch (result) {
        case 1:
          emit(state.copyWith(productStatus: ProductStatus.success));
          break;
        case 2:
          emit(state.copyWith(productStatus: ProductStatus.failure));
          break;
      }
    } else {
      emit(state.copyWith(productStatus: ProductStatus.failure));
    }
  }

  void _onDeleteProduct(
      ProductDeleteEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(productDeleteStatus: DeleteStatus.initialize));
    String? keyProduct = event.idProduct;
    ProductRepository productRepository = await ProductRepository.initialize();
    if (await productRepository.deleteProduct(keyProduct)) {
      emit(state.copyWith(productDeleteStatus: DeleteStatus.success));
    } else {
      emit(state.copyWith(productDeleteStatus: DeleteStatus.failure));
    }
  }

  void _onInitIngredient(
      IngredientInitEvent event, Emitter<ProductState> emit) async {
    ProductRepository productRepository = await ProductRepository.initialize();
    List<Product>? products = await productRepository.getProductIngredient();
    emit(state.copyWith(ingredients: products));
  }

  void _onChangeProductIngredient(
      ProductChangeIngredientEvent event, Emitter<ProductState> emit) {
    emit(state.copyWith(ingredientOfProduct: event.ingredients));
  }
}
