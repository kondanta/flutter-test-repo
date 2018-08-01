import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailsPage extends StatefulWidget {
  final manga;
  DetailsPage(this.manga);
  _DetailsPageState createState() => new _DetailsPageState(manga);
}

class _DetailsPageState extends State<DetailsPage> {
  _DetailsPageState(this.manga);
  final manga;
  List detailsList;
  var _isLoading = true;

  // fetching data
  _fetchDetails() async {
    final url =
        "http://192.168.1.105:8080/manga?source=mangadex&url=${manga['url']}";
    final response = await http.get(url);
    detailsList = json.decode(response.body);
    print(detailsList);
    //DetailsList.forEach((elem) => print(elem['name']));
    this.setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _fetchDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: _isLoading
          ? CircularProgressIndicator()
          : Center(
              child: Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.network(
                      detailsList[0]['img'],
                      fit: BoxFit.fill,
                      // TODO: Adjust the box size (102)
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
