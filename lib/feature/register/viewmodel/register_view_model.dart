import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../core/base/model/base_view_model.dart';
import '../../../core/components/toast-message/toast_message.dart';
import '../../../core/constants/http/http_url.dart';
import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../core/init/navigation/navigation_service.dart';

part 'register_view_model.g.dart';

class RegisterViewModel = _RegisterViewModelBase with _$RegisterViewModel;

abstract class _RegisterViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @observable
  bool obscureText = true;

  @action
  void passwordVisibility() {
    obscureText = !obscureText;
  }

  Future<void> createUser(String? name, String? surname, String email) async {
    final url = HttpUrls.instance.createUser;

    final Map<String, dynamic> data = {
      'name': name,
      'surname': surname,
      'email': email,
    };

    try {
      await Dio().post(url, data: data);
      NavigationService.instance
          .navigateToPage(path: NavigationConstants.HOME_VIEW);
    } catch (error) {
      ToastMessage.instance.buildMessage(LocaleKeys.error_errorCreateAccount);
    }
  }

  Future<void> register({
    String? name,
    String? surname,
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      createUser(name, surname, email);

      ToastMessage.instance.buildMessage(LocaleKeys.toastMessage_accountCreate);

      NavigationService.instance.navigateToPageClear(
        path: NavigationConstants.SPLASH_VIEW,
      );
    } on FirebaseAuthException {
      ToastMessage.instance.buildMessage(LocaleKeys.error_unexpectedError);
    }
  }
}
