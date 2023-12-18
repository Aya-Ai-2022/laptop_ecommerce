import 'package:first_task_1/models/product_model.dart';

abstract class ProductStates {}

class ProductInitState extends ProductStates {}

class LoadingFetchProducts extends ProductStates {}

class FetchProducts extends ProductStates {}

class ErrorFetchProducts extends ProductStates {}

class LoadingFetchProductDetails extends ProductStates {}

class ProductDetailsLoadedState extends ProductStates {
  final Product productDetails;

  ProductDetailsLoadedState(this.productDetails);
}

class ErrorFetchProductDetails extends ProductStates {}

class ToggleFavoriteSuccessState extends ProductStates {}
