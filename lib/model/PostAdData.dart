class PostAdData {
  String? adData;
  int? userId;
  bool? isapproved;
  String? createdAt;
  String? memeType;
  bool? isactive;
  String? fileName;
  String? startDate;
  String? endDate;
  String? title;
  String? description;
  String? deviceId;

  PostAdData(
      {this.adData,
        this.userId,
        this.isapproved,
        this.createdAt,
        this.memeType,
        this.isactive,
        this.startDate,
        this.endDate,
        this.title,
        this.description,
        this.deviceId});

  PostAdData.fromJson(Map<String, dynamic> json) {
    adData = json['ad_data'];
    userId = json['user_id'];
    fileName = json['fileName'];
    isapproved = json['isapproved'];
    createdAt = json['created_at'];
    memeType = json['meme_type'];
    isactive = json['isactive'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    title = json['title'];
    description = json['description'];
    deviceId = json['device_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ad_data'] = adData;
    data['fileName'] = fileName;
    data['user_id'] = userId;
    data['isapproved'] = isapproved;
    data['created_at'] = createdAt;
    data['meme_type'] = memeType;
    data['isactive'] = isactive;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['title'] = title;
    data['description'] = description;
    data['device_id'] = deviceId;
    return data;
  }
}