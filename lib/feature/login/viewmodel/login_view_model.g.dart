// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginViewModel on _LoginViewModelBase, Store {
  late final _$obscureTextAtom =
      Atom(name: '_LoginViewModelBase.obscureText', context: context);

  @override
  bool get obscureText {
    _$obscureTextAtom.reportRead();
    return super.obscureText;
  }

  @override
  set obscureText(bool value) {
    _$obscureTextAtom.reportWrite(value, super.obscureText, () {
      super.obscureText = value;
    });
  }

  late final _$_LoginViewModelBaseActionController =
      ActionController(name: '_LoginViewModelBase', context: context);

  @override
  void passwordVisibility() {
    final _$actionInfo = _$_LoginViewModelBaseActionController.startAction(
        name: '_LoginViewModelBase.passwordVisibility');
    try {
      return super.passwordVisibility();
    } finally {
      _$_LoginViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
obscureText: ${obscureText}
    ''';
  }
}
