
import '../dataBase/data_model.dart';
import '../widget/printer.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';


class MqttBroker{


  late MqttServerClient clientMqtt;
  MqttBrokerData? mqttBrokerData;
  var dataHandler;
  var onConnectFun;
  var onAutoReconnectFun;
  var onAutoReconnectedFun;
  // var onDisconnectedFun;



  Future<void> connestToBroker() async {
    String url = "${mqttBrokerData?.host}";
    printer(url);
    clientMqtt = MqttServerClient(url, mqttBrokerData!.clientId);
    clientMqtt.onConnected = (){onConnectFun();printer("connect");subscribeMessage();};
    // clientMqtt.onDisconnected = (){onDisconnectedFun();printer("Disconnected");};
    clientMqtt.onSubscribed = (vlu){printer("sub: $vlu");};
    clientMqtt.onAutoReconnect = (){onAutoReconnectFun();printer("sub: ");};
    clientMqtt.onAutoReconnected = (){onAutoReconnectedFun();printer("sub: ");};
    clientMqtt.port = mqttBrokerData!.port;
    clientMqtt.secure = mqttBrokerData!.secure;
    clientMqtt.autoReconnect = mqttBrokerData!.autoReconnect;
    clientMqtt.keepAlivePeriod = int.parse(mqttBrokerData!.keepAlive);
    if(mqttBrokerData!.mqttVersion == 0){
      clientMqtt.setProtocolV31();
    }else if(mqttBrokerData!.mqttVersion == 1){
      clientMqtt.setProtocolV311();
    }
    await clientMqtt.connect(mqttBrokerData!.username ,mqttBrokerData!.password);
  }

  void publishMessage({required message , required topic ,required String inputTopicVersion ,required bool retain}){
    MqttQos topicVersion = MqttQos.atMostOnce;
    switch (inputTopicVersion){
      case "QoS 0":
        topicVersion = MqttQos.atMostOnce;
        break;
      case "QoS 1":
        topicVersion = MqttQos.atLeastOnce;
        break;
      case "QoS 2":
        topicVersion = MqttQos.exactlyOnce;
        break;
      default:
        topicVersion = MqttQos.exactlyOnce;
    }
    if(clientMqtt.connectionStatus!.state == MqttConnectionState.connected){
      final builder1 = MqttClientPayloadBuilder();
      builder1.addString(message);
      clientMqtt.publishMessage(topic,  topicVersion, builder1.payload! , retain: retain);
    }
  }

  void unSubscribeMessage() {
    printer("unSubscribeMessage");
    for(int i = 0 ; i != mqttBrokerData?.topic.length ; i++){

      String topic = mqttBrokerData!.topic[i];
      printer("unsub topic:  $topic");
      printer("i:  $i");
      clientMqtt.unsubscribe(topic);
    }
    printer("end");

  }

  void disconnetc(){
    clientMqtt.disconnect();
  }

  void subscribeMessage(){
    if(clientMqtt.connectionStatus!.state == MqttConnectionState.connected){
      for(int i = 0 ; i != mqttBrokerData?.topic.length ; i++){
        String topic = mqttBrokerData!.topic[i];
        MqttQos topicVersion = MqttQos.exactlyOnce;
        switch (mqttBrokerData!.topicVersion[i]){
          case "QoS 0":
            topicVersion = MqttQos.atMostOnce;
            break;
          case "QoS 1":
            topicVersion = MqttQos.atLeastOnce;
            break;
          case "QoS 2":
            topicVersion = MqttQos.exactlyOnce;
            break;
          default:
            topicVersion = MqttQos.exactlyOnce;
        }
        printer("data: ${topicVersion.name}");
        printer("datass: ${mqttBrokerData!.topicVersion[i]}");
        clientMqtt.subscribe(topic, topicVersion);
      }

    // clientMqtt.unsubscribe("/test");
    clientMqtt.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      // final header =
      // MqttPublishPayload.bytesToStringAsString(recMess.payload.variableHeader as Uint8Buffer);
      printer("000000000000");
      // printer(recMess.payload.header);
      // printer(recMess.payload.variableHeader);
      // printer(pt);
      dataHandler(pt , recMess.payload.variableHeader?.topicName ,recMess.payload.variableHeader?.connectFlags.willQos.index);
    });
  }
  }
}
