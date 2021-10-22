import 'io_service.dart';

class BlkioStats {
  List<IoService> ioServiceBytesRecursive;
  List<IoService> ioServicedRecursive;

  BlkioStats({this.ioServiceBytesRecursive, this.ioServicedRecursive});

  BlkioStats.fromJson(Map<String, dynamic> json) {
    if (json['io_service_bytes_recursive'] != null) {
      ioServiceBytesRecursive = [];
      json['io_service_bytes_recursive'].forEach((v) {
        ioServiceBytesRecursive.add(IoService.fromJson(v));
      });
    }
    if (json['io_serviced_recursive'] != null) {
      ioServicedRecursive = [];
      json['io_serviced_recursive'].forEach((v) {
        ioServicedRecursive.add(IoService.fromJson(v));
      });
    }
  }
}
