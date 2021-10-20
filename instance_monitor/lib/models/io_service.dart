class IoService {
  int major;
  int minor;
  String op;
  int value;

  IoService({this.major, this.minor, this.op, this.value});

  IoService.fromJson(Map<String, dynamic> json) {
    major = json['major'];
    minor = json['minor'];
    op = json['op'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['major'] = this.major;
    data['minor'] = this.minor;
    data['op'] = this.op;
    data['value'] = this.value;
    return data;
  }
}
