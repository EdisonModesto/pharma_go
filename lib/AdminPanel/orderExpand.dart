import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:random_string/random_string.dart';

import '../my_flutter_app_icons.dart';

class orderExpand extends StatefulWidget {
  const orderExpand({required this.snap, required this.snap1, Key? key}) : super(key: key);

  final snap, snap1;
  @override
  State<orderExpand> createState() => _orderExpandState();
}

class _orderExpandState extends State<orderExpand> {

  late var order = FirebaseFirestore.instance.collection('Orders').doc(widget.snap).collection("items");

  @override
  void initState() {
    //order = FirebaseFirestore.instance.collection('Orders').doc(widget.snap).collection("items");
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.snap1["Buyer"]} Order",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Expanded(
            child:
          StreamBuilder(
            stream: order.snapshots(),
            builder: (context,snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingIndicator(size: 40, borderWidth: 2);
              }

              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index){
                  return ListTile(
                    dense: true,
                    title: Text(
                        "${snapshot.data!.docs[index]["itemName"]}"
                    ),
                    trailing: Text(
                        "${snapshot.data!.docs[index]["itemPrice"]}"
                    ),
                  );
                },
              );
            }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Status: ${widget.snap1["Status"]}",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                "Total: ${widget.snap1["Total"]}",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),

          widget.snap1["Status"] == "For Pickup" ?
          ElevatedButton(
            onPressed: (){
              
              
              CollectionReference orderDets = FirebaseFirestore.instance.collection('Orders');
              
              orderDets.doc(widget.snap).collection("items").get().then((snapshot) {
                for (DocumentSnapshot ds in snapshot.docs){
                  ds.reference.delete();
                }
              });

              orderDets.doc(widget.snap).delete();

              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(409, 53),
                backgroundColor: const Color(0xff219C9C),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6))
                )
            ),
            child: Text(
                "Mark As Done (${widget.snap1["RefID"]})"
            ),
          )
          :
          ElevatedButton(
            onPressed: (){
              var orderDets = FirebaseFirestore.instance.collection('Orders').doc(widget.snap);
              var refStr = randomAlphaNumeric(10).toString();
              orderDets.update({
                "Status": "For Pickup",
                "RefID": refStr,
                "Total" : widget.snap1["Total"],
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(409, 53),
                backgroundColor: const Color(0xff219C9C),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6))
                )
            ),
            child: const Text(
                "Confirm Payment"
            ),
          ),
        ],
      ),
    );
  }
}
