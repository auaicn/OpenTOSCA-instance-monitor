import 'container_information.dart';

class ContainerStatus {
  ContainerInformation containerInformation;

  // high-level metrics
  int usedMemory;
  int availableMemory;
  int cpuDelta;
  int systemCpuDelta;
  int numberCpus;

  double memoryUsageInPercent;
  double cpuUsageInPercent;

  // constructor
  ContainerStatus.fromJson(Map json) {
    containerInformation = ContainerInformation.fromJson(json);
    _setHighLevelMetrics(containerInformation);
  }

  void _setHighLevelMetrics(ContainerInformation containerInformation) {
    usedMemory = containerInformation.memoryStats.usage - containerInformation.memoryStats.stats.cache;
    availableMemory = containerInformation.memoryStats.limit;
    cpuDelta = containerInformation.cpuStats.cpuUsage.totalUsage - containerInformation.precpuStats.cpuUsage.totalUsage;
    systemCpuDelta = containerInformation.cpuStats.systemCpuUsage - containerInformation.precpuStats.systemCpuUsage;
    numberCpus = containerInformation.cpuStats.onlineCpus;

    memoryUsageInPercent = (usedMemory / availableMemory) * 100.0;
    cpuUsageInPercent = (cpuDelta / systemCpuDelta) * numberCpus * 100.0;
  }
}
