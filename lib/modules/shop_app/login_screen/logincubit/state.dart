import '../../../../models/shopmodel/login_model.dart';

abstract class ShopLoginState {}

class ShopLoginInitialState extends ShopLoginState {}

class ShopLoginSucessState extends ShopLoginState {
  final LoginModel UserLoginModel;
  ShopLoginSucessState(this.UserLoginModel);
}

class ShopLoginLoadingState extends ShopLoginState {}

class ShopLoginErrorState extends ShopLoginState {
  final String error;
  ShopLoginErrorState(this.error);
}

class ShopLoginChangeVisibilityState extends ShopLoginState {}
