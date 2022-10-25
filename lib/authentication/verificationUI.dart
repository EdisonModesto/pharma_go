import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharma_go/Home/homeUI.dart';
import 'package:pharma_go/authentication/registerProvider.dart';
import 'package:pharma_go/navigaton%20bar/navigation.dart';
import 'package:provider/provider.dart';

class verifyUI extends StatefulWidget {
  const verifyUI({required this.verificationId, Key? key}) : super(key: key);
  final verificationId;
  @override
  State<verifyUI> createState() => _verifyUIState();
}

class _verifyUIState extends State<verifyUI> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _passCtrl = TextEditingController();


  void createUserDoc(){

    FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).set({
      "Name": context.read<registerProvider>().Name,
      "Mobile": context.read<registerProvider>().Number,
      "Address": context.read<registerProvider>().Address,
      "Age": context.read<registerProvider>().Age,
      "Height": context.read<registerProvider>().Height,
      "Weight": context.read<registerProvider>().Weight,
      "isAdmin": false,
      "isVerified": false,
    });

    DateTime startDate = new DateTime.now().toLocal();

    FirebaseFirestore.instance.collection('Channels').doc(FirebaseAuth.instance.currentUser!.uid).set({
      "Name": context.read<registerProvider>().Name,
      "Mobile": context.read<registerProvider>().Number,
      "Address": context.read<registerProvider>().Address,
      "lastUpdate": startDate
    });
  }

  Future<void> createAcc() async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: context.read<registerProvider>().Number + "@gmail.com",
        password: _passCtrl.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: "Password is weak");
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: "Number already exists!");
      }
    } catch (e) {
      print(e);
    }
  }

  void verifyotp()async{
    FirebaseAuth auth = FirebaseAuth.instance;
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: _passCtrl.text);

    // Sign the user in (or link) with the credential
    await auth.signInWithCredential(credential);

    createUserDoc();
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const navigationBar()));
  }

  @override
  void dispose() {
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    //sendOTP();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 33, right: 33, top: 50, bottom: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(
                      "assets/images/PharmaGo_rounded.png",
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
                SizedBox(
                  height: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Form(
                        key: _formKey,
                        child: SizedBox(
                          height: 115,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: const [
                                  Text(
                                    "Enter OTP",
                                    style: TextStyle(
                                        fontSize: 16
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 55,
                                child: TextFormField(
                                    obscureText: true,
                                    controller: _passCtrl,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.isEmpty || value.length <6) {
                                        return '';
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(
                                        fontSize: 14
                                    ),
                                    decoration: const InputDecoration(
                                      label: Text("OTP"),
                                      errorStyle: TextStyle(height: 0),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        borderSide: BorderSide(
                                          color: Color(0xff219C9C),
                                          width: 2.0,
                                        ),
                                      ),

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                          width: 6.0,
                                        ),
                                      ),

                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: (){
                              if (_formKey.currentState!.validate()) {
                                /*createAcc().whenComplete((){
                                  createUserDoc();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const navigationBar()));
                                });*/
                                verifyotp();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(409, 53),
                                backgroundColor: const Color(0xff219C9C),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(6))
                                )
                            ),
                            child: const Text(
                                "Confirm"
                            ),
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: const Text(
                                "Go Back"
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
