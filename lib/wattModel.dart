import 'package:scoped_model/scoped_model.dart';
import 'dart:io';

class WattModel extends Model {
  int myWattIndex = 0;
  int targetWatt = 500;
  WattModel() {

  }
  void selectMywat(int index) {
    this.myWattIndex = index;
    notifyListeners();
  }
}