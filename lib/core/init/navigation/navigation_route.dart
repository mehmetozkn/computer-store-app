import 'package:computer_store_app/feature/basket/view/basket_view.dart';
import 'package:computer_store_app/feature/home/view/home_view.dart';
import 'package:computer_store_app/feature/login/view/login_view.dart';
import 'package:computer_store_app/feature/profile/view/profile_view.dart';
import 'package:computer_store_app/feature/register/view/register_view.dart';
import 'package:flutter/material.dart';

import '../../constants/navigation/navigation_constants.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.LOGIN_VIEW:
        return normalNavigate(const LoginView());

      case NavigationConstants.REGISTER_VIEW:
        return normalNavigate(const RegisterView());

      case NavigationConstants.PROFILE_VIEW:
        return normalNavigate(const ProfileView());

      case NavigationConstants.HOME_VIEW:
        return normalNavigate(const HomeView());

      case NavigationConstants.BASKET_VIEW:
        return normalNavigate(const BasketView());

      default:
        return MaterialPageRoute(
          builder: (context) =>
              const Scaffold(body: Center(child: Text('Not Found Route'))),
        );
    }
  }

  MaterialPageRoute normalNavigate(Widget widget) {
    return MaterialPageRoute(
      builder: (context) => widget,
    );
  }
}
