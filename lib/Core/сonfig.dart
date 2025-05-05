class Config {
  static const String ip = '192.168.1.198';
  static const String port = '8080';

  static const String baseUrl = 'http://${ip}:${port}';
  static const String wsUrl = 'ws://$ip:$port/ws';
}
