import 'dart:io';
import '../../../core/base/model/base_view_model.dart';
import '../../../core/components/toast-message/toast_message.dart';
import '../../../core/constants/enums/page_state.dart';
import '../../../core/constants/http/http_url.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../model/product_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    getAllProduct();
    fetchProducts();
  }

  TextStyle style = const TextStyle(color: Colors.black);

  Future<void> addProductToBasket(int productId) async {
    final url = HttpUrls.instance.addProductToBasket;

    final data = {
      "userId": 1,
      "productId": productId,
      "quantity": 1,
    };

    try {
      final response = await Dio().post(url, data: data);
      if (response.statusCode == 200) {
        ToastMessage.instance.buildMessage(LocaleKeys.order_addToBasket);
        fetchProducts();
      } else {
        ToastMessage.instance.buildMessage(LocaleKeys.order_notAddProduct);
      }
    } catch (error) {
      ToastMessage.instance.buildMessage(LocaleKeys.error_unexpectedError);
    }
  }

  @observable
  int basketItemCount = 0;

  @action
  void updateBasketItemCount(int count) {
    basketItemCount = count;
  }

  @observable
  int? selectedRam;

  @action
  List<ProductModel> getProductsByRam(int? ram) {
    if (ram == null) {
      selectedRam = null;
      return products;
    } else {
      selectedRam = ram;
      return products.where((product) => product.ram == ram).toList();
    }
  }

  @action
  Future<void> fetchProducts() async {
    try {
      final response = await Dio().get(HttpUrls.instance.getProductsByUserId);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        int productCount = 0;

        for (var item in data) {
          final int quantity = item['quantity'] ?? 0;
          if (quantity > 0) {
            productCount++;
          }
        }

        updateBasketItemCount(productCount);
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (error) {
      throw Exception('$error');
    }
  }

  @observable
  List<ProductModel> products = [];

  @observable
  PageState pageState = PageState.NORMAL;

  @action
  Future<void> getAllProduct() async {
    final url = HttpUrls.instance.getAllProducts;
    pageState = PageState.LOADING;

    try {
      final response = await Dio().get(url);

      if (response.statusCode == HttpStatus.ok) {
        final responseData = response.data as List;
        products = responseData.map((e) => ProductModel().fromJson(e)).toList();
        pageState = PageState.SUCCESS;
      }
    } catch (e) {
      pageState = PageState.ERROR;
    }
  }
}
