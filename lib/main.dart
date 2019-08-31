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
  List<Widget> _buildList(List element) {
    return element
        .map((val) => MySelectionItem(
      title: val,
      isForList: false,
    ))
        .toList();
  }
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
                // Add your onPressed code here!
              },
              child: Icon(Icons.timer,size: 35),
              backgroundColor: Colors.amber,
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

class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;

  const MySelectionItem({Key key, this.title, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: isForList
          ? Padding(
        child: _buildItem(context),
        padding: EdgeInsets.all(20.0),
      )
          : Card(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Stack(
          children: <Widget>[
            _buildItem(context),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_drop_down),
            )
          ],
        ),
      ),
    );
  }

  _buildItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Text(title),
    );
  }
}

