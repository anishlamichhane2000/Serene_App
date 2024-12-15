import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:serene_app/features/products/models/product_model.dart';
import 'package:serene_app/features/products/repos/products_repo.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
    on<ProductsFetchInitialEvent>(productsFetchInitialEvent);
  }

  FutureOr<void> productsFetchInitialEvent(
      ProductsFetchInitialEvent event, Emitter<ProductsState> emit) async {
    try {
      emit(ProductsFetchLoadingState());
      List<ProductModel> products = await ProductsRepo.getProducts();
      log(products.map((e) => e.toMap()).toString());
      emit(ProductsFetchSuccessState(products: products));
    } catch (e) {
      log(e.toString());
      emit(ProductsFetchErrorState());
    }
  }
}
