import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:first_project/modules/shop_app/cubit/cubit.dart';
import 'package:first_project/modules/shop_app/cubit/states.dart';
import 'package:first_project/modules/shop_app/login_screen/login_shop_screen.dart';
import 'package:first_project/modules/shop_app/search/search_screen.dart';
import 'package:first_project/network/local/cache_helper.dart';
import 'package:first_project/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';

class ShopLayout extends StatelessWidget {
  static const String routeName = 'ShopLayout';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('A4try'),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context, SearchScreen());
                    },
                    icon: Icon(Icons.search)),
                TextButton(
                  onPressed: () {
                    cashesHelper.removeData(key: 'token').then((value) =>
                        navigateAndReplace(context, LoginShopScreen()));
                  },
                  child: Text('SIGN OUT'),
                ),
              ],
            ),
            body: cubit.ShopScreens[cubit.currentIndex],
            bottomNavigationBar: CurvedNavigationBar(
              animationDuration: Duration(milliseconds: 500),
              animationCurve: Curves.easeInOutCubicEmphasized,
              color: defaultColor,
              backgroundColor: Colors.white,
              items: [
                Icon(
                  Icons.home_filled,
                  color: Colors.white,
                  size: 30,
                ),
                Icon(
                  Icons.category,
                  color: Colors.white,
                  size: 30,
                ),
                Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 30,
                ),
                Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 30,
                ),
              ],
              onTap: (index) {
                cubit.changeBottom(index);
              },
            ),
          );
        });
  }
}
