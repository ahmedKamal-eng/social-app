import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shop_app/categories/category_screen.dart';
// import 'package:shop_app/favorite/favorite_screen.dart';
// import 'package:shop_app/models/user/shop_app/Category_model.dart';
import 'package:social_app/models/change_favorite_model.dart';
// import 'package:shop_app/models/user/shop_app/favorite_model.dart';
// import 'package:shop_app/models/user/shop_app/home_model.dart';
import 'package:social_app/models/login_model.dart';
import 'package:social_app/shared/component/constant.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';
import 'package:social_app/shared/network/remote/end_points.dart';
// import 'package:shop_app/products/products_screen.dart';
// import 'package:shop_app/settings/settings_screen.dart';
import 'package:social_app/shop_cubit/states.dart';

// import '../constant.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  // List<Widget> bottomScreens = [
  //   ProductsScreen(),
  //   CategoryScreen(),
  //   FavoriteScreen(),
  //   SettingsScreen(),
  // ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  // HomeModel homeModel;

  Map<int, bool> favorites = {};

  // void getHomeData() {
  //   emit(ShopLoadingHomeDataState());
  //
  //   DioHelper.getData(
  //     url: HOME,
  //     token: token,
  //   ).then((value) {
  //     homeModel = HomeModel.fromJson(value.data);
  //
  //     //print(homeModel.data.banners[0].image);
  //     //print(homeModel.status);
  //
  //     homeModel.data.products.forEach((element) {
  //       favorites.addAll({
  //         element.id: element.inFavorites,
  //       });
  //     });
  //
  //     print(favorites.toString());
  //
  //     emit(ShopSuccessHomeDataState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(ShopErrorHomeDataState());
  //   });
  // }

  // CategoriesModel categoriesModel;

  // void getCategories() {
  //   DioHelper.getData(
  //     url: GET_CATEGORIES,
  //   ).then((value) {
  //     categoriesModel = CategoriesModel.fromJson(value.data);
  //
  //     emit(ShopSuccessCategoriesState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(ShopErrorCategoriesState());
  //   });
  // }

  ChangeFavoritesModel changeFavoritesModel;

  // void changeFavorites(int productId) {
  //   favorites[productId] = !favorites[productId];
  //
  //   emit(ShopChangeFavoritesState());
  //
  //   DioHelper.postData(
  //     url: FAVORITES,
  //     data: {
  //       'product_id': productId,
  //     },
  //     token: token,
  //   ).then((value) {
  //     changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
  //     print(value.data);
  //
  //     if (!changeFavoritesModel.status) {
  //       favorites[productId] = !favorites[productId];
  //     } else {
  //       getFavorites();
  //     }
  //
  //     emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
  //   }).catchError((error) {
  //     favorites[productId] = !favorites[productId];
  //
  //     emit(ShopErrorChangeFavoritesState());
  //   });
  // }

  // FavoritesModel favoritesModel;

  // void getFavorites() {
  //   emit(ShopLoadingGetFavoritesState());
  //
  //   DioHelper.getData(url: FAVORITES, token: token).then((value) {
  //     favoritesModel = FavoritesModel.fromJson(value.data);
  //     printFullText(value.data.toString());
  //
  //     emit(ShopSuccessGetFavoritesState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(ShopErrorGetFavoritesState());
  //   });
  // }

  ShopLoginModel shopLoginModel;

  void getProfile() {
    emit(ShopLoadingGetProfileState());

    DioHelper.getData(url: PROFILE, token: token).then((value) {
      shopLoginModel = ShopLoginModel.fromJson(value.data);


      emit(ShopSuccessGetProfileState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetProfileState());
    });
  }

  void updateUserData({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    emit(ShopLoadingUpdateState());

    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
        data: {'name': name, 'email': email, 'phone': phone}).then((value) {
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      printFullText(value.data.toString());

      emit(ShopSuccessUpdateState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateState());
    });
  }

  // login
  ShopLoginModel loginModel;

  void userLogin({@required String email, @required String password}) {
    emit(ShopLoginLoadingState());

    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password})
        .then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);

      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changeIconVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopPasswordVisibilityState());
  }
}
