
class CreateAccountModel {
  String? email;
  String? password;
  String? name;
  String? mobileNumber;
  String? isActive;
  String? fcmtoken;

  CreateAccountModel(
      {this.email,
        this.password,
        this.name,
        this.mobileNumber,
        this.isActive,
        this.fcmtoken});

  CreateAccountModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    name = json['name'];
    mobileNumber = json['mobile_number'];
    isActive = json['isActive'];
    fcmtoken = json['fcmtoken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    data['mobile_number'] = mobileNumber;
    data['isActive'] = isActive;
    data['fcmtoken'] = fcmtoken;
    return data;
  }
}