import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../core/base/model/base_view_model.dart';
import '../../../core/constants/enums/page_state.dart';
import '../../../core/constants/http/http_url.dart';
import '../model/user_model.dart';

part 'profile_view_model.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    getUserByUserId();
  }

  @observable
  UserModel? user;

  @action
  Future<void> getUserByUserId() async {
    String url = HttpUrls.instance.getUserByUserId;
    try {
      final response = await Dio().get(url);

      if (response.statusCode == HttpStatus.ok) {
        final Map<String, dynamic> userData = response.data;
        user = UserModel().fromJson(userData);
        pageState = PageState.SUCCESS;
      }
    } catch (error) {
      pageState = PageState.ERROR;
    }
  }

  @observable
  PageState pageState = PageState.NORMAL;
}
