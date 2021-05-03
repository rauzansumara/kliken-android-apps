import 'package:flutter/material.dart';
import 'package:kliken/components/popup_action.dart';
import 'package:kliken/components/popup_dialog.dart';
import 'package:kliken/database/db_helper.dart';
import 'package:kliken/model/library.dart';
import 'package:kliken/resources/news_api_provider.dart';

class PopUpNews extends StatelessWidget {
  final String _urlClickbait = 'clickbait';
  final String _urlNonClickbait = 'nonclickbait';
  final String newstype;
  final News news;

  const PopUpNews({
    Key key,
    @required this.newstype,
    this.news,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (choice) {
        choiceAction(choice, context);
      },
      icon: Icon(Icons.more_vert, color: Colors.white),
      itemBuilder: (BuildContext context) {
        return PopUpDialog.choice.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }

  void choiceAction(String choice, BuildContext context) {
    DBHelper db = DBHelper();
    if (choice == PopUpDialog.readLater) {
      String title = 'Tambahkan Baca Nanti?';
      String description = 'Anda bisa membacanya di halaman saved';
      String action = 'Tambahkan';
      String doneAction = "disimpan";
      var onYes = () {
        db.saveNews(news);
      };
      PopUpAction().confirmDialog(
          context, onYes, title, description, action, doneAction);
    } else if (choice == PopUpDialog.report) {
      String _newsType;
      if (newstype == _urlClickbait) {
        _newsType = 'bukan klikbait';
      } else if (newstype == _urlNonClickbait) {
        _newsType = 'klikbait';
      }
      String title = 'Laporkan Berita Ini?';
      String description =
          'Anda bisa melaporkan berita ini sebagai berita $_newsType';
      String action = 'Laporkan';
      String doneAction = "laporkan sebagai $_newsType";
      var onYes = () {
        Api().postData("bagas", news.title, news.link, _newsType);
        print("Melaporkan $_newsType");
      };
      PopUpAction().confirmDialog(
          context, onYes, title, description, action, doneAction);
    }
  }
}
