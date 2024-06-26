import 'package:flutter/material.dart';
import 'package:mqtt_terminal/screen/add_broker.dart';
import 'package:mqtt_terminal/screen/home_screen.dart';
import 'dataBase/data_base_maneger.dart';


late ObjectBox mqttBerkers;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  mqttBerkers = await ObjectBox.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.blueGrey,
        scaffoldBackgroundColor: const Color(0xffeeeeee),
        appBarTheme: const AppBarTheme(color: Color(0xffeeeeee))
      ),
      // home: const AddBroker(),
      home: const HomePage(),
    );
  }
}

