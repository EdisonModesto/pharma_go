//import 'package:camera/camera.dart';
import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pharma_go/Home/homeUI.dart';
import 'package:pharma_go/MedScan/medScanProvider.dart';
import 'package:pharma_go/authentication/registerProvider.dart';
import 'package:pharma_go/authentication/registerUI.dart';
import 'package:pharma_go/navigaton%20bar/navigation.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'authentication/loginUI.dart';
import 'firebase_options.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            playSound: true,
            importance: NotificationImportance.High,
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> registerProvider()),
        ChangeNotifierProvider(create: (_)=> medScanProvider()),
      ],
        child: const  MyApp()),
    );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PharmaGo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        fontFamily: "Poppins"
      ),
      home: const MyHomePage(title: 'PharmaGo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  void endSplash()async{
    await Future.delayed(Duration(seconds: 3));
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const registerUI()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> navigationBar()));

      }
    });
  }

  getUserInfo() async {
    if(FirebaseAuth.instance.currentUser != null) {
      var collection = FirebaseFirestore.instance.collection('Users').doc(
          FirebaseAuth.instance.currentUser?.uid);
      var docSnapshot = await collection.get();
      Map<String, dynamic>? data = docSnapshot.data();

      print(data);
      context.read<registerProvider>().addDetails(
          data!["Mobile"], data["Name"], data["Address"], data["Age"],
          data["Weight"], data["Height"], data["FBM"]);
    }
  }

  void getJSon() async {
     final response = await http.get(Uri.parse('https://api.npoint.io/e63a328b19e2921d7e97'));
     var body = jsonDecode(response.body);
     print(body);
  }

  @override
  void initState() {
    context.read<medScanProvider>().setCameras(_cameras);
    getUserInfo();
    endSplash();
    getJSon();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Hero(
            tag: "logo",
            child: Image.asset(
              "assets/images/PharmaGo.png"
            ),
          ),
        ),
      )
    );
  }
}
