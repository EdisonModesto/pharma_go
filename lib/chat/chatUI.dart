
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ntp/ntp.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import '../AdminPanel/viewReseta.dart';
import '../Home/viewDialog.dart';
import '../authentication/registerProvider.dart';
import '../my_flutter_app_icons.dart';

class chatUI extends StatefulWidget {
  const chatUI({required this.channelID, required this.Name, Key? key}) : super(key: key);

  final String channelID;
  final String Name;

  @override
  State<chatUI> createState() => _chatUIState();
}

class _chatUIState extends State<chatUI> {

  CollectionReference messages = FirebaseFirestore.instance.collection('Channels');

  TextEditingController msgCtrl = TextEditingController();
  ScrollController _scrollController = ScrollController();



  var storage = FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = path.basename(_photo!.path);
    final destination = 'userReseta/${FirebaseAuth.instance.currentUser!.uid}';

    try {
      final ref = FirebaseStorage.instance.ref(destination).child('userReseta/');
      await ref.putFile(_photo!);
      Fluttertoast.showToast(msg: "Your reseta has been uploaded!");
    } catch (e) {
      print('error occured');
    }
  }

  Future<String> imgFromGalleryMsg() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);


      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        return await uploadFileMsg();
      } else {
        print('No image selected.');
      }

    return "";
  }

  Future<String> imgFromGalleryMsg2() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);


    if (pickedFile != null) {
      _photo = File(pickedFile.path);
      return await uploadFileMsg();
    } else {
      print('No image selected.');
    }

    return "";
  }


  Future<String> uploadFileMsg() async {
    if (_photo == null) return "";
    final fileName = path.basename(_photo!.path);
    final destination = 'MSG/';

    try {
      final ref = FirebaseStorage.instance.ref(destination).child('${fileName}/');
      await ref.putFile(_photo!);
      var urlImg = await ref.getDownloadURL();
      print(urlImg);
      return urlImg;
    } catch (e) {
      print('error occured');
    }
    return "";
  }

  late var ref = FirebaseStorage.instance.ref("userReseta/${widget.channelID}").child('userReseta/');
  late var url = "";

  void initCloud()async{
    url = await ref.getDownloadURL();
    setState((){});
  }

  @override
  void dispose() {
    super.dispose();
    msgCtrl.dispose();
  }

  void checkAutoMsg()async{
    var docu = FirebaseFirestore.instance.collection("Channels").doc(widget.channelID);
    DateTime startDate = new DateTime.now().toLocal();
    var snap = await docu.get();
    int offset = await NTP.getNtpOffset(localTime: startDate);
    startDate.add(Duration(milliseconds: offset));


    var diff = startDate.difference(snap["lastUpdate"].toDate()).inMinutes;
    print(startDate.difference(snap["lastUpdate"].toDate()).inMinutes);
    
    if(diff > 15){
      print("AUTOREPLY SENT");
      messages.add({
        "message": "Hello! Thanks for visiting PharmaGo, we will be with you in just a moment.",
        "user": "AutoReplyBot",
        "time": startDate.add(Duration(milliseconds: offset))
      });
      var snap = FirebaseFirestore.instance.collection("Channels").doc(widget.channelID).update({
        "lastUpdate": startDate.add(Duration(milliseconds: offset)),
      });
    }
  }

  void jump(){
    if (_scrollController.hasClients) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.elasticOut);
    } else {
      Timer(Duration(milliseconds: 400), () => jump());
    }
  }
  
  @override
  void initState() {
    super.initState();
    messages = messages.doc(widget.channelID).collection("Messages");
    initCloud();
    checkAutoMsg();




  }

  void viewImg(url1){
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Image.network(url1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Stack(
            children: [
                SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 9,
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 250,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  margin: const EdgeInsets.only(right: 15),
                                  decoration: const BoxDecoration(
                                    color: Color(0xff219C9C),
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                  ),
                                  child: const Icon(
                                      Icons.person,
                                      color: Color(0xffD9DEDC)
                                  ),
                                ),
                                Text(
                                  widget.Name == context.watch<registerProvider>().Name ? "PharmaGo" : widget.Name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff424242),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          widget.Name == context.watch<registerProvider>().Name ?
                          SizedBox(
                            child: IconButton(
                              onPressed: (){
                                imgFromGallery();
                              },
                              icon:Icon(Icons.upload) ,
                            ),
                          )
                          :
                          SizedBox(
                            child: IconButton(
                              onPressed: (){
                                if(url.isNotEmpty){
                                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>viewReseta(url: url, id: widget.channelID)));
                                }else{
                                  Fluttertoast.showToast(msg: "User has no uploaded reseta");
                                }

                              },
                              icon:Icon(Icons.receipt) ,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: StreamBuilder(
                            stream: messages.orderBy("time").snapshots(),
                            builder: (context,snapshot){
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }

                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const LoadingIndicator(size: 40, borderWidth: 2);
                              }

                              return ListView.builder(
                                controller: _scrollController,
                                itemCount: snapshot.data!.docs.length,
                                shrinkWrap: true ,
                                itemBuilder: (context,index){

                                  var RawMessage = snapshot.data?.docs[index]["message"];
                                  var parsedMessage = RawMessage.split("|");
                                  print(parsedMessage);
                                  WidgetsBinding.instance.addPostFrameCallback((_){
                                    if(_scrollController.hasClients){
                                      jump();
                                    }
                                  });


                                  return snapshot.data?.docs[index]["user"] == FirebaseAuth.instance.currentUser?.uid ?
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Flexible(
                                        child: parsedMessage[0] == "image" ?
                                        Container(
                                          height: 250,
                                          width: 175,
                                          decoration: const BoxDecoration(
                                              color: Color(0xff219C9C),
                                              borderRadius: BorderRadius.all(Radius.circular(15))
                                          ),
                                          margin: const EdgeInsets.only(bottom: 10, left: 30),
                                          padding: const EdgeInsets.only(left: 15, right: 15,top: 10, bottom: 10),
                                          child: InkWell(
                                            onTap: (){
                                              viewImg(parsedMessage[1]);
                                            },
                                            child: Image.network(
                                              parsedMessage[1],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                        :
                                        Container(
                                          decoration: const BoxDecoration(
                                              color: Color(0xff219C9C),
                                              borderRadius: BorderRadius.all(Radius.circular(15))
                                          ),
                                          margin: const EdgeInsets.only(bottom: 10, left: 30),
                                          padding: const EdgeInsets.only(left: 15, right: 15,top: 10, bottom: 10),
                                          child: Text(
                                            parsedMessage[1],
                                            softWrap: true,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                  :
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: parsedMessage[0] == "image" ?
                                        Container(
                                          height: 250,
                                          width: 175,
                                          decoration: const BoxDecoration(
                                              color: Color(0xffD9DEDC),
                                              borderRadius: BorderRadius.all(Radius.circular(15))
                                          ),
                                          margin: const EdgeInsets.only(bottom: 10, right: 30),
                                          padding: const EdgeInsets.only(left: 15, right: 15,top: 10, bottom: 10),
                                          child: InkWell(
                                            onTap: (){
                                              viewImg(parsedMessage[1]);
                                            },
                                            child: Image.network(
                                              parsedMessage[1],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ) :
                                        Container(
                                          decoration: const BoxDecoration(
                                              color: Color(0xffD9DEDC),
                                              borderRadius: BorderRadius.all(Radius.circular(15))
                                          ),
                                          margin: const EdgeInsets.only(bottom: 10, right: 30),
                                          padding: const EdgeInsets.only(left: 15, right: 15,top: 10, bottom: 10),
                                          child: Text(
                                            parsedMessage[1],
                                            softWrap: true,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );


                                },
                              );
                            }),
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      decoration: const BoxDecoration(
                          color: Color(0xffD9DEDC),
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextField(
                              controller: msgCtrl,
                              decoration: const InputDecoration(
                                hintText: "Message",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              try{
                                DateTime startDate = new DateTime.now().toLocal();
                                int offset = await NTP.getNtpOffset(localTime: startDate);
                                var img = await imgFromGalleryMsg2();
                                if(img != "" && img != null){
                                  messages.add({
                                    "message": "image|${img}",
                                    "user": FirebaseAuth.instance.currentUser?.uid,
                                    "time": startDate.add(Duration(milliseconds: offset))
                                  });
                                  var snap = FirebaseFirestore.instance.collection("Channels").doc(widget.channelID).update({
                                    "lastUpdate": startDate.add(Duration(milliseconds: offset)),
                                  });
                                  msgCtrl.text = "";
                                  await Future.delayed(Duration(milliseconds: 500));
                                  _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                                  await Future.delayed(Duration(milliseconds: 500));
                                  _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                                }

                              }catch(e){

                              }
                            },
                            icon: const Icon(Icons.photo),
                          ),
                          IconButton(
                            onPressed: () async {
                              DateTime startDate = new DateTime.now().toLocal();
                              int offset = await NTP.getNtpOffset(localTime: startDate);
                              var img = await imgFromGalleryMsg();
                              if(img != "" && img != null){
                                messages.add({
                                  "message": "image|${img}",
                                  "user": FirebaseAuth.instance.currentUser?.uid,
                                  "time": startDate.add(Duration(milliseconds: offset))
                                });
                                var snap = FirebaseFirestore.instance.collection("Channels").doc(widget.channelID).update({
                                  "lastUpdate": startDate.add(Duration(milliseconds: offset)),
                                });
                                msgCtrl.text = "";
                                await Future.delayed(Duration(milliseconds: 500));
                                _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                                await Future.delayed(Duration(milliseconds: 500));
                                _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                              }

                            },
                            icon: const Icon(Icons.camera_alt),
                          ),
                          IconButton(
                            onPressed: () async {
                              try{
                                DateTime startDate = new DateTime.now().toLocal();
                                int offset = await NTP.getNtpOffset(localTime: startDate);
                                messages.add({
                                  "message": "msg|${msgCtrl.text}",
                                  "user": FirebaseAuth.instance.currentUser?.uid,
                                  "time": startDate.add(Duration(milliseconds: offset))
                                });
                                var snap = FirebaseFirestore.instance.collection("Channels").doc(widget.channelID).update({
                                  "lastUpdate": startDate.add(Duration(milliseconds: offset)),
                                });
                                msgCtrl.text = "";
                                await Future.delayed(Duration(milliseconds: 500));
                                _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                                await Future.delayed(Duration(milliseconds: 500));
                                _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                              }catch(e){

                              }
                             
                            },
                            icon: const Icon(Icons.send),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ),
        ),
      ),

    );
  }
}
