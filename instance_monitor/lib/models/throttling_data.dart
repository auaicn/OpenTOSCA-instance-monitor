class ThrottlingData {
  int periods;
  int throttledPeriods;
  int throttledTime;

  ThrottlingData({this.periods, this.throttledPeriods, this.throttledTime});

  ThrottlingData.fromJson(Map<String, dynamic> json) {
    periods = json['periods'];
    throttledPeriods = json['throttled_periods'];
    throttledTime = json['throttled_time'];
  }
}
