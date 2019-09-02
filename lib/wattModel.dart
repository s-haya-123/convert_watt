import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:vibration/vibration.dart';

class WattModel extends Model {
  String myWat = '700';
  String targetWat = '500';
  String targetMinute = '0';
  String targetSecond = '0';
  String myMinute = '0';
  String mySecond = '0';
  double time = 0;
  bool isStartTimer = false;
  Timer _timer;

  final watList = [
    '500',
    '600',
    '700',
  ];
  final minutes = new List<String>.generate(10, (i)=>(i).toString());
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
    if(!this.isStartTimer) {
      this.isStartTimer = true;
      new Timer.periodic(Duration(seconds:1), (Timer t) {
        this._timer = t;
        if(this.time > 1 && this.isStartTimer) {
          this.time--;
          setTargetTime(this.time);
          this.notifyListeners();
        } else if(!this.isStartTimer) {
          t.cancel();
          notifyListeners();
        }else {
          t.cancel();
          Vibration.vibrate(duration: 3000);
          this.isStartTimer = false;
          notifyListeners();
        }
      });
    } else {
      this._timer.cancel();
      this.isStartTimer = false;
    }
    notifyListeners();
  }
}