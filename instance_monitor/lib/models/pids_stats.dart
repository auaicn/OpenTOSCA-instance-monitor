class PidsStats {
  int current;

  PidsStats({this.current});

  PidsStats.fromJson(Map<String, dynamic> json) {
    current = json['current'];
  }
}
