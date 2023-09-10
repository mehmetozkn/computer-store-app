mixin class IdModel {
  int? id;
}

mixin BaseModel<T extends IdModel> {
  T fromJson(Map<String, dynamic> json);
}
