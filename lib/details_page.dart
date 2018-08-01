import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailsPage extends StatefulWidget {
  final manga;
  DetailsPage(this.manga);
  _DetailsPageState createState() => new _DetailsPageState(manga);
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  _DetailsPageState(this.manga);
  final manga;
  List detailsList;
  var _isLoading = true;
  TabController _tabController;

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
    _tabController = new TabController(vsync: this, initialIndex: 0, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        elevation: 0.7,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.orange,
          tabs: <Widget>[
            Tab(text: 'Info'),
            Tab(text: 'Chapters'),
          ],
        ),
      ),
      body: _isLoading
          ? CircularProgressIndicator()
          : TabBarView(
              controller: _tabController,
              children: <Widget>[
                DetailsInfo(),
                DetailsChapter(),
              ],
            ),
    );
  }
}

class DetailsInfo extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container();
  }
}

class DetailsChapter extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container();
  }
}
