class Eth0 {
  int rxBytes;
  int rxPackets;
  int rxErrors;
  int rxDropped;
  int txBytes;
  int txPackets;
  int txErrors;
  int txDropped;

  Eth0({this.rxBytes, this.rxPackets, this.rxErrors, this.rxDropped, this.txBytes, this.txPackets, this.txErrors, this.txDropped});

  Eth0.fromJson(Map<String, dynamic> json) {
    rxBytes = json['rx_bytes'];
    rxPackets = json['rx_packets'];
    rxErrors = json['rx_errors'];
    rxDropped = json['rx_dropped'];
    txBytes = json['tx_bytes'];
    txPackets = json['tx_packets'];
    txErrors = json['tx_errors'];
    txDropped = json['tx_dropped'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rx_bytes'] = this.rxBytes;
    data['rx_packets'] = this.rxPackets;
    data['rx_errors'] = this.rxErrors;
    data['rx_dropped'] = this.rxDropped;
    data['tx_bytes'] = this.txBytes;
    data['tx_packets'] = this.txPackets;
    data['tx_errors'] = this.txErrors;
    data['tx_dropped'] = this.txDropped;
    return data;
  }
}
