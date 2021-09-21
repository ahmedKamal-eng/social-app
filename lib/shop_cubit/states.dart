import 'package:flutter/cupertino.dart';
import 'package:social_app/models/change_favorite_model.dart';
import 'package:social_app/models/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

//home states
class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

//category states
class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

//favorite states
class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

//profile states
class ShopLoadingGetProfileState extends ShopStates {}

class ShopSuccessGetProfileState extends ShopStates {}

class ShopErrorGetProfileState extends ShopStates {}

//update States
class ShopLoadingUpdateState extends ShopStates {}

class ShopSuccessUpdateState extends ShopStates {}

class ShopErrorUpdateState extends ShopStates {}

// login state

class ShopLoginInitialState extends ShopStates {}

class ShopLoginLoadingState extends ShopStates {}

class ShopLoginSuccessState extends ShopStates {
  final ShopLoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopStates {
  final String error;
  ShopLoginErrorState(this.error);
}

class ShopPasswordVisibilityState extends ShopStates {}
