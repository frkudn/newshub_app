

class CategoriesNewsModel {
  String? status;
  String? code;
  String? message;

  CategoriesNewsModel({this.status, this.code, this.message});

  CategoriesNewsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}