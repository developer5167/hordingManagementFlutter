class LoginResponse {
  String? email;
  String? token;
  int? userId;
  String? name;
  String? joined;
  String? mobileNumber;

  LoginResponse(
      {this.email,
        this.token,
        this.userId,
        this.name,
        this.joined,
        this.mobileNumber});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    token = json['token'];
    userId = json['user_id'];
    name = json['name'];
    joined = json['joined'];
    mobileNumber = json['mobile_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['token'] = token;
    data['user_id'] = userId;
    data['name'] = name;
    data['joined'] = joined;
    data['mobile_number'] = mobileNumber;
    return data;
  }
}