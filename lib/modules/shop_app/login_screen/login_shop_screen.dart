import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first_project/layout/shop_app/shop_layout.dart';
import 'package:first_project/modules/shop_app/login_screen/logincubit/cubit.dart';
import 'package:first_project/modules/shop_app/login_screen/logincubit/state.dart';
import 'package:first_project/modules/shop_app/products/product_screen.dart';
import 'package:first_project/modules/shop_app/register_screen/shop_register_screen.dart';
import 'package:first_project/network/local/cache_helper.dart';
import 'package:first_project/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginShopScreen extends StatelessWidget {
  static const String routeName = 'LoginShopScreen';
  var emailCon = TextEditingController();
  var passwordCon = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (context, state) {
          if (state is ShopLoginSucessState) {
            if (state.UserLoginModel.status) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.rightSlide,
                title: 'Login Success',
                desc: state.UserLoginModel.message,
                // btnOkOnPress: () {},
                autoHide: Duration(milliseconds: 1200),
              )..show();
              print(state.UserLoginModel.message);
              print(state.UserLoginModel.data.token);
              cashesHelper
                  .saveData(
                      key: 'token', value: state.UserLoginModel.data.token)
                  .then(
                    (value) => navigateAndReplace(context, ShopLayout()),
                  );
            } else {
              print(state.UserLoginModel.message);
              Fluttertoast.showToast(
                  msg: state.UserLoginModel.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsetsDirectional.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          'login to view offers',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 25,
                        ),

                        // <<<<<<<<<<<<<<<<<<<<<<<<< Email Field>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                        defaultFormField(
                          testLabel: 'Email',
                          control: emailCon,
                          prefix: Icons.email_outlined,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'You must enter your email';
                            }
                          },
                          typingStyle: TextStyle(fontSize: 24),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        //<<<<<<<<<<<<<<<<<<<<<<< Password Field >>>>>>>>>>>>>>>>>>>>>>>>>>>>
                        defaultFormField(
                          testLabel: 'password',
                          prefix: Icons.password_outlined,
                          control: passwordCon,
                          type: TextInputType.visiblePassword,
                          suffix: ShopLoginCubit.get(context).suffix,
                          suffixPress:
                              ShopLoginCubit.get(context).ChangeVisibility,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'You must enter password!';
                            }
                          },
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          typingStyle: TextStyle(fontSize: 24),
                        ),
                        SizedBox(
                          height: 30,
                        ),

                        //<<<<<<<<<<<<<<<<<<<<<<<<<< Login Button >>>>>>>>>>>>>>>>>>>>>>
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                            fun: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailCon.text,
                                  password: passwordCon.text,
                                );
                              }
                            },
                            text: 'login',
                            radius: 30,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text('Don\'t have an account? '),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, ShopRigisterScreen());
                              },
                              child: Text('Register now'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
