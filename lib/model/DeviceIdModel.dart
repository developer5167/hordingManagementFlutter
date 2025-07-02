
class DeviceIdModel {
  String? deviceId;

  DeviceIdModel({this.deviceId});

  DeviceIdModel.fromJson(Map<String, dynamic> json) {
    deviceId = json['device_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['device_id'] = deviceId;
    return data;
  }
}