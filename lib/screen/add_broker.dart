import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:mqtt_terminal/dataBase/data_model.dart';
import 'package:random_string/random_string.dart';
import '../main.dart';
import '../widget/drop_down_model.dart';
import '../widget/button_model.dart';
import '../widget/icon_path.dart';
import '../widget/mqtt_version.dart';
import '../widget/text_file_widget.dart';

class AddBroker extends StatefulWidget {
  const AddBroker({super.key});

  @override
  State<AddBroker> createState() => _AddBrokerState();
}

class _AddBrokerState extends State<AddBroker> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _clientIdController = TextEditingController();
  final TextEditingController _hostController = TextEditingController();
  final TextEditingController _portController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _keepAliveController = TextEditingController();
  final TextEditingController _topicController = TextEditingController();

  List<String> topics = ["#"];
  List<String> topicsVersionList = ["QoS 0"];
  var iconPath = Icons.home;
  int iconIndex = 0;
  List<String> hostTypeList = ["mqtts://" , "mqtt://" , "ws://" , "wss://"];
  String? hostTypeSelected;
  List<String> mqttVersionList = ["3.1" , "3.1.1" , "5"];
  String? mqttVersionSelected;
  bool sslvalue = false;
  bool autoReconnect = false;
  bool websocket = false;



  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text('AlertDialog Title'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * .7,
            child: GridView.count(
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(iconsPathModel.length, (index) {
                return IconButton(
                  onPressed: (){
                    setState(() {
                      iconPath = iconsPathModel[index];
                      iconIndex = index;
                    });
                    Navigator.of(context).pop();
                  },
                  icon: Icon(iconsPathModel[index] , size: 35.0),
                );
              }),
            ),
          ),
          // content: Text("salam"),
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

  void saveButton(){
    int mqttVersion = 0;
    switch (mqttVersionSelected){
      case "3.1":
        mqttVersion = 0;
        break;
      case "3.1.1":
        mqttVersion = 1;
        break;
      default:
        mqttVersion = 2;
    }

    MqttBrokerData mqttBrokerDataTemp = MqttBrokerData(
        name: _nameController.text,
        iconPath: iconIndex,
        clientId: _clientIdController.text,
        host: _hostController.text,
        hostType: hostTypeSelected!,
        port: int.parse(_portController.text),
        username: _usernameController.text,
        password: _passwordController.text,
        mqttVersion: mqttVersion,
        keepAlive: _keepAliveController.text,
        autoReconnect: autoReconnect,
        secure: sslvalue,
        websocket: websocket,
        topicVersion: topicsVersionList,
        topic: topics);
    mqttBerkers.putBroker(mqttBrokerDataTemp);
    Navigator.pop(context);
  }

  @override
  void initState() {
    _clientIdController.text = randomString(10 , from: 97 , to: 122);
    _hostController.text = "broker.emqx.io";
    hostTypeSelected = hostTypeList[2];
    mqttVersionSelected = mqttVersionList[2];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("add new broker"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: _showMyDialog,
                      child: Container(
                          margin: const EdgeInsets.only(left: 15.0),
                          child: Icon(iconPath)),
                    ),
                    Expanded(
                      child:textFildWidget(
                      labelText: "Name:",
                      textFildStyleWidget: Theme.of(context).textTheme.bodyLarge,
                      controller: _nameController,
                    ),)
                  ],
                ),
                textFildWidget(
                  labelText: "client Id:",
                  textFildStyleWidget: Theme.of(context).textTheme.bodyLarge,
                  controller: _clientIdController,
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 15.0),
                      child: dropDownmodel(
                        width: 85,
                          libelText: "Host Type:",
                          items: hostTypeList,
                          onChengFun: (String? value){
                            if(value == "https://" || value == "wss://"){
                              sslvalue = true;
                            }else{
                              sslvalue = false;
                            }
                            setState(() {
                              hostTypeSelected = value;
                            });
                          },
                          selectedValues: hostTypeSelected
                      ),
                    ),
                    Expanded(
                      child: textFildWidget(
                        // labelText: "Host Addres:",
                        textFildStyleWidget: Theme.of(context).textTheme.bodyLarge,
                        controller: _hostController,
                        inputMargin: 0.0,
                        inputPaddingR: 15.0,
                        inputPaddingL: 5.0,
                      ),
                    ),
                  ],
                ),
                textFildWidget(
                  textInputType: TextInputType.number,
                  labelText: "Port: ",
                  textFildStyleWidget: Theme.of(context).textTheme.bodyLarge,
                  controller: _portController,
                ),
                textFildWidget(
                  labelText: "Username: ",
                  textFildStyleWidget: Theme.of(context).textTheme.bodyLarge,
                  controller: _usernameController,
                ),
                textFildWidget(
                  showPassword: true,
                  labelText: "Password: ",
                  textFildStyleWidget: Theme.of(context).textTheme.bodyLarge,
                  controller: _passwordController,
                ),
                ExpansionTile(
                  // backgroundColor: Color(0xffdfdfdf),
                  title: const Text("advanced"),
                  children: [
                    textFildWidget(
                      textInputType: TextInputType.number,
                      labelText: "keep Alive: ",
                      textFildStyleWidget: Theme.of(context).textTheme.bodyLarge,
                      controller: _keepAliveController,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 15.0),
                            child: const Text("SSL/TLS: " , style: TextStyle(fontWeight: FontWeight.w700))),
                        Switch(
                          // ["https://" , "http://" , "ws://" , "wss://"];
                          value: sslvalue,
                          activeColor: Colors.red,
                          onChanged: (bool value) {
                            if(value == true){
                              if(hostTypeSelected == "http://"){
                                hostTypeSelected = hostTypeList[0];
                              }
                              if(hostTypeSelected == "ws://"){
                                hostTypeSelected = hostTypeList[3];
                              }
                            }
                            if(value == false){
                              if(hostTypeSelected == "https://"){
                                hostTypeSelected = hostTypeList[1];
                              }
                              if(hostTypeSelected == "wss://"){
                                hostTypeSelected = hostTypeList[2];
                              }
                            }
                            setState(() {
                              sslvalue = value;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 15.0),
                            child: const Text("websocket: " , style: TextStyle(fontWeight: FontWeight.w700))),
                        Switch(
                          // ["https://" , "http://" , "ws://" , "wss://"];
                          value: websocket,
                          activeColor: Colors.red,
                          onChanged: (bool value) {
                            setState(() {
                              websocket = value;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 15.0),
                            child: const Text("MQTT Version:" , style: TextStyle(fontWeight: FontWeight.w700))),
                        Container(
                          margin: const EdgeInsets.only(left: 5.0),
                          child: dropDownmodel(
                              libelText: "MQTT Version:",
                              items: mqttVersionList,
                              onChengFun: (String? value){
                                setState(() {
                                  mqttVersionSelected = value;
                                });
                              },
                              selectedValues: mqttVersionSelected
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 15.0),
                            child: const Text("Auto Reconnect:" , style: TextStyle(fontWeight: FontWeight.w700))),
                        Switch(
                          // This bool value toggles the switch.
                          value: autoReconnect,
                          activeColor: Colors.green,
                          onChanged: (bool value) {
                            // This is called when the user toggles the switch.
                            setState(() {
                              autoReconnect = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text("Subscribe topic"),
                  children: [
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: topics.length,
                        itemBuilder:(BuildContext context, int index){
                          String topicsVersion =  topicsVersionList[index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${index + 1}: " , style: const TextStyle(fontSize: 20.0),textAlign: TextAlign.center,),
                              Text(topics[index] , style: const TextStyle(fontSize: 20.0),textAlign: TextAlign.center,),
                              Container(
                                margin: const EdgeInsets.only(left: 10.0),
                                child: dropDownmodel(
                                  width: 80,
                                  libelText: "MQTT Topic Version:",
                                  items: mqttTopicVersionList,
                                  onChengFun: (String? value){
                                    setState(() {
                                      topicsVersion = value!;
                                      topicsVersionList[index] = value;
                                    });
                                  },
                                  selectedValues: topicsVersion
                                ),
                              ),
                              IconButton(onPressed: (){topics.removeAt(index);setState(() {});}, icon: const Icon(Boxicons.bxs_trash_alt ,color: Colors.red,))
                            ],
                          );
                        }
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: textFildWidget(
                            labelText: "topic: ",
                            textFildStyleWidget: Theme.of(context).textTheme.bodyLarge,
                            controller: _topicController,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: GestureDetector(
                            onTap: (){
                              topics.add(_topicController.text);
                              topicsVersionList.add(mqttTopicVersionList[0]);
                              _topicController.text = "";
                              setState(() {

                              });
                            },
                            child: const CircleAvatar(
                              backgroundColor: Color(0xff0177FC),
                              child: Icon(Icons.add , color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  
                ),

                const SizedBox(
                  height: 15.0,
                ),
                buttonWidget(
                  labelText: "ذخیره",
                  buttonFunction: saveButton
                ),
              ],
            ),
          ),

      )
    );
  }
}
