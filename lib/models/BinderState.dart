import 'package:flutter/cupertino.dart';

class BinderState extends ChangeNotifier {
  bool isTokenOpen = false;

  void openTokenDetails() {
    isTokenOpen = true;
    notifyListeners();
  }

  void closeTokenDetails() {
    isTokenOpen = false;
    notifyListeners();
  }
}
