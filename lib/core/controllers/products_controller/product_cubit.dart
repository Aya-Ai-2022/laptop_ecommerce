// ignore_for_file: avoid_print

import 'package:first_task_1/core/controllers/products_controller/product_states.dart';
import 'package:first_task_1/core/network/constant.dart';
import 'package:first_task_1/core/network/remote/dio_helper.dart';
import 'package:first_task_1/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit() : super(ProductInitState());
  static ProductCubit get(context) => BlocProvider.of(context);

  LaptopsModel? laptopsModel;

  void getHomeProducts() {
    emit(LoadingFetchProducts());
    DioHelperStore.getData(url: ApiConstants.homeApi).then((value) {
      laptopsModel = LaptopsModel.fromJson(value.data);
      print(laptopsModel!.product!.length);
      emit(FetchProducts());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorFetchProducts());
    });
  }

  void toggleFavorite(String productId) {
    Product? product = findProductById(productId);
    if (product != null) {
      product.isFavorite = !(product.isFavorite ?? false);
      emit(ToggleFavoriteSuccessState());
    }
  }

  Product? findProductById(String productId) {
    // Check if laptopsModel is not null
    if (laptopsModel != null && laptopsModel!.product != null) {
      // Find the product with the specified productId
      return laptopsModel!.product!.firstWhere(
        (product) => product.sId == productId,
        //orElse: () => null,
      );
    }
    return null;
  }
}
