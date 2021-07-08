import 'package:binder/screens/binders_screen.dart';
import 'package:flutter/material.dart';

class Navigation extends ChangeNotifier {
  String currentPage = BindersScreen.id;
  Widget currentWidget = BindersScreen();
}
