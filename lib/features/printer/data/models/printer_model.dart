class PrinterModel {
  final String name;
  final String ip;
  final int port;
  final String location;

  PrinterModel({
    required this.name,
    required this.ip,
    required this.port,
    required this.location,
  });

  factory PrinterModel.fromJson(Map<String, dynamic> json) {
    return PrinterModel(
      name: json['name'] as String,
      ip: json['ip'] as String,
      port: json['port'] as int,
      location: json['location'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'ip': ip, 'port': port, 'location': location};
  }
}
