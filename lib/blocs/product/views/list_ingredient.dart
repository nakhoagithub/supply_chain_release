import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain/blocs/product/bloc/product_event.dart';

import '../../../models/ingredient.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_state.dart';

class ListIngredientPage extends StatelessWidget {
  const ListIngredientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(IngredientInitEvent()),
      child: const _ListIngredientView(),
    );
  }
}

class _ListIngredientView extends StatelessWidget {
  const _ListIngredientView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      bloc: BlocProvider.of<ProductBloc>(context),
      buildWhen: (previous, current) =>
          previous.ingredients != current.ingredients,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Danh sách sản phẩm đã mua"),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: Container(
            margin: const EdgeInsets.all(5),
            child: state.ingredients == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state.ingredients!.isEmpty
                    ? const Center(
                        child: Text("Không có nguyên liệu"),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.ingredients!.length,
                        itemBuilder: (context, index) {
                          return _ItemIngredient(
                            ingredient: Ingredient(
                                id: state.ingredients![index].id ?? "",
                                name: state.ingredients![index].name,
                                idHistory: state.ingredients![index].idHistory),
                            name: state.ingredients![index].name,
                            linkImage: state.ingredients![index].linkImage,
                          );
                        },
                      ),
          ),
        );
      },
    );
  }
}

class _ItemIngredient extends StatelessWidget {
  final Ingredient ingredient;
  final String name;
  final String? linkImage;
  const _ItemIngredient({
    required this.ingredient,
    required this.name,
    required this.linkImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop(ingredient);
        },
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              height: 40,
              width: 40,
              child: linkImage == null || linkImage == ""
                  ? Image.asset(
                      "assets/images/icon_product.png",
                      height: 80,
                      width: 80,
                    )
                  : Image.network(
                      linkImage ?? "",
                      height: 80,
                      width: 80,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/images/icon_product.png",
                          height: 80,
                          width: 80,
                        );
                      },
                    ),
            ),
            Text(name),
          ],
        ),
      ),
    );
  }
}
