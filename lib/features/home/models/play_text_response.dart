class PlayTextResponse {
  int? result;
  int? status;
  String? message;
  List<PlayText>? data;

  PlayTextResponse({this.result, this.status, this.message, this.data});

  PlayTextResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PlayText>[];
      json['data'].forEach((v) {
        data!.add(PlayText.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlayText {
  int? id;
  String? text;
  String? createdAt;
  String? updatedAt;

  PlayText({this.id, this.text, this.createdAt, this.updatedAt});

  PlayText.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
