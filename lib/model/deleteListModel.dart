class DeleteListModel {
  DeleteListModel({
    required this.statusCode,
    required this.message,
    this.errorMessage,
    this.data,
  });
  late final int statusCode;
  late final String message;
  late final Null errorMessage;
  late final Null data;

  DeleteListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    errorMessage = null;
    data = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['message'] = message;
    _data['errorMessage'] = errorMessage;
    _data['data'] = data;
    return _data;
  }
}
