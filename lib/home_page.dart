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
  var ids;
  // fetching data
  _fetchData() async {
    this.setState(() => _isLoading = true);
    final url = "https://jsonplaceholder.typicode.com/posts";
    final response = await http.get(url);
    lst = json.decode(response.body);
    lst.forEach((elem) => print(elem['id']));
    this.setState(() => _isLoading = false);
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
          child: _isLoading
              ? new CircularProgressIndicator()
              : new ListView.builder(
                  itemCount: this.lst == null ? 0 : this.lst.length,
                  itemBuilder: (context, i) {
                    final post = this.lst[i];
                    return Column(
                      children: <Widget>[
                        Text(post['title']),
                        Divider(),
                      ],
                    );
                  }),
        ));
  }
}
