class FirebaseCustomException implements Exception {
  final String descrption;

  FirebaseCustomException(this.descrption);
  @override
  String toString() {
    return '$this $descrption';
  }
}
