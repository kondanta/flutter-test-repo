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
            brightness: Brightness.dark,
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
              : GridView.count(
                  crossAxisCount: 3,
                  padding: EdgeInsets.all(16.0),
                  childAspectRatio: 4.0 / 9.0,
                  shrinkWrap: true,
                  children: _buildGridCards(context, lst) // Changed code
                  ),
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

List<Card> _buildGridCards(BuildContext context, List products) {
  if (products == null || products.isEmpty) {
    return const <Card>[];
  }

  return products.map((product) {
    return Card(
      elevation: 0.0,
      color: Colors.orange,
      // TODO: Adjust card heights (103)
      child: InkResponse(
        enableFeedback: true,
        child: Column(
          // TODO: Center items on the card (103)
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 5.5 / 9,
              child: Image.network(
                product['img'],
                fit: BoxFit.fill,
                // TODO: Adjust the box size (102)
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  // TODO: Align labels to the bottom and center (103)
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product['name'],
                      // style: theme.textTheme.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          print("Pressed ${product['name']}");
          transition(context, product);
        },
      ),
    );
  }).toList();
}

void transition(BuildContext context, Map<dynamic, dynamic> url) {
  Navigator.of(context).push(new FadeRoute(new DetailsPage(manga: url)));
}

class FadeRoute extends PageRoute {
  final Widget child;

  FadeRoute(this.child);

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);
}
