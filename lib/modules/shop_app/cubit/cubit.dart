import 'package:first_project/models/shopmodel/Get_FavouriteModel.dart';
import 'package:first_project/models/shopmodel/category_model.dart';
import 'package:first_project/models/shopmodel/favorite_model.dart';
import 'package:first_project/models/shopmodel/home_model.dart';
import 'package:first_project/modules/shop_app/categories/category_screen.dart';
import 'package:first_project/modules/shop_app/cubit/states.dart';
import 'package:first_project/modules/shop_app/favorites/favorite_screen.dart';
import 'package:first_project/modules/shop_app/products/product_screen.dart';
import 'package:first_project/modules/shop_app/settings/setting_screen.dart';
import 'package:first_project/network/end_poients.dart';
import 'package:first_project/network/remote/dio_helper.dart';
import 'package:first_project/shared/components/contants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> ShopScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNav());
  }

  HomeModel? homeModel;
  Map<int, bool> favourites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataScreen());
    print(token);
    dioHelper.getData(
      url: HOME, 
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products.forEach((element) {
        favourites.addAll({
          element.id!: element.inFavourites!,
        });
      });
      print(favourites);
      emit(ShopSuccessHomeDataScreen());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataScreen(error.toString()));
    });
  }

  CategoryModel? categoryModel;

  void getcategoryData() {
    dioHelper.getData(url: Get_Categories, token: token).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);

      emit(ShopSuccessCategoriesDataScreen());
    }).catchError((error) {
      emit(ShopErrorCategoriesDataScreen(error.toString()));
    });
  }

  ChangeFavouritesModel? changeFavouritesModel;
  void changeFavourites(int productId) {
    favourites[productId] = !favourites[productId]!;
    emit(ShopChangeFavoritesState());

    dioHelper
        .postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    )
        .then((value) {
      changeFavouritesModel = ChangeFavouritesModel.fromjson(value.data);
      if (kDebugMode) {
        print(value.data);
      }
      if (!changeFavouritesModel!.status!) {
        favourites[productId] = !favourites[productId]!;
        getFavorites();
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavouritesModel!));
    }).catchError((error) {
      emit(ShopErrorChangeFavoritesState(error));
    });
  }

  //////////////////////////////////////////////////////////////////////////
  /// Get Favourites
  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    dioHelper
        .getData(
      url: FAVORITES,
      token: token,
    )
        .then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      if (kDebugMode) {
        print(value.data);
      }
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorGetFavoritesState(error.toString()));
    });
  }
}
