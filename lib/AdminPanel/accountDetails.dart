import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:pharma_go/AdminPanel/viewID.dart';

import '../my_flutter_app_icons.dart';

class accountsDetails extends StatefulWidget {
  const accountsDetails({required this.snap, Key? key}) : super(key: key);
  final snap;
  @override
  State<accountsDetails> createState() => _accountsDetailsState();
}

class _accountsDetailsState extends State<accountsDetails> {

  late var ref = FirebaseStorage.instance.ref("userID/${widget.snap.id}").child('userID/');
  late var url = "";

  void initCloud()async{
    url = await ref.getDownloadURL();
    setState((){});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
        initCloud();
    });
    super.initState();
  }


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
            "Account Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
          Text(
            "Name: ${widget.snap["Name"]}",
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            "ID: ${widget.snap["isVerified"] ? "Verified" : "Not Verified"}",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Container(
            width: 150,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black)
            ),
            child: url == "" ?
                const Center(
                  child: Text(
                    "No ID Uploaded"
                  ),
                )
                :
                Stack(
                  children: [
                    Center(
                      child: Image.network(
                          url
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: (){
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: viewID(url: url, id: widget.snap.id),
                            withNavBar: false, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation: PageTransitionAnimation.cupertino,
                          );
                        },
                        child: Text(
                          "View Image"
                        )
                      )
                    )
                  ],
                )
          ),
          Text(
            "Age: ${widget.snap["Age"]}",
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            "Height: ${widget.snap["Height"]}",
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            "Weight: ${widget.snap["Weight"]}",
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            "Address: ${widget.snap["Address"]}",
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            "Mobile: ${widget.snap["Mobile"]}",
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
