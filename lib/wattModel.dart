import 'package:scoped_model/scoped_model.dart';

class WattModel extends Model {
  String myWat = '700';
  String targetWat = '500';
  String targetMinute = '0';
  String targetSecond = '0';
  String myMinute = '0';
  String mySecond = '0';

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
    final targetEnergy = energy / int.parse(this.myWat);
    this.myMinute = (targetEnergy / 60).floor().toString();
    this.mySecond = (targetEnergy % 60).floor().toString();
  }
}