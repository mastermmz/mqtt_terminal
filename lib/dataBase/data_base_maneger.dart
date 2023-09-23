import '../../objectbox.g.dart';
import 'data_model.dart';

class ObjectBox{
  late final Store _store;
  late final Box<MqttBrokerData> _mqttBrokerDataBox;

  ObjectBox._init(this._store){
    _mqttBrokerDataBox = Box<MqttBrokerData>(_store);
  }

  static Future<ObjectBox> init() async{
    final store = await openStore();
    return ObjectBox._init(store);
  }

  List<MqttBrokerData> getBrokerList() => _mqttBrokerDataBox.getAll();

  int putBroker(MqttBrokerData mqttBrokerData) => _mqttBrokerDataBox.put(mqttBrokerData);

  bool deletlBroker(MqttBrokerData mqttBrokerData) => _mqttBrokerDataBox.remove(mqttBrokerData.id);

  List<int> putManyBroker (List<MqttBrokerData> deviceList) => _mqttBrokerDataBox.putMany(deviceList);

  int updateBroker(MqttBrokerData mqttBrokerData) => _mqttBrokerDataBox.put(mqttBrokerData,mode: PutMode.update);

  Stream<List<MqttBrokerData>> getBrokerListStream() => _mqttBrokerDataBox.query().watch(triggerImmediately: true).map((query) => query.find());

  int removeAllBroker ()=> _mqttBrokerDataBox.removeAll();

}