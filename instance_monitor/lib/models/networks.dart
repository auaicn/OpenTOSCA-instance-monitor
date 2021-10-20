import 'eth0.dart';

class Networks {
  Eth0 eth0;

  Networks({this.eth0});

  Networks.fromJson(Map<String, dynamic> json) {
    eth0 = json['eth0'] != null ? new Eth0.fromJson(json['eth0']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eth0 != null) {
      data['eth0'] = this.eth0.toJson();
    }
    return data;
  }
}
