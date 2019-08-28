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
    "Breakfast",
    "Lunch",
    "2nd Snack",
    "Dinner",
    "3rd Snack",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



