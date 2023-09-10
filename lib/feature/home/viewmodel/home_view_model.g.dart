// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  late final _$cartItemCountAtom =
      Atom(name: '_HomeViewModelBase.cartItemCount', context: context);

  @override
  int get basketItemCount {
    _$cartItemCountAtom.reportRead();
    return super.basketItemCount;
  }

  @override
  set basketItemCount(int value) {
    _$cartItemCountAtom.reportWrite(value, super.basketItemCount, () {
      super.basketItemCount = value;
    });
  }

  late final _$selectedRamAtom =
      Atom(name: '_HomeViewModelBase.selectedRam', context: context);

  @override
  int? get selectedRam {
    _$selectedRamAtom.reportRead();
    return super.selectedRam;
  }

  @override
  set selectedRam(int? value) {
    _$selectedRamAtom.reportWrite(value, super.selectedRam, () {
      super.selectedRam = value;
    });
  }

  late final _$productsAtom =
      Atom(name: '_HomeViewModelBase.products', context: context);

  @override
  List<ProductModel> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(List<ProductModel> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$pageStateAtom =
      Atom(name: '_HomeViewModelBase.pageState', context: context);

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

  late final _$fetchProductsAsyncAction =
      AsyncAction('_HomeViewModelBase.fetchProducts', context: context);

  @override
  Future<void> fetchProducts() {
    return _$fetchProductsAsyncAction.run(() => super.fetchProducts());
  }

  late final _$getAllProductAsyncAction =
      AsyncAction('_HomeViewModelBase.getAllProduct', context: context);

  @override
  Future<void> getAllProduct() {
    return _$getAllProductAsyncAction.run(() => super.getAllProduct());
  }

  late final _$_HomeViewModelBaseActionController =
      ActionController(name: '_HomeViewModelBase', context: context);

  @override
  void updateBasketItemCount(int count) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.updateCartItemCount');
    try {
      return super.updateBasketItemCount(count);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<ProductModel> getProductsByRam(int? ram) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.getProductsByRam');
    try {
      return super.getProductsByRam(ram);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cartItemCount: ${basketItemCount},
selectedRam: ${selectedRam},
products: ${products},
pageState: ${pageState}
    ''';
  }
}
