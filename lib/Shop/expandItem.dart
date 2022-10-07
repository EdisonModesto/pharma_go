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
            height: 250,
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
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Heading",
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                        Text(
                          "20 Pesos",
                          style: TextStyle(
                              fontSize: 20
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
