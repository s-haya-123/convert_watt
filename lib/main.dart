import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:convert_watt/wattModel.dart';
import 'package:firebase_admob/firebase_admob.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScopedModel<WattModel>(model: WattModel(), child: _watHomePage()),
    );
  }
}

class _watHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-1457109199282503~1387247486');
    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['flutterio', 'beautiful apps'],
      contentUrl: 'https://flutter.io',
      birthday: DateTime.now(),
      childDirected: false,
      designedForFamilies: false,
      gender: MobileAdGender.male, // or female, unknown
      testDevices: <String>[], // Android emulators are considered test devices
    );

    BannerAd myBanner = BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        // 広告の読み込みが完了
        print("BannerAd event is $event");
      },
    );
    myBanner
      ..load()
      ..show(
        // ボトムからのオフセットで表示位置を決定
        anchorOffset: 0.0,
        anchorType: AnchorType.bottom,
      );
    return
      ScopedModelDescendant<WattModel>(
        builder: (context,child,model) {
          return Scaffold(
            appBar: AppBar(
              title: Text('家の電子レンジだと何分？'),
            ),
            floatingActionButton: Container(
              margin: EdgeInsets.only(bottom: 80),
              child: FloatingActionButton(
                onPressed: () {
                  model.startTimer();
                },
                child: Icon( !model.isStartTimer ? Icons.timer : Icons.cancel,size: 35),
                backgroundColor: !model.isStartTimer ? Colors.amber : Colors.red,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "あなたの家の電子レンジ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Center(
                              child: DropdownButton<String>(
                                disabledHint: Text(model.myWat, style: TextStyle(fontSize: 30)),
                                  value: model.myWat,
                                  onChanged: model.isStartTimer ? null : (wat) {
                                    model.setMyWat(wat);
                                  },
                                  items: model.watList
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value, style: TextStyle(fontSize: 30)),
                                    );
                                  }).toList()),
                            ),
                            Text(
                                'W'
                            )
                          ]
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "商品のワット数",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Center(
                              child: DropdownButton<String>(
                                  disabledHint: Text(model.targetWat, style: TextStyle(fontSize: 30)),
                                  value: model.targetWat,
                                  onChanged: model.isStartTimer ? null : (wat) {
                                    model.setTargetWat(wat);
                                  },
                                  items: model.watList
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value, style: TextStyle(fontSize: 30)),
                                    );
                                  }).toList()),
                            ),
                            Text(
                              'W'
                            )
                          ]
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "温める時間",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(left: 100.0),
                              child: DropdownButton<String>(
                                  disabledHint: Text(model.targetMinute, style: TextStyle(fontSize: 30)),
                                  value: model.targetMinute,
                                  onChanged: model.isStartTimer ? null : (minute) {
                                    model.setMinute(minute);
                                  },
                                  items: model.minutes
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value, style: TextStyle(fontSize: 30)),
                                    );
                                  }).toList())
                          ),
                          Text(
                            '分'
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 100.0),
                              child: DropdownButton<String>(
                                  disabledHint: Text(
                                      int.parse(model.targetSecond) < 10 ? '${model.targetSecond}  ':model.targetSecond,
                                      style: TextStyle(fontSize: 30)),
                                  value: model.targetSecond,
                                  onChanged: model.isStartTimer ? null :(second) {
                                    model.setSecond(second);
                                  },
                                  items: model.seconds
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value, style: TextStyle(fontSize: 30)),
                                    );
                                  }).toList())
                          ),
                          Text(
                              '秒'
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "あなたが設定する時間",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text(
                          "${model.myMinute}分      ${model.mySecond}秒",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            fontSize: 50,
                        ),)
                      ),
                    ]),
              ),
            ),
          );
        }
      );
  }

}

