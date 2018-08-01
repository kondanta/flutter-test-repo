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
                Deneme(detailsList),
                DetailsChapter(),
              ],
            ),
    );
  }
}

class DetailsInfo extends StatelessWidget {
  DetailsInfo(this.manga);
  final manga;

  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var movieInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          manga[0]['name'],
          style: textTheme.title,
        ),
        SizedBox(height: 8.0),
        Text(
          manga[0]['author'],
          style: textTheme.caption,
        ),
        SizedBox(height: 35.0),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                manga[0]['status'],
                style: textTheme.caption,
              ),
            ),
            Icon(Icons.favorite_border),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          manga[0]['chapterLinks'].length.toString() + ' chapters',
          style: textTheme.caption,
        )
      ],
    );

    // Actual return statement
    return Stack(
      children: [
        Positioned(
          top: 16.0,
          left: 16.0,
          right: 16.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.network(
                manga[0]['img'],
                height: 160.0,
              ),
              SizedBox(width: 16.0),
              Expanded(child: movieInformation),
            ],
          ),
        ),
      ],
    );
  }
}

class GenreGenerator extends StatelessWidget {
  GenreGenerator(this.manga);
  final manga;

  List<Widget> _buildCategoryChips(List genres, TextTheme textTheme) {
    return genres.map((genre) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Chip(
          label: Text(genre),
          labelStyle: textTheme.caption,
          backgroundColor: Colors.black12,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final genres = manga[0]['genres'].split(' ');
    var textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Genre"),
        Wrap(
          direction: Axis.horizontal,
          children: _buildCategoryChips(genres, textTheme),
        ),
      ],
    );
  }
}

class DescriptionGenerator extends StatelessWidget {
  DescriptionGenerator(this.manga);
  final manga;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Description"),
        SizedBox(height: 8.0),
        Text(manga[0]['description']),
      ],
    );
  }
}

class Deneme extends StatelessWidget {
  Deneme(this.manga);
  final manga;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 200.0, child: DetailsInfo(manga)),
            SizedBox(height: 8.0),
            GenreGenerator(manga),
            SizedBox(height: 8.0),
            DescriptionGenerator(manga),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}

class DetailsChapter extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container();
  }
}
