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
    final url = "http://192.168.1.105:8080/search?source=mangadex&name=kanojo";
    final response = await http.get(url);
    lst = json.decode(response.body);
    lst.forEach((elem) => print(elem['name']));
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
                    return FlatButton(
                      padding: EdgeInsets.all(0.0),
                      child: MangaCell(manga: post),
                      onPressed: () {
                        print("Pressed ${post['name']}");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailsPage(manga: post)));
                      },
                    );
                  }),
        ));
  }
}

class MangaCell extends StatelessWidget {
  final manga;
  MangaCell({this.manga});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Image.network(manga['img']),
              Container(height: 6.0),
              Text(manga['name']),
            ],
          ),
        )
      ],
    );
  }
}

class DetailsPage extends StatelessWidget {
  final manga;
  DetailsPage({this.manga});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image.network(manga['img']),
            Container(height: 6.0),
            Text(manga['name']),
            Container(height: 2.0),
            Text(manga['url']),
          ],
        ),
      ),
    );
  }
}
