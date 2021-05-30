import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/model/categories_model/get_categories_model.dart';
import 'package:shop/model/favorites_model/change_favorite_model.dart';
import 'package:shop/model/favorites_model/favorites_model.dart';
import 'package:shop/model/home_model/home_model.dart';
import 'package:shop/model/login_model/login_model.dart';
import 'package:shop/modules/categories_screen/categories_screen.dart';
import 'package:shop/modules/favorites_screen/favorites_screen.dart';
import 'package:shop/modules/home_screen/home_screen.dart';
import 'package:shop/modules/settings_screen/settings_screen.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/cubit/shop_cubit/shop_states.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/shared/network/remote/end_point.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentPageIndex = 0;

  void changeScreen(int index) {
    currentPageIndex = index;
    emit(ShopChangeBottomNavState());
  }

  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  late HomeModel homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      if (value.data != null) {
        homeModel = HomeModel.fromJson(value.data);
        for (var element in homeModel.data.products) {
          favorites.addAll({
            element.id: element.inFavorites,
          });
        }
        emit(ShopSuccessHomeDataState(homeModel));
        getCategoriesData();
      }
    }).catchError((error) {
      emit(ShopErrorHomeDataState(error.toString()));
      // ignore: avoid_print
      print(error.toString());
    });
  }

  late CategoriesModel categoriesModel;

  void getCategoriesData() {
    emit(ShopLoadingCategoriesDataState());

    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesDataState(categoriesModel));
      getFavorites();
    }).catchError((error) {
      emit(ShopErrorCategoriesDataState(error.toString()));
      // ignore: avoid_print
      print(error.toString());
    });
  }

  bool? changeNullBoll(prodId) {
    favorites[prodId] ?? false
        ? favorites[prodId] = false
        : favorites[prodId] = true;
    return favorites[prodId];
  }

  late FavoritesDataModel favoritesDataModel;

  void changeFavorites(int productId) {
    changeNullBoll(productId);
    emit(ShopChangeFavIconColorState());

    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      favoritesDataModel = FavoritesDataModel.fromJson(value.data);
      emit(ShopSuccessChangeFavoritesState(favoritesDataModel));
      if (!favoritesDataModel.status) {
        changeNullBoll(productId);
      } else {
        getFavorites();
      }
      // print(value.data);
    }).catchError((error) {
      changeNullBoll(productId);
      emit(ShopErrorChangeFavoritesState(error.toString()));
      print(error.toString());
    });
  }

  late FavoritesModel favoritesModel;

  void getFavorites() {
    emit(ShopLoadingFavoritesDataState());

    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessFavoritesDataState(favoritesModel));
      getUserData();
    }).catchError((error) {
      ShopErrorFavoritesDataState(error.toString());
      print(error.toString());
    });
  }

  late LoginModel userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataState(userModel));
      print(userModel.data!.name);
    }).catchError((error) {
      emit(ShopErrorUserDataState(error.toString()));
      print('Error is: ${error.toString()}');
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserState(userModel));
    }).catchError((error){
      emit(ShopErrorUpdateUserState(error.toString()));
      print('error is: ${error.toString()}');
    });
  }
}
