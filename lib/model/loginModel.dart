class LoginModel {
  LoginModel({
    required this.statusCode,
    required this.message,
     this.errorMessage,
    required this.data,
  });
  late final int statusCode;
  late final String message;
  late final Null errorMessage;
  late final Data data;
  
  LoginModel.fromJson(Map<String, dynamic> json){
    statusCode = json['statusCode'];
    message = json['message'];
    errorMessage = null;
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['message'] = message;
    _data['errorMessage'] = errorMessage;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.token,
  });
  late final String token;
  
  Data.fromJson(Map<String, dynamic> json){
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token;
    return _data;
  }
}