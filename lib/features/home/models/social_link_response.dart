class SocialLinks {
  String? facebook;
  String? viber;
  String? messenger;
  String? instagram;
  String? playStore;
  String? qr;

  SocialLinks(
      {this.facebook,
      this.viber,
      this.messenger,
      this.instagram,
      this.playStore,
      this.qr});

  SocialLinks.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'];
    viber = json['viber'];
    messenger = json['messenger'];
    instagram = json['instagram'];
    playStore = json['play_store'];
    qr = json['qr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['facebook'] = facebook;
    data['viber'] = viber;
    data['messenger'] = messenger;
    data['instagram'] = instagram;
    data['play_store'] = playStore;
    data['qr'] = qr;
    return data;
  }
}
