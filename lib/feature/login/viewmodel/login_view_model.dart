import 'package:computer_store_app/core/base/model/base_view_model.dart';
import 'package:computer_store_app/core/components/toast-message/toast_message.dart';
import 'package:computer_store_app/core/constants/navigation/navigation_constants.dart';
import 'package:computer_store_app/core/extension/string_extension.dart';
import 'package:computer_store_app/core/init/language/locale_keys.g.dart';
import 'package:computer_store_app/core/init/navigation/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @observable
  bool obscureText = true;

  @action
  void passwordVisibility() {
    obscureText = !obscureText;
  }

  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      ToastMessage.instance.buildMessage(LocaleKeys.login_doingLogin);
      NavigationService.instance.navigateToPageClear(
        path: NavigationConstants.HOME_VIEW,
      );
    } catch (e) {
      ToastMessage.instance.buildMessage(LocaleKeys.error_wrongPasswordOrEmail);
    }
  }
}
