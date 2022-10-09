import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../my_flutter_app_icons.dart';

class expandItem extends StatefulWidget {
  const expandItem({Key? key}) : super(key: key);

  @override
  State<expandItem> createState() => _expandItemState();
}

class _expandItemState extends State<expandItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1631549916768-4119b2e5f926?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1179&q=80"
                ),

                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            color: const Color(0xff219C9C),
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/images/PharmaGo_rounded.png", scale: 3.5,),
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    "PharmaGo",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            overflow: TextOverflow.ellipsis,
                            "Ascorbic Acid Xasorvic 100mg Chewable Tablet 100's ",
                            style: TextStyle(
                                fontSize: 16
                            ),
                            softWrap: true,
                            maxLines: 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  overflow: TextOverflow.ellipsis,
                                  "PHP 175",
                                  style: TextStyle(
                                      fontSize: 16,
                                    color: Color(0xff219C9C)
                                  ),
                                  softWrap: true,
                                  maxLines: 2,
                                ),
                                SizedBox(
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: (){},
                                        icon: Icon(Icons.chat),
                                      ),
                                      IconButton(
                                        onPressed: (){},
                                        icon: Icon(Icons.add_shopping_cart_sharp),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            overflow: TextOverflow.ellipsis,
                            "Description",
                            style: TextStyle(
                                fontSize: 14
                            ),
                            softWrap: true,
                            maxLines: 2,
                          ),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            "\nGeneric Name: Ascorbic Acid",
                            style: TextStyle(
                                fontSize: 12,
                            ),
                            softWrap: true,
                            maxLines: 2,
                          ),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            "\nQuantity: 100",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            softWrap: true,
                            maxLines: 2,
                          ),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            "\nShop Location: Place",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            softWrap: true,
                            maxLines: 2,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
