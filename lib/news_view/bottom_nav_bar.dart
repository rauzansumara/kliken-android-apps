import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.orange[100]),
        ),
      ),
      child: TabBar(
        controller: controller,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        indicatorColor: Colors.white,
        tabs: <Widget>[
          TabIcon(
            icons: Icons.thumb_up,
            text: "Real News",
          ),
          TabIcon(
            icons: Icons.thumb_down,
            text: "Clickbait",
          ),
          TabIcon(
            icons: Icons.book,
            text: "Saved",
          ),
        ],
      ),
    );
  }
}

class TabIcon extends StatelessWidget {
  final String text;
  final IconData icons;

  const TabIcon({
    @required this.icons,
    @required this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icons,
            size: 25.0,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 12.0),
          )
        ],
      ),
    );
  }
}
