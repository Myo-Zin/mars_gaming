class ProfileResponse {
  int? result;
  int? status;
  String? message;
  String? image;
  ProfileData? data;

  ProfileResponse(
      {this.result, this.status, this.message, this.image, this.data});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    status = json['status'];
    message = json['message'];
    image = json['image'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }
}

class ProfileData {
  int? id;
  int? superAdminId;
  int? seniorAgentId;
  int? masterAgentId;
  int? agentId;
  String? name;
  String? userCode;
  String? referral;
  int? referCount;
  int? referralId;
  String? phone;
  String? balance;
  String? gameBalance;
  String? turnover;
  String? gameReferAmt;
  String? image;
  int? role;
  int? block;
  int? lvl2;
  String? email;
  String? birthday;
  String? deviceToken;
  String? delete;
  String? spFreeTime;
  String? createdAt;
  String? updatedAt;
  //custom
  String? token;

  ProfileData({
    this.id,
    this.superAdminId,
    this.seniorAgentId,
    this.masterAgentId,
    this.agentId,
    this.name,
    this.userCode,
    this.referral,
    this.referCount,
    this.referralId,
    this.phone,
    this.balance,
    this.gameBalance,
    this.turnover,
    this.gameReferAmt,
    this.image,
    this.role,
    this.block,
    this.lvl2,
    this.email,
    this.birthday,
    this.deviceToken,
    this.delete,
    this.spFreeTime,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    superAdminId = json['super_admin_id'];
    seniorAgentId = json['senior_agent_id'];
    masterAgentId = json['master_agent_id'];
    agentId = json['agent_id'];
    name = json['name'];
    userCode = json['user_code'];
    referral = json['referral'];
    referCount = json['refer_count'];
    referralId = json['referral_id'];
    phone = json['phone'];
    balance = json['balance'];
    gameBalance = json['game_balance'];
    turnover = json['turnover'];
    gameReferAmt = json['game_refer_amt'];
    image = json['image'];
    role = json['role'];
    block = json['block'];
    lvl2 = json['lvl_2'];
    email = json['email'];
    birthday = json['birthday'];
    deviceToken = json['device_token'];
    delete = json['delete'];
    spFreeTime = json['sp_free_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  ProfileData copyWith({
    int? id,
    int? superAdminId,
    int? seniorAgentId,
    int? masterAgentId,
    int? agentId,
    String? name,
    String? userCode,
    String? referral,
    int? referCount,
    int? referralId,
    String? phone,
    String? balance,
    String? gameBalance,
    String? turnover,
    String? gameReferAmt,
    String? image,
    int? role,
    int? block,
    int? lvl2,
    String? email,
    String? birthday,
    String? deviceToken,
    String? delete,
    String? spFreeTime,
    String? createdAt,
    String? updatedAt,
    String? token,
  }) {
    return ProfileData(
      id: id ?? this.id,
      superAdminId: superAdminId ?? this.superAdminId,
      seniorAgentId: seniorAgentId ?? this.seniorAgentId,
      masterAgentId: masterAgentId ?? this.masterAgentId,
      agentId: agentId ?? this.agentId,
      name: name ?? this.name,
      userCode: userCode ?? this.userCode,
      referral: referral ?? this.referral,
      referCount: referCount ?? this.referCount,
      referralId: referralId ?? this.referralId,
      phone: phone ?? this.phone,
      balance: balance ?? this.balance,
      gameBalance: gameBalance ?? this.gameBalance,
      turnover: turnover ?? this.turnover,
      gameReferAmt: gameReferAmt ?? this.gameReferAmt,
      image: image ?? this.image,
      role: role ?? this.role,
      block: block ?? this.block,
      lvl2: lvl2 ?? this.lvl2,
      email: email ?? this.email,
      birthday: birthday ?? this.birthday,
      deviceToken: deviceToken ?? this.deviceToken,
      delete: delete ?? this.delete,
      spFreeTime: spFreeTime ?? this.spFreeTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      token: token ?? this.token,
    );
  }
}
