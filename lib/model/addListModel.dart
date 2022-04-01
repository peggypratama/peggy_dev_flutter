class AddListModel {
  AddListModel({
    required this.statusCode,
    required this.message,
     this.errorMessage,
    required this.data,
  });
  late final int statusCode;
  late final String message;
  late final Null errorMessage;
  late final Data data;
  
  AddListModel.fromJson(Map<String, dynamic> json){
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
    required this.id,
    required this.name,
     this.items,
    required this.checklistCompletionStatus,
  });
  late final int id;
  late final String name;
  late final Null items;
  late final bool checklistCompletionStatus;
  
  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    items = null;
    checklistCompletionStatus = json['checklistCompletionStatus'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['items'] = items;
    _data['checklistCompletionStatus'] = checklistCompletionStatus;
    return _data;
  }
}