import 'cpu_usage.dart';
import 'throttling_data.dart';

class CpuStats {
  CpuUsage cpuUsage;
  int systemCpuUsage;
  int onlineCpus;
  ThrottlingData throttlingData;

  CpuStats({this.cpuUsage, this.systemCpuUsage, this.onlineCpus, this.throttlingData});

  CpuStats.fromJson(Map<String, dynamic> json) {
    cpuUsage = json['cpu_usage'] != null ? new CpuUsage.fromJson(json['cpu_usage']) : null;
    systemCpuUsage = json['system_cpu_usage'];
    onlineCpus = json['online_cpus'];
    throttlingData = json['throttling_data'] != null ? new ThrottlingData.fromJson(json['throttling_data']) : null;
  }
}
