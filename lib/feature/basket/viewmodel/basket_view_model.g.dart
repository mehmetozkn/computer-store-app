// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BasketViewModel on _BasketViewModelBase, Store {
  late final _$totalAmountAtom =
      Atom(name: '_BasketViewModelBase.totalAmount', context: context);

  @override
  double get totalAmount {
    _$totalAmountAtom.reportRead();
    return super.totalAmount;
  }

  @override
  set totalAmount(double value) {
    _$totalAmountAtom.reportWrite(value, super.totalAmount, () {
      super.totalAmount = value;
    });
  }

  late final _$productsAtom =
      Atom(name: '_BasketViewModelBase.products', context: context);

  @override
  List<BasketProductModel> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(List<BasketProductModel> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$pageStateAtom =
      Atom(name: '_BasketViewModelBase.pageState', context: context);

  @override
  PageState get pageState {
    _$pageStateAtom.reportRead();
    return super.pageState;
  }

  @override
  set pageState(PageState value) {
    _$pageStateAtom.reportWrite(value, super.pageState, () {
      super.pageState = value;
    });
  }

  late final _$addProductToBasketAsyncAction =
      AsyncAction('_BasketViewModelBase.addProductToBasket', context: context);

  @override
  Future<void> addProductToBasket(int? productId, int value, int? quantity) {
    return _$addProductToBasketAsyncAction
        .run(() => super.addProductToBasket(productId, value, quantity));
  }

  late final _$fetchProductsAsyncAction =
      AsyncAction('_BasketViewModelBase.fetchProducts', context: context);

  @override
  Future<void> fetchProducts() {
    return _$fetchProductsAsyncAction.run(() => super.fetchProducts());
  }

  late final _$_BasketViewModelBaseActionController =
      ActionController(name: '_BasketViewModelBase', context: context);

  @override
  void calculateTotalPrice(List<BasketProductModel> products) {
    final _$actionInfo = _$_BasketViewModelBaseActionController.startAction(
        name: '_BasketViewModelBase.calculateTotalPrice');
    try {
      return super.calculateTotalPrice(products);
    } finally {
      _$_BasketViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
totalAmount: ${totalAmount},
products: ${products},
pageState: ${pageState}
    ''';
  }
}
