class CpuUsage {
  int totalUsage;
  List<int> percpuUsage;
  int usageInKernelmode;
  int usageInUsermode;

  CpuUsage({this.totalUsage, this.percpuUsage, this.usageInKernelmode, this.usageInUsermode});

  CpuUsage.fromJson(Map<String, dynamic> json) {
    totalUsage = json['total_usage'];
    percpuUsage = json['percpu_usage'].cast<int>();
    usageInKernelmode = json['usage_in_kernelmode'];
    usageInUsermode = json['usage_in_usermode'];
  }
}
