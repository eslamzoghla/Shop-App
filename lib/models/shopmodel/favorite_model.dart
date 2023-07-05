class ChangeFavouritesModel {
  bool? status;
  String? message;
  ChangeFavouritesModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
