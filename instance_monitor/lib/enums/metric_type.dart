import 'package:flutter/material.dart';

enum MetricType {
  USED_MEMORY,
  AVAILABLE_MEMORY,
  CPU_DELTA,
  SYSTEM_CPU_DELTA,
  NUMBER_CPUS,
  MEMORY_USAGE_IN_PERCETAGE,
  CPU_USAGE_IN_PERCETAGE,
}

extension BusinessMethod on MetricType {
  String label() {
    switch (this) {
      case MetricType.USED_MEMORY:
        return 'USED_MEMORY';
      case MetricType.AVAILABLE_MEMORY:
        return 'AVAILABLE_MEMORY';
      case MetricType.CPU_DELTA:
        return 'CPU_DELTA';
      case MetricType.SYSTEM_CPU_DELTA:
        return 'SYSTEM_CPU_DELTA';
      case MetricType.NUMBER_CPUS:
        return 'NUMBER_CPUS';
      case MetricType.MEMORY_USAGE_IN_PERCETAGE:
        return 'MEMORY_USAGE_IN_PERCETAGE';
      case MetricType.CPU_USAGE_IN_PERCETAGE:
        return 'CPU_USAGE_IN_PERCETAGE';
      default:
        return '';
    }
  }

  Color color() {
    switch (this) {
      case MetricType.USED_MEMORY:
        return Colors.primaries[0];
      case MetricType.AVAILABLE_MEMORY:
        return Colors.primaries[1];
      case MetricType.CPU_DELTA:
        return Colors.primaries[2];
      case MetricType.SYSTEM_CPU_DELTA:
        return Colors.primaries[3];
      case MetricType.NUMBER_CPUS:
        return Colors.primaries[4];
      case MetricType.MEMORY_USAGE_IN_PERCETAGE:
        return Colors.primaries[5];
      case MetricType.CPU_USAGE_IN_PERCETAGE:
        return Colors.primaries[6];
      default:
        return Colors.grey;
    }
  }
}
