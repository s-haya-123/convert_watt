import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:convert_watt/wattModel.dart';

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
    return
      ScopedModelDescendant<WattModel>(
        builder: (context,child,model) {
          return Scaffold(
            appBar: AppBar(
              title: Text('家の電子レンジだと何分？'),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                model.startTimer();
              },
              child: Icon( !model.isStartTimer ? Icons.timer : Icons.cancel,size: 35),
              backgroundColor: !model.isStartTimer ? Colors.amber : Colors.red,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: DropdownButton<String>(
                                  value: model.myWat,
                                  onChanged: (wat) {
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: DropdownButton<String>(
                                  value: model.targetWat,
                                  onChanged: (wat) {
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
                                  value: model.targetMinute,
                                  onChanged: (minute) {
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
                                  value: model.targetSecond,
                                  onChanged: (second) {
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

class FancyFab extends StatefulWidget {
  @override
  _FancyFabState createState() => _FancyFabState();
}

class _FancyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _animateColor;
  Animation<double> _animateIcon;
  Curve _curve = Curves.easeOut;

  @override
  initState() {
    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animateColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget toggle() {
    return FloatingActionButton(
      backgroundColor: _animateColor.value,
      onPressed: animate,
      tooltip: 'Toggle',
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _animateIcon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return toggle();
  }
}