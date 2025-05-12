import 'package:flutter/material.dart';

class NavigationHelper {
  final BuildContext context;

  NavigationHelper(this.context);

  void navigateToPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void navigateToPageAndReplace(Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void navigateToPageWithName(String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  void navigateToPageAndReplaceWithName(String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  void goBack() {
    Navigator.pop(context);
  }
}
