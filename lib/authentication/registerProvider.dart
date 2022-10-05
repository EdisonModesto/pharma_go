import 'package:flutter/material.dart';

class registerProvider with ChangeNotifier{
  late String Number;
  late String Name;
  late String Address;
  late String Age;
  late String Height;
  late String Weight;

  void addDetails(String p1, p2, p3, p4, p5, p6){
    Number = p1;
    Name = p2;
    Address = p3;
    Age = p4;
    Height = p5;
    Weight = p6;
    notifyListeners();
  }
}