import 'stats.dart';

class MemoryStats {
  int usage;
  int maxUsage;
  Stats stats;
  int limit;

  MemoryStats({this.usage, this.maxUsage, this.stats, this.limit});

  MemoryStats.fromJson(Map<String, dynamic> json) {
    usage = json['usage'];
    maxUsage = json['max_usage'];
    stats = json['stats'] != null ? new Stats.fromJson(json['stats']) : null;
    limit = json['limit'];
  }
}
