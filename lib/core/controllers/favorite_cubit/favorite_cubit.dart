// ignore_for_file: avoid_print

import 'package:first_task_1/core/controllers/favorite_cubit/favorite_states.dart';
import 'package:first_task_1/core/managers/values.dart';
import 'package:first_task_1/core/network/constant.dart';
import 'package:first_task_1/core/network/remote/dio_helper.dart';
import 'package:first_task_1/models/favorite_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<FavoritesStates> {
  FavoritesCubit() : super(FavoritesInitState());

  static FavoritesCubit get(context) => BlocProvider.of(context);

  FavoriteModel? favoritesList;
  void getFavorites() {
    DioHelperStore.getData(url: ApiConstants.getFavoritesApi, data: {
      "nationalId": natoinalId,
    }).then((value) {
      favoritesList = FavoriteModel.fromJson(
          value.data); //LaptopsModel.fromJson(value.data);
      print(
          'Favorites length: ${favoritesList?.products?.length}'); //print(favoritesList?.favoritesList?.product?.length);
      emit(GetFavorites());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetFavorites());
    });
  }

  void toggleFavorites(String productId) {
    if (favoritesList?.products?.any((element) => element.sId == productId) ==
        true) {
      // Product is in favorites, remove it
      removeFromFavorites(productId);
      // getFavorites();
    } else {
      // Product is not in favorites, add it
      addToFavorites(productId);
      // getFavorites();
    }
  }

  void toggleFavoriteWithoutGet(String productId) {
    Productf? product = findProductfById(productId);

    if (product != null) {
      product.isFavorite = !(product.isFavorite ?? false);
      emit(ToggleFavoriteSuccessStatewithoutget());
    }
  }

  Productf? findProductfById(String productId) {
    // Check if laptopsModel is not null
    if (favoritesList != null && favoritesList!.products?.isNotEmpty == true) {
      // Find the product with the specified productId
      return favoritesList?.products
          ?.firstWhere((product) => product.sId == productId);
      //orElse: () => null, // Return null if product is not found
    }

    return null;

// Return null if laptopsModel or laptopsModel.product is null
  }

  void addToFavorites(String productId) {
    DioHelperStore.postData(
      url: ApiConstants.addFavoriteApi,
      data: {"nationalId": natoinalId, "productId": productId},
    ).then((value) {
      getFavorites();
      emit(AddToFavorites());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorAddToFavorites());
    });
  }

  void removeFromFavorites(String productId) {
    DioHelperStore.delData(
      url: ApiConstants.deleteFavoriteApi,
      data: {"nationalId": natoinalId, "productId": productId},
    ).then((value) {
      getFavorites();
      emit(RemoveFromFavorites());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorRemoveFromFavorites());
    });
  }
}
