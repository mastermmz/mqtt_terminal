import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import '../dataBase/data_model.dart';
import '../services/mqtt_connect.dart';
import '../widget/drop_down_model.dart';
import '../widget/subscrib_masseg.dart';
import '../widget/loading.dart';
import '../widget/mqtt_version.dart';
import '../widget/printer.dart';
import '../widget/snakbar.dart';
import '../widget/text_file_widget.dart';

class BrokerMassegManneger extends StatefulWidget {
  const BrokerMassegManneger({super.key, required this.mqttBrokerData});

  final MqttBrokerData mqttBrokerData;

  @override
  State<BrokerMassegManneger> createState() => _BrokerMassegMannegerState();
}

class _BrokerMassegMannegerState extends State<BrokerMassegManneger> {
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _massegController = TextEditingController();
  bool loading = true;
  bool retain = false;
  final ScrollController _scrollController = ScrollController();

  final MqttBroker mqttBroker = MqttBroker();

  List<SubscribMassegClass> subscribMassegList = [];
  String topicsVersion = "QoS 0";

  List<String> topics = [];

  void dataHandler(masseg, String topic, int topicsVersion) {
    SubscribMassegClass subscribMasseg = SubscribMassegClass();
    subscribMasseg.masseg = masseg;
    subscribMasseg.topic = topic;
    subscribMasseg.send = false;
    subscribMasseg.topicsVersion = topicsVersion;
    printer(topicsVersion);
    subscribMassegList.add(subscribMasseg);
    setState(() {});
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 1),
          curve: Curves.fastOutSlowIn);
    });
  }

  void mqttConfing() {
    printer(widget.mqttBrokerData.topic);
    mqttBroker.mqttBrokerData = widget.mqttBrokerData;
    mqttBroker.dataHandler = dataHandler;
    mqttBroker.onConnectFun = () {
      loading = false;
      printer("ssss");
      snakbarShowModel(
        context: context,
        msg: "Connect",
      );
      setState(() {});
    };
    mqttBroker.onAutoReconnectedFun = () {
      loading = true;
      printer("ssss");
      snakbarShowModel(
        context: context,
        msg: "Connect",
      );
      setState(() {});
    };
    // mqttBroker.onAutoReconnectFun = () {
    //   loading = true;
    //   printer("ssss");
    //   snakbarShowModel(
    //       context: context,
    //       msg: "Auto Reconnect",
    //       snakbarType: AnimatedSnackBarType.warning);
    //   setState(() {});
    // };
    // mqttBroker.onDisconnectedFun = (){loading = true;printer("ssss");snakbarShowModel(context: context , msg: "Disconnected" ,snakbarType: AnimatedSnackBarType.error );setState(() {});};
    mqttBroker.connestToBroker();
  }

  @override
  void initState() {
    mqttConfing();
    super.initState();
  }

  @override
  void dispose() {
    mqttBroker.unSubscribeMessage();
    mqttBroker.disconnetc();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Color(0xff848484),
          title: Text(
            widget.mqttBrokerData.name,
          ),
          centerTitle: true,
        ),
        body: _buildBoody(),
      ),
    );
  }

  Widget _buildBoody() {
    if (loading) {
      return const LoadingWidget();
    }
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.end,
      // mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(
          height: 20.0,
        ),
        Expanded(
          child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: subscribMassegList.length,
              itemBuilder: (BuildContext context, int index) {
                SubscribMassegClass subscribMassegData =
                    subscribMassegList[index];
                printer(subscribMassegData);
                return GestureDetector(
                    onLongPress: () async {
                      await Clipboard.setData(ClipboardData(
                          text:
                              "${subscribMassegData.topic!} : \n${subscribMassegData.masseg!}"));
                      setState(() {});
                    },
                    child: subscribMasseg(subscribMassegData, context));
              },),
        ),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: textFildWidget(
                inputPaddingR: 8,

                labelText: "topic to send masseg:",
                textFildStyleWidget: Theme.of(context).textTheme.bodyLarge,
                controller: _topicController,
              ),
            ),

            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(right: 10.0),
                child: dropDownmodel(
                    // width: 70,
                    // fontSize: 8,
                    libelText: "MQTT Topic Version:",
                    items: mqttTopicVersionList,
                    onChengFun: (String? value) {
                      setState(() {
                        topicsVersion = value!;
                      });
                    },
                    selectedValues: topicsVersion),
              ),
            ),
            const Text("retain:"),
            Checkbox(
              checkColor: Colors.white,
              value: retain,
              onChanged: (bool? value) {
                setState(() {
                  retain = value!;
                });
              },
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: textFildWidget(
                labelText: "masseg: ",
                textFildStyleWidget: Theme.of(context).textTheme.bodyLarge,
                controller: _massegController,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                onTap: () {
                  if (_topicController.text != "" &&
                      _massegController.text != "") {
                    int topicVersion = 0;
                    switch (topicsVersion) {
                      case "QoS 0":
                        topicVersion = 0;
                        break;
                      case "QoS 1":
                        topicVersion = 1;
                        break;
                      case "QoS 2":
                        topicVersion = 2;
                        break;
                      default:
                        topicVersion = 2;
                    }
                    printer("s");
                    SubscribMassegClass subscribMasseg = SubscribMassegClass();
                    subscribMasseg.masseg = _massegController.text;
                    subscribMasseg.topic = _topicController.text;
                    subscribMasseg.send = true;
                    subscribMasseg.topicsVersion = topicVersion;

                    subscribMassegList.add(subscribMasseg);
                    mqttBroker.publishMessage(
                        message: _massegController.text,
                        topic: _topicController.text,
                        inputTopicVersion: topicsVersion,
                        retain: retain);
                    _massegController.text = "";
                    setState(() {});
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 1),
                          curve: Curves.fastOutSlowIn);
                    });
                  }
                },
                child: const CircleAvatar(
                  backgroundColor: Color(0xff0177FC),
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
