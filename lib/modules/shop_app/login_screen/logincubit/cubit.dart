import 'package:first_project/models/shopmodel/login_model.dart';
import 'package:first_project/modules/shop_app/login_screen/logincubit/state.dart';
import 'package:first_project/network/end_poients.dart';
import 'package:first_project/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  late LoginModel UserLoginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    dioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      UserLoginModel = LoginModel.fromJson(value.data);
      emit(ShopLoginSucessState(UserLoginModel));
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void ChangeVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopLoginChangeVisibilityState());
  }
}
