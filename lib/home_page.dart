import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List lst;
  var _isLoading = false;
  _fetchData() async {
    final url = "https://jsonplaceholder.typicode.com/posts";
    this.setState(() => _isLoading = true);
    await http.get(url).then((val) => this.setState(() {
          _isLoading = false;
          lst = json.decode(val.body);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text("Demo App"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  print('Testing');
                  setState(() => _isLoading = true);
                  _fetchData();
                },
              ),
            ]),
        body: Center(
          child:
              _isLoading ? new CircularProgressIndicator() : new Text("Done"),
        ));
  }
}
