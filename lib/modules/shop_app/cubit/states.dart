import 'package:first_project/models/shopmodel/favorite_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNav extends ShopStates {}

class ShopLoadingHomeDataScreen extends ShopStates {}

class ShopSuccessHomeDataScreen extends ShopStates {}

class ShopErrorHomeDataScreen extends ShopStates {
  String? error;
  ShopErrorHomeDataScreen(this.error);
}

class ShopSuccessCategoriesDataScreen extends ShopStates {}

class ShopErrorCategoriesDataScreen extends ShopStates {
  String? error;
  ShopErrorCategoriesDataScreen(this.error);
}

///////////////////////////////////////////////////////////////////////////////
/// Favourites
class ShopChangeFavoritesLoadingHomeState extends ShopStates{}
class ShopSuccessChangeFavoritesState extends ShopStates {
final ChangeFavouritesModel model;
  ShopSuccessChangeFavoritesState(this.model);
}
class ShopErrorChangeFavoritesState extends ShopStates {
  final String error;
  ShopErrorChangeFavoritesState(this.error);
}
//////////////////////////////////////////////////////////////////////////////
class ShopChangeFavoritesState extends ShopStates {}
///////////////////////////////////////////////////////////////////////////////
/// Get favourites
class ShopSuccessGetFavoritesState extends ShopStates {}
class ShopErrorGetFavoritesState extends ShopStates {
  final String error;

  ShopErrorGetFavoritesState(this.error);
}
class ShopLoadingGetFavoritesState extends ShopStates {}