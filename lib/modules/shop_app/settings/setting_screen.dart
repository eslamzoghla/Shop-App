import 'package:flutter/material.dart';


class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings',style: Theme.of(context).textTheme.bodyText1,),
    );
  }
}