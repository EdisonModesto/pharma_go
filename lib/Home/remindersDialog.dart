import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../notification/Notify.dart';

class reminderDialog extends StatefulWidget {
  const reminderDialog({Key? key}) : super(key: key);

  @override
  State<reminderDialog> createState() => _reminderDialogState();
}

class _reminderDialogState extends State<reminderDialog> {
  final _formKey = GlobalKey<FormState>();
  TimeOfDay _time = TimeOfDay.now().replacing(hour: 11, minute: 30);

  TextEditingController titleCtrl = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Add reminder",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 100,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: TextFormField(
                      controller: titleCtrl,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          errorStyle: TextStyle(height: 0),
                          label: Text("Title"),
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
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).push(
                        showPicker(
                          context: context,
                          value: _time,
                          onChange: (value){
                            setState(() {
                              _time = value;
                            });
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(150, 50)
                    ),
                    child: Row(
                      children: const [
                        Text(
                          "Choose Time"
                        ),
                      ],
                    ),
                  )
                ]
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: (){
                if (_formKey.currentState!.validate()) {
                  print(FirebaseAuth.instance.currentUser?.uid);
                  var collection = FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid).collection("Reminders").doc();
                  collection.set({
                    "Title": titleCtrl.text,
                    "Time": "${_time.hour}: ${_time.minute}"
                  }).whenComplete((){
                    Notify.instantNotify(titleCtrl.text, "New Notification", _time);
                    Navigator.pop(context);
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(150, 50),
                backgroundColor: Color(0xff219C9C),
              ),
              child: const Text(
                  "Add Reminder"
              ),
            ),
          )
        ],
      ),
    );
  }
}
