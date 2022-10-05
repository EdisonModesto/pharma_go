import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pharma_go/Home/homeUI.dart';
import 'package:pharma_go/authentication/registerProvider.dart';
import 'package:pharma_go/navigaton%20bar/navigation.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> registerProvider()),
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
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context)=> navigationBar()));
  }



  @override
  void initState() {
    endSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset(
            "assets/images/PharmaGo.png"
          ),
        ),
      )
    );
  }
}
