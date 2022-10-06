import 'package:flutter/material.dart';
import 'package:pharma_go/authentication/registerProvider.dart';
import 'package:pharma_go/authentication/verificationUI.dart';
import 'package:provider/provider.dart';

class registerUI extends StatefulWidget {
  const registerUI({Key? key}) : super(key: key);

  @override
  State<registerUI> createState() => _registerUIState();
}

class _registerUIState extends State<registerUI> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _numCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _height = TextEditingController();
  final TextEditingController _weight = TextEditingController();

  @override
  void dispose() {
    _numCtrl.dispose();
    _nameCtrl.dispose();
    _addressCtrl.dispose();
    _age.dispose();
    _height.dispose();
    _weight.dispose();
    super.dispose();
  }

  void setProvider(){
    context.read<registerProvider>().addDetails(_numCtrl.text, _nameCtrl.text, _addressCtrl.text, _age.text, _height.text, _weight.text);
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
                  height: 450,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Form(
                        key: _formKey,
                        child: SizedBox(
                          height: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: const [
                                  Text(
                                    "Register",
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
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '';
                                      }
                                      return null;
                                    },
                                    controller: _nameCtrl,
                                    style: const TextStyle(
                                        fontSize: 14
                                    ),
                                    decoration: const InputDecoration(
                                      errorStyle: TextStyle(height: 0),
                                      label: Text("Name"),
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
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '';
                                      }
                                      return null;
                                    },
                                    controller: _addressCtrl,
                                    style: const TextStyle(
                                        fontSize: 14
                                    ),
                                    decoration: const InputDecoration(
                                      errorStyle: TextStyle(height: 0),
                                      label: Text("Adress"),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 45,
                                    width: 90,
                                    child: TextFormField(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        keyboardType: TextInputType.phone,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '';
                                          }
                                          return null;
                                        },
                                        style: const TextStyle(
                                            fontSize: 14
                                        ),
                                        controller: _age,

                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                          errorStyle: TextStyle(height: 0),
                                          label: Center(child: Text("Age")),
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
                                    height: 45,
                                    width: 90,
                                    child: TextFormField(
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
                                        controller: _height,

                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                          errorStyle: TextStyle(height: 0),
                                          label: Center(child: Text("Height")),
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
                                    height: 45,
                                    width: 90,
                                    child: TextFormField(
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
                                        controller: _weight,

                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                          errorStyle: TextStyle(height: 0),
                                          label: Center(child: Text("Weight")),
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
                              )
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: (){
                              if (_formKey.currentState!.validate()) {
                                setProvider();
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const verifyUI()));
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
                                "Continue"
                            ),
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: const Text(
                                "Already have an account? Login"
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
