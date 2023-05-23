class AppUpdateResponse {
  AppUpdateData? data;

  AppUpdateResponse({this.data});

  AppUpdateResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? AppUpdateData.fromJson(json['data']) : null;
  }
}
class AppUpdateData    {
  int? id;
  int? versionCode;
  String? versionName;
  String? downloadLink;
  int? forceUpdate;
  int? showWallet;
  String? createdAt;
  String? updatedAt;
  String? description;

  AppUpdateData({
    this.id,
    this.versionCode,
    this.versionName,
    this.downloadLink,
    this.forceUpdate,
    this.showWallet,
    this.createdAt,
    this.updatedAt,
    this.description,
  });

  AppUpdateData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    versionCode = json['version_code'];
    versionName = json['version_name'];
    downloadLink = json['playstore'];
    forceUpdate = json['force_update'];
    showWallet = json["show_wallet"];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    description = json['description'];
  }

  @override
  String toString() {
    return 'AppUpdateData(id: $id, versionCode: $versionCode, versionName: $versionName, downloadLink: $downloadLink, forceUpdate: $forceUpdate, showWallet: $showWallet, createdAt: $createdAt, updatedAt: $updatedAt, description: $description)';
  }
}
