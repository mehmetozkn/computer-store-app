import '../../../core/base/model/base_view_model.dart';
import '../../../core/components/toast-message/toast_message.dart';
import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../core/init/navigation/navigation_service.dart';
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
      await ToastMessage.instance.buildMessage(LocaleKeys.login_doingLogin);
      NavigationService.instance.navigateToPageClear(
        path: NavigationConstants.HOME_VIEW,
      );
    } catch (e) {
      ToastMessage.instance.buildMessage(LocaleKeys.error_wrongPasswordOrEmail);
    }
  }
}
