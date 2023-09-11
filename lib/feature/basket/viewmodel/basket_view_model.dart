import 'dart:io';

import 'package:computer_store_app/core/components/toast-message/toast_message.dart';
import 'package:computer_store_app/core/constants/enums/page_state.dart';
import 'package:computer_store_app/core/constants/http/http_url.dart';
import 'package:computer_store_app/core/constants/navigation/navigation_constants.dart';
import 'package:computer_store_app/core/extension/string_extension.dart';
import 'package:computer_store_app/core/init/language/locale_keys.g.dart';
import 'package:computer_store_app/core/init/navigation/navigation_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../core/base/model/base_view_model.dart';
import '../model/basket_product_model.dart';

part 'basket_view_model.g.dart';

class BasketViewModel = _BasketViewModelBase with _$BasketViewModel;

abstract class _BasketViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() async {
    await fetchProducts();
    calculateTotalPrice(products);
  }

  @observable
  double totalAmount = 0;

  @action
  void calculateTotalPrice(List<BasketProductModel> products) {
    totalAmount = 0;
    for (int index = 0; index < products.length; index++) {
      int productPrice = products[index].product?.price ?? 0;
      int productQuantity = products[index].quantity ?? 1;
      totalAmount += productPrice * productQuantity;
    }
  }

  @action
  Future<void> addProductToBasket(
      int? productId, int value, int? quantity) async {
    String url = HttpUrls.instance.addProductToBasket;
    int id = int.parse(HttpUrls.instance.getProductsByUserId.characters.last);
    var data = {};

    if (quantity! > 0) {
      data = {"userId": id, "productId": productId, "quantity": value};
    } else if (quantity == 0) {
      data = {
        "userId": id,
        "productId": productId,
        "quantity": value > 0 ? value : 0
      };
    }

    try {
      final response = await Dio().post(url, data: data);
      if (response.statusCode == 200) {
        value == 1
            ? ToastMessage.instance.buildMessage(LocaleKeys.order_addToBasket)
            : ToastMessage.instance
                .buildMessage(LocaleKeys.order_removeToBasket);
        await fetchProducts();
        calculateTotalPrice(products);
      } else {
        ToastMessage.instance.buildMessage(LocaleKeys.error_unexpectedError);
      }
    } catch (error) {
      ToastMessage.instance.buildMessage(LocaleKeys.error_unexpectedError);
    }
  }

  Future<void> clearBasket() async {
    String url = HttpUrls.instance.clearBasket;
    try {
      final response = await Dio().delete(url);

      if (response.statusCode == HttpStatus.ok) {
        ToastMessage.instance.buildMessage(LocaleKeys.order_succesfullOrder);
        NavigationService.instance
            .navigateToPageClear(path: NavigationConstants.HOME_VIEW);
        pageState = PageState.SUCCESS;
      }
    } catch (error) {
      pageState = PageState.ERROR;
    }
  }

  @observable
  List<BasketProductModel> products = [];

  @action
  Future<void> fetchProducts() async {
    String url = HttpUrls.instance.getProductsByUserId;
    pageState = PageState.LOADING;
    try {
      final response = await Dio().get(url);

      if (response.statusCode == HttpStatus.ok) {
        final responseData = response.data as List;
        products =
            responseData.map((e) => BasketProductModel().fromJson(e)).toList();
        pageState = PageState.SUCCESS;
      }
    } catch (error) {
      pageState = PageState.ERROR;
    }
  }

  @observable
  PageState pageState = PageState.NORMAL;
}
