import 'package:flutter/material.dart';
import 'package:kliken/components/news_webview.dart';
import 'package:kliken/model/library.dart';

class SavedNewsCard extends StatelessWidget {
  final List<News> news;
  final int i;
  final VoidCallback delete;

  const SavedNewsCard({
    Key key,
    @required this.news,
    @required this.i,
    this.delete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String _title = news[i].title.trim();
    final String _img = news[i].img;
    final String _date = news[i].date;
    final String _media = news[i].media;
    final String _link = news[i].link;

    return Container(
      child: GestureDetector(
        onTapUp: (_) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsWebView(
                    url: _link,
                    title: _title,
                  ),
            ),
          );
        },
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          color: Colors.orange,
          child: Column(
            children: <Widget>[
              Container(
                height: 40.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        //Media goes here
                        child: new Media(media: _media),
                      ),
                      Expanded(
                        flex: 3,
                        //Date goes here
                        child: new Date(date: _date),
                      ),
                    ],
                  ),
                ),
              ),
              //Image goes here
              new NewsImage(img: _img),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 9,
                        //Title goes here
                        child: new Title(title: _title),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          onPressed: delete,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    Key key,
    @required String title,
  })  : _title = title,
        super(key: key);

  final String _title;

  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      maxLines: 2,
      softWrap: true,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class NewsImage extends StatelessWidget {
  const NewsImage({
    Key key,
    @required String img,
  })  : _img = img,
        super(key: key);

  final String _img;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(height: 180.0),
      child: FadeInImage.assetNetwork(
        image: _img,
        fit: BoxFit.cover,
        placeholder: 'assets/place_holder.jpg',
      ),
    );
  }
}

class Date extends StatelessWidget {
  const Date({
    Key key,
    @required String date,
  })  : _date = date,
        super(key: key);

  final String _date;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Icon(
          Icons.access_time,
          size: 14.0,
          color: Colors.white70,
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(
          _date,
          style: TextStyle(
              color: Colors.white70,
              fontSize: 14.0,
              fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}

class Media extends StatelessWidget {
  const Media({
    Key key,
    @required String media,
  })  : _media = media,
        super(key: key);

  final String _media;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.all(new Radius.circular(8.0)),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Text(
          _media,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
