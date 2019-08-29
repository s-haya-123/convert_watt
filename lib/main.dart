import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:convert_watt/wattModel.dart';
import 'package:direct_select/direct_select.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScopedModel<WattModel>(model: WattModel(), child: _watHomePage()),
    );
  }
}

class _watHomePage extends StatelessWidget {
  final elements1 = [
    "5ooW",
    "600W",
    "700W",
  ];
  List<Widget> _buildItems1() {
    return elements1
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
              title: Text('title'),
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
                      DirectSelect(
                          itemExtent: 30.0,
                          selectedIndex: model.myWattIndex,
                          child: MySelectionItem(
                            isForList: true,
                            title: elements1[model.myWattIndex],
                          ),
                          onSelectedItemChanged: (index) {
                            model.selectMywat(index);
                          },
                          items: _buildItems1()),
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

