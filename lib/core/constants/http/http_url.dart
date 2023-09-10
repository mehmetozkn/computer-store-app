class HttpUrls {
  static HttpUrls? _instance;
  static HttpUrls get instance {
    _instance ??= HttpUrls._init();
    return _instance!;
  }

  String get addProductToBasket =>
      "http://localhost:8080/v1/operation/addProductToBasket";

  String get clearBasket => "http://localhost:8080/v1/operation/deleteAll";

  String get getAllProducts => "http://localhost:8080/v1/product/getAll";

  String get createUser => "http://localhost:8080/v1/user/create";

  String get getProductsByUserId =>
      "http://localhost:8080/v1/user/getProductsByUserId/1";

  String get getUserByUserId => "http://localhost:8080/v1/user/getUserById/1";

  HttpUrls._init();
}
