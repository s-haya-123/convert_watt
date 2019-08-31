import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

class WattModel extends Model {
  String myWat = '700';
  String targetWat = '500';
  String targetMinute = '0';
  String targetSecond = '0';
  String myMinute = '0';
  String mySecond = '0';
  double time = 0;

  final watList = [
    '500',
    '600',
    '700',
  ];
  final minutes = new List<String>.generate(9, (i)=>(i).toString());
  final seconds = new List<String>.generate(60, (i)=>i.toString());

  void setMyWat(String wat) {
    this.myWat = wat;
    calcTargetTime();
    notifyListeners();
  }
  void setMinute(String minute) {
    this.targetMinute = minute;
    calcTargetTime();
    notifyListeners();
  }
  void setSecond(String second) {
    this.targetSecond = second;
    calcTargetTime();
    notifyListeners();
  }
  void setTargetWat(String wat) {
    this.targetWat = wat;
    calcTargetTime();
    notifyListeners();
  }

  void calcTargetTime() {
    final energy = (int.parse(this.targetSecond) + int.parse(this.targetMinute) * 60) * int.parse(this.targetWat);
    this.time = energy / int.parse(this.myWat);
    setTargetTime(this.time);
  }
  void setTargetTime(double time) {
    this.myMinute = (time / 60).floor().toString();
    this.mySecond = (time % 60).floor().toString();
  }
  void startTimer() {
    const oneSec = const Duration(seconds:1);
    new Timer.periodic(oneSec, (Timer t) {
      if(this.time > 1) {
      this.time--;
      setTargetTime(this.time);
      this.notifyListeners();
      } else {
        t.cancel();
      }
    });
  }
}