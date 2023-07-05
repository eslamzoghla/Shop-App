import 'package:flutter/material.dart';


class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Favorites',style: Theme.of(context).textTheme.bodyText1,),
    );
  }
}