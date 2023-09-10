import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../core/base/model/base_view_model.dart';
import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../core/init/navigation/navigation_service.dart';

part 'splash_view_model.g.dart';

class SplashViewModel = _SplashViewModelBase with _$SplashViewModel;

abstract class _SplashViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    startTimer();
  }

  startTimer() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  void route() {
    if (FirebaseAuth.instance.currentUser != null) {
      NavigationService.instance.navigateToPageClear(
        path: NavigationConstants.HOME_VIEW,
      );
    } else {
      NavigationService.instance.navigateToPage(
        path: NavigationConstants.LOGIN_VIEW,
      );
    }
  }
}
