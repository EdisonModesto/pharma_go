import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class addItemUI extends StatefulWidget {
  const addItemUI({Key? key}) : super(key: key);

  @override
  State<addItemUI> createState() => _addItemUIState();
}

class _addItemUIState extends State<addItemUI> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController stocksCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameCtrl.dispose();
    priceCtrl.dispose();
    stocksCtrl.dispose();
    descCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Add Item to Shop",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50,
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
                          controller: nameCtrl,
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(height: 0),
                            label: Text("Item Name"),
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
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            controller: priceCtrl,
                              keyboardType: TextInputType.phone,
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
                                errorStyle: TextStyle(height: 0),
                                label: Text("Price"),
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
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            controller: stocksCtrl,
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
                              decoration: const InputDecoration(
                                errorStyle: TextStyle(height: 0),
                                label: Text("Stocks"),
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
                    SizedBox(
                      height: 300,
                      child: TextFormField(
                        controller: descCtrl,
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
                          maxLines: 10,
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(height: 0),
                            label: Text("Description"),
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
                    ElevatedButton(
                      onPressed: (){
                        if (_formKey.currentState!.validate()) {
                          var collection = FirebaseFirestore.instance.collection('Shop');
                          collection.doc().set({
                            "Heading": nameCtrl.text,
                            "Price": priceCtrl.text,
                            "Stock": stocksCtrl.text,
                            "Description": descCtrl.text
                          });
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
                          "Add Item"
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
