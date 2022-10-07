import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class viewDialog extends StatefulWidget {
  const viewDialog({required this.title, required this.time, required this.docID, Key? key}) : super(key: key);
  final String title;
  final String time;
  final String docID;
  
  @override
  State<viewDialog> createState() => _viewDialogState();
}

class _viewDialogState extends State<viewDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
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
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title: ${widget.title}",
                  style: const TextStyle(
                    fontSize: 16
                  ),
                ),
                Text(
                  "Time: ${widget.time}",
                  style: const TextStyle(
                      fontSize: 16
                  ),
                )
              ],
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: (){
                var collection = FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid).collection("Reminders");
                collection.doc(widget.docID).delete().whenComplete((){
                  Navigator.pop(context);
                });
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(150, 40),
                backgroundColor: Colors.redAccent,
              ),
              child: const Text(
                  "Delete Reminder"
              ),
            ),
          )
        ],
      ),
    );
  }
}
