
class Message {
  String? message;
  String? email;

  Message({this.message,this.email});

  Message.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['email'] = email;
    return data;
  }
}
