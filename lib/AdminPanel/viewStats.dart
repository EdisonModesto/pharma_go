import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class viewStats extends StatefulWidget {
  const viewStats({Key? key}) : super(key: key);

  @override
  State<viewStats> createState() => _viewStatsState();
}

class _viewStatsState extends State<viewStats> {
  double H = 250;
  var shopData = FirebaseFirestore.instance.collection("shopData").doc("data");
  var totalSales = 0;

  getSales()async{
    var snap = await shopData.get();
    setState(() {
      totalSales = snap["totalSales"];
    });
  }

  @override
  void initState() {
    getSales();
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
                "Shop Statistics",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              TextButton(
                onPressed: (){
                  shopData.update({
                    "totalSales": 0
                  }).whenComplete(() => Navigator.pop(context));
                }, child: const Text("Clear"),
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact
                ),
              )
            ],
          ),
          const Text(
            "This is where you see your shops total sales. You can see how your shop is doing and see how many sales you have made.",
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 13,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Center(
              child: Text(
                "Total Sales: $totalSales PHP",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
