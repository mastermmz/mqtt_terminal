import 'package:flutter/material.dart';

import '../dataBase/data_model.dart';
import '../main.dart';
import '../widget/brokerList_button_model.dart';
import '../widget/printer.dart';
import 'add_broker.dart';
import 'broker_masseg_chat.dart';
import 'edit_broker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<MqttBrokerData> mqttBroker;
  late Stream<List<MqttBrokerData>> streaDeviceList;

  @override
  void initState() {
    streaDeviceList = mqttBerkers.getBrokerListStream();
    super.initState();
  }

  Future<void> deleteBroker(
      {required context, required MqttBrokerData mqttBrokerData}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(mqttBrokerData.name),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Are you sure about removing the broker?"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ok'),
              onPressed: () {
                mqttBerkers.deletlBroker(mqttBrokerData);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> longpressFun(
      {required context, required MqttBrokerData mqttBrokerData}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(mqttBrokerData.name),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black87,
                    backgroundColor: const Color(0x90f2f4f6),
                    minimumSize: const Size(88, 36),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    ),
                  ),
                  onPressed: () {
                    // objectbox.deletlDevice(device);
                    Navigator.of(context).pop();
                    deleteBroker(
                        context: context, mqttBrokerData: mqttBrokerData);
                  },
                  child: const Text("delete Broker"),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black87,
                    backgroundColor: const Color(0x90f2f4f6),
                    minimumSize: const Size(88, 36),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return EditBroker(
                        mqttBrokerData: mqttBrokerData,
                      );
                    }));
                  },
                  child: const Text("edit broker"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("MQTT Client"),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const AddBroker();
                    }));
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
          body: StreamBuilder<List<MqttBrokerData>>(
            stream: streaDeviceList,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                mqttBroker = snapshot.data!;
              }
              printer("snapshot: ${snapshot.runtimeType}");
              printer("snapshot.data: ${snapshot.data?.length}");

              return GridView.count(
                padding: const EdgeInsets.all(20.0),
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(mqttBroker.length, (index) {
                  MqttBrokerData mqttBrokerData = mqttBroker[index];
                  return brokerButtonList(
                      iconPath: mqttBrokerData.iconPath,
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return BrokerMassegManneger(
                            mqttBrokerData: mqttBrokerData,
                          );
                        }));
                      },
                      onLongPress: () {
                        longpressFun(
                            context: context, mqttBrokerData: mqttBrokerData);
                      },
                      host: "${mqttBrokerData.hostType}${mqttBrokerData.host}",
                      name: mqttBrokerData.name,
                      port: mqttBrokerData.port,
                      username: mqttBrokerData.username);
                }),
              );
            },
          )),
    );
  }
}

///brokerButtonList(
//                     onTap: (){
//                       Navigator.push(context, MaterialPageRoute(builder: (context){
//                         return BrokerMassegManneger(mqttBrokerData: mqttBrokerData,);
//                       }));
//                     },
//                     onLongPress: (){
//                       longpressFun(context: context , mqttBrokerData: mqttBrokerData);
//                     },
//                     host: "${mqttBrokerData.hostType}${mqttBrokerData.host}",
//                     name: mqttBrokerData.name,
//                     port: mqttBrokerData.port,
//                     username: mqttBrokerData.username
//                   );
