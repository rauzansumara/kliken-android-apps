import 'package:flutter/material.dart';
import 'package:kliken/components/loader.dart';
import 'package:kliken/components/popup_action.dart';
import 'package:kliken/components/saved_news_card.dart';
import 'package:kliken/database/db_helper.dart';
import 'package:kliken/model/library.dart';

class SavedNewsPage extends StatefulWidget {
  final ScrollController scrollController;

  const SavedNewsPage({
    Key key,
    @required this.scrollController,
  }) : super(key: key);

  @override
  SavedNewsPageState createState() {
    return new SavedNewsPageState();
  }
}

class SavedNewsPageState extends State<SavedNewsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        child: FutureBuilder<List<News>>(
          future: DBHelper().getNewsFromDB(),
          builder: (context, snapshot) {
            /// Cek status koneksi
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Loader();
                break;
              case ConnectionState.active:
              case ConnectionState.done:
                return snapshot.data.isEmpty
                    ? PlaceHolder()
                    : ListView.builder(
                  itemCount: snapshot.data.length,
                  controller: widget.scrollController,
                  itemBuilder: (BuildContext context, int i) {
                    return SavedNewsCard(
                      news: snapshot.data,
                      i: i,
                      delete: () => _deleteNewsFromDB(snapshot, i),
                    );
                  },
                );
                break;
            }
          },
        ),
        onRefresh: _handleRefresh,
      ),
    );
  }

  void _deleteNewsFromDB(AsyncSnapshot snapshot, int i) {
    String _title = "Hapus Berita";
    String _description = 'Hapus "${snapshot.data[i].title}" dari daftar baca?';
    String _action = "Hapus";
    String _doneAction = "dihapus";

    void onYes() async {
      await DBHelper().deleteNews(snapshot.data[i]);
      setState(() {
        i = i;
      });
    }

    PopUpAction().confirmDialog(
        context, onYes, _title, _description, _action, _doneAction);
  }

  Future<Null> _handleRefresh() async {
    await new Future.delayed(new Duration(seconds: 1));

    setState(() {});

    return null;
  }
}

class PlaceHolder extends StatelessWidget {
  const PlaceHolder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Padding(
      padding: const EdgeInsets.all(60.0),
      child: Text(
          'Kosong, Kamu dapat menyimpan berita dengan tap menu di pojok kanan bawah berita'),
    )));
  }
}
