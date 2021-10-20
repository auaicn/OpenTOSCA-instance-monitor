import 'blkio_stats.dart';
import 'cpu_stats.dart';
import 'memory_stats.dart';
import 'networks.dart';
import 'pids_stats.dart';

class ContainerInformation {
  String read;
  String preread;
  PidsStats pidsStats;
  BlkioStats blkioStats;
  int numProcs;
  // StorageStats storageStats;
  CpuStats cpuStats;
  CpuStats precpuStats;
  MemoryStats memoryStats;
  String name;
  String id;
  Networks networks;

  ContainerInformation({this.read, this.preread, this.pidsStats, this.blkioStats, this.numProcs, this.cpuStats, this.precpuStats, this.memoryStats, this.name, this.id, this.networks});

  ContainerInformation.fromJson(Map<String, dynamic> json) {
    read = json['read'];
    preread = json['preread'];
    pidsStats = json['pids_stats'] != null ? new PidsStats.fromJson(json['pids_stats']) : null;
    blkioStats = json['blkio_stats'] != null ? new BlkioStats.fromJson(json['blkio_stats']) : null;
    numProcs = json['num_procs'];
    // storageStats = json['storage_stats'] != null ? new StorageStats.fromJson(json['storage_stats']) : null;
    cpuStats = json['cpu_stats'] != null ? new CpuStats.fromJson(json['cpu_stats']) : null;
    precpuStats = json['precpu_stats'] != null ? new CpuStats.fromJson(json['precpu_stats']) : null;
    memoryStats = json['memory_stats'] != null ? new MemoryStats.fromJson(json['memory_stats']) : null;
    name = json['name'];
    id = json['id'];
    networks = json['networks'] != null ? new Networks.fromJson(json['networks']) : null;
  }
}
