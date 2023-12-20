import 'package:flutter/material.dart';

class NavigationStore extends ChangeNotifier {
  int _selectedPage = 0;

  int get actualPage => _selectedPage;
  // var appState = ValueNotifier<AppState>(PendingAppState());

  set selectedPage(int selectedPage) {
    _selectedPage = selectedPage;
    notifyListeners();
  }
}
