import 'package:first_project/layout/shop_app/shop_layout.dart';
import 'package:first_project/modules/shop_app/cubit/cubit.dart';
import 'package:first_project/modules/shop_app/login_screen/login_shop_screen.dart';
import 'package:first_project/modules/shop_app/onboard_screen/on_board_screen.dart';
import 'package:first_project/network/remote/dio_helper.dart';
import 'package:first_project/shared/components/contants.dart';
import 'package:first_project/shared/components/observation.dart';
import 'package:first_project/styles/cubit/cubit.dart';
import 'package:first_project/styles/cubit/states.dart';
import 'package:first_project/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'network/local/cache_helper.dart';

void main() async {
  // used to print all moves in program and this block work nice or not
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  dioHelper.init();
  await cashesHelper.init();

  bool? darkMode = cashesHelper.getData(key: 'darkMode');

  bool? onBoardSaving = cashesHelper.getData(key: 'onBoarding');

  token = cashesHelper.getData(key: 'token');
  Widget widget;

  if (onBoardSaving != null) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = LoginShopScreen();
    }
  } else {
    widget = OnBoardScreen();
  }

  print(onBoardSaving);
  runApp(MyApp(darkMode: darkMode, startWidget: widget));
}

class MyApp extends StatelessWidget {
  final bool? darkMode;
  final Widget? startWidget;

  MyApp({this.darkMode, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getcategoryData()
              ..getFavorites()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // to hide red bar in top screen
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).darkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            routes: {
              OnBoardScreen.routeName: (myContext) => OnBoardScreen(),
              LoginShopScreen.routeName: (myContext) => LoginShopScreen(),
              ShopLayout.routeName: (myContext) => ShopLayout(),
            },
            // initialRoute: startWidget,
            home: startWidget,
          );
        },
      ),
    );
  }
}
