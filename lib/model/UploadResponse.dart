class UploadResponse {
  List<String>? uploadedFiles;

  UploadResponse({this.uploadedFiles});

  UploadResponse.fromJson(Map<String, dynamic> json) {
    uploadedFiles = json['uploadedFiles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uploadedFiles'] = uploadedFiles;
    return data;
  }
}