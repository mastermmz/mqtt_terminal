import 'package:objectbox/objectbox.dart';

@Entity()
class MqttBrokerData {
  @Id()
  int id;

  ///for show on app
  String name;
  int iconPath;

  ///for mqtt connection confing
  String clientId;
  String host;
  String hostType;
  int port;
  String username;
  String password;
  int    mqttVersion;
  String keepAlive;
  bool   autoReconnect;
  bool   secure;
  bool   websocket;
  List<String> topic;
  List<String> topicVersion;



  MqttBrokerData({
    this.id = 0,
    required this.name,
    required this.iconPath,
    required this.clientId,
    required this.host,
    required this.hostType,
    required this.port,
    required this.username,
    required this.password,
    required this.mqttVersion,
    required this.keepAlive,
    required this.secure,
    required this.websocket,
    required this.autoReconnect,
    required this.topic,
    required this.topicVersion
  });
}