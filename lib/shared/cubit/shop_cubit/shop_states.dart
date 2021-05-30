import 'package:shop/model/categories_model/get_categories_model.dart';
import 'package:shop/model/favorites_model/change_favorite_model.dart';
import 'package:shop/model/favorites_model/favorites_model.dart';
import 'package:shop/model/home_model/home_model.dart';
import 'package:shop/model/login_model/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {
  final HomeModel homeModel;

  ShopSuccessHomeDataState(this.homeModel);
}

class ShopErrorHomeDataState extends ShopStates {
  final String error;

  ShopErrorHomeDataState(this.error);
}

class ShopLoadingCategoriesDataState extends ShopStates {}

class ShopSuccessCategoriesDataState extends ShopStates {
  final CategoriesModel categoriesModel;

  ShopSuccessCategoriesDataState(this.categoriesModel);
}

class ShopErrorCategoriesDataState extends ShopStates {
  final String error;

  ShopErrorCategoriesDataState(this.error);
}

class ShopChangeFavIconColorState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final FavoritesDataModel favoritesDataModel;

  ShopSuccessChangeFavoritesState(this.favoritesDataModel);
}

class ShopErrorChangeFavoritesState extends ShopStates {
  final String error;

  ShopErrorChangeFavoritesState(this.error);
}

class ShopLoadingFavoritesDataState extends ShopStates {}

class ShopSuccessFavoritesDataState extends ShopStates {
  final FavoritesModel favoritesModel;

  ShopSuccessFavoritesDataState(this.favoritesModel);
}

class ShopErrorFavoritesDataState extends ShopStates {
  final String error;

  ShopErrorFavoritesDataState(this.error);
}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {
  final LoginModel userModel;

  ShopSuccessUserDataState(this.userModel);
}

class ShopErrorUserDataState extends ShopStates {
  final String error;

  ShopErrorUserDataState(this.error);
}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {
  final LoginModel userModel;

  ShopSuccessUpdateUserState(this.userModel);
}

class ShopErrorUpdateUserState extends ShopStates {
  final String error;

  ShopErrorUpdateUserState(this.error);
}