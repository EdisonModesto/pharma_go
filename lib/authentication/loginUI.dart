import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharma_go/authentication/registerUI.dart';
import 'package:pharma_go/navigaton%20bar/navigation.dart';

import '../Home/homeUI.dart';

class loginUI extends StatefulWidget {
  const loginUI({Key? key}) : super(key: key);

  @override
  State<loginUI> createState() => _loginUIState();
}

class _loginUIState extends State<loginUI> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _numCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();

  Future<void> loginUser() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _numCtrl.text + "@gmail.com",
          password: _passCtrl.text
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "No user found for that number.");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Incorrect Password");
      }
    }
  }

  checkAuth(){
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> navigationBar()));
      }
    });
  }

  @override
  void dispose() {
    _numCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    checkAuth();
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
                      child: Hero(
                        tag: "logo",
                        child: Image.asset(
                          "assets/images/PharmaGo_rounded.png",
                          height: 100,
                          width: 100,
                        ),
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
                           height: 175,
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                             children: [
                               Row(
                                 children: const [
                                   Text(
                                     "Login",
                                     style: TextStyle(
                                       fontSize: 16
                                     ),
                                   ),
                                 ],
                               ),
                               SizedBox(
                                 height: 55,
                                 child: TextFormField(
                                     autovalidateMode: AutovalidateMode.onUserInteraction,

                                     keyboardType: TextInputType.phone,
                                     validator: (value) {
                                       if (value == null || value.isEmpty) {
                                         return '';
                                       } else if(value.length != 11){
                                         return "";
                                       }
                                       return null;
                                       },
                                     controller: _numCtrl,
                                     style: const TextStyle(
                                         fontSize: 14
                                     ),
                                     decoration: const InputDecoration(
                                       errorStyle: TextStyle(height: 0),
                                       label: Text("Mobile Number"),
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
                               SizedBox(
                                    height: 55,
                                    child: TextFormField(
                                      obscureText: true,
                                      controller: _passCtrl,
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '';
                                          }
                                          return null;
                                        },
                                        style: const TextStyle(
                                            fontSize: 14
                                        ),
                                        decoration: const InputDecoration(
                                          label: Text("Password"),
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
                                 loginUser();
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
                               "Login"
                             ),
                           ),
                           TextButton(
                             onPressed: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>const registerUI()));
                             },
                             child: const Text(
                               "Don't have an account? Register"
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
