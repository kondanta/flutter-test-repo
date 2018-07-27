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
  // fetching data
  _fetchData() async {
    final url = "http://192.168.1.105:8080/search?source=mangadex&name=kanojo";
    final response = await http.get(url);
    lst = json.decode(response.body);
    lst.forEach((elem) => print(elem['name']));
    this.setState(() => _isLoading = false);
  }

  @override
  void initState() {
    this._fetchData();
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
                      child: MangaRow(manga: post),
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

class MangaRow extends StatelessWidget {
  final manga;
  MangaRow({this.manga});

  @override
  Widget build(BuildContext context) {
    // Manga thumbnail variable
    final mangaThumbnail = new Container(
        margin: EdgeInsets.symmetric(vertical: 0.0),
        alignment: FractionalOffset.topLeft,
        child: Image.network(manga['img'], height: 100.0, width: 120.0));

    // Manga Card Details
    final mangaDetails = new Container(
      margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 8.0),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                manga['name'],
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600), //textstyle
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ), //text
        ], //widget[]
      ), //column
    );

    // Manga card variable
    final mangaCard = new Container(
      child: mangaDetails,
      height: 100.0,
      margin: EdgeInsets.only(left: 46.0),
      decoration: BoxDecoration(
        color: Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ), //box decoration
    );

    // Renderer
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ), //EdgeInsets,
      child: Stack(
        children: <Widget>[
          mangaCard,
          mangaThumbnail,
        ], //Widget[]
      ), //Stack
    ); //container;
  }
}
