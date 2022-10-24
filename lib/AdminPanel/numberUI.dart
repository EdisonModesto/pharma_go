import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";

class numberUI extends StatefulWidget {
  const numberUI({Key? key}) : super(key: key);

  @override
  State<numberUI> createState() => _numberUIState();
}

class _numberUIState extends State<numberUI> {

  TextEditingController numberCtrl = TextEditingController();
  double H = 250;
  var shopData = FirebaseFirestore.instance.collection("shopData").doc("data");

  getGcash()async{
    var snap = await shopData.get();
    setState(() {
      numberCtrl.text = snap["gcash"];
    });
  }

  @override
  void initState() {
    getGcash();
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: H,
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Shop Number",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              TextButton(
                onPressed: (){
                  shopData.update({
                    "gcash": numberCtrl.text
                  }).whenComplete(() => Navigator.pop(context));
                }, child: Text("Save"),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact
                ),
              )
            ],
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                onTap: (){
                  setState(() {
                    H = 400;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 11 || value.length > 11) {
                    return '';
                  }
                  return null;
                },
                style: const TextStyle(
                    fontSize: 14
                ),
                controller: numberCtrl,
                decoration: const InputDecoration(
                  errorStyle: TextStyle(height: 0),
                  label: Text("GCash Number"),
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
          const Text(
            "This is the number that users will see and send their payments. Make sure to keep this up to date and free from any mistakes",
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
