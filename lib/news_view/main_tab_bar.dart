import 'dart:async';
import 'package:flutter/material.dart';

import 'package:kliken/model/library.dart';
import 'package:kliken/news_view/bottom_nav_bar.dart';
import 'package:kliken/news_view/news_widget_builder.dart';
import 'package:kliken/news_view/saved_news_page.dart';
import 'package:kliken/resources/news_api_provider.dart';

class MainTabBar extends StatefulWidget {
  @override
  _MainTabBarState createState() => _MainTabBarState();
}

class _MainTabBarState extends State<MainTabBar>
    with SingleTickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKeyNonClickbait =
  GlobalKey<RefreshIndicatorState>(),
      _refreshIndicatorKeyClickbait = GlobalKey<RefreshIndicatorState>();

  final String _urlClickbait = 'clickbait',
      _urlNonClickbait = 'nonclickbait';

  final TextEditingController _search = TextEditingController();

  bool _isNonClickbaitRequestSent = false,
      _isNonClickbaitRequestFailed = false,
      _isClickbaitRequestSent = false,
      _isClickbaitRequestFailed = false;

  Icon _searchIcon = Icon(Icons.search);

  List<News> _newsListNonClickbait = [],
      _nonClickbaitSearchResult = [],
      _newsListClickbait = [],
      _clickbaitSearchResult = [];

  ScrollController _scrollController;
  TabController _tabController;

  Widget _appBarTitle;

  /// Widget appBar default
  Widget _appBarDefault = Image.asset(
    "assets/logo_kliken.png",
    fit: BoxFit.fitHeight,
    height: 30.0,
  );

  /// Method untuk mendownload resource berita non-klikbait
  void _downloadDataNonClickbait() {
    Api().getNews(_urlNonClickbait).then((news) {
      if (news != null) {
        _newsListNonClickbait = news;
        setState(() => _isNonClickbaitRequestSent = true);
      }
    });
  }

  /// Method untuk mendownload resource berita klikbait
  void _downloadDataClickbait() {
    Api().getNews(_urlClickbait).then((news) {
      if (news != null) {
        _newsListClickbait = news;
        setState(() => _isClickbaitRequestSent = true);
      }
    });
  }

  @override

  /// Override method untuk inisialisasi state
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _appBarTitle = _appBarDefault;

    /// Jalankan method download saat initState()
    _downloadDataNonClickbait();
    _downloadDataClickbait();

    /// Untuk mereset kondisi search ketika pindah tab
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    ///
    /// Cek apakah index tab berubah/berpindah
    if (_tabController.indexIsChanging) {
      /// Clear teks di _search
      _search.clear();

      /// Clear list clickbait hasil search
      _clickbaitSearchResult.clear();

      /// Clear list non-clickbait hasil search
      _nonClickbaitSearchResult.clear();

      /// Reset state _searchIcon dan _appBarTitle
      setState(() {
        this._searchIcon = Icon(Icons.search);
        this._appBarTitle = _appBarDefault;
      });
    }
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(Icons.close);
        this._appBarTitle = TextField(
          textInputAction: TextInputAction.search,
          autofocus: true,
          style: TextStyle(color: Colors.black, fontSize: 20.0),
          controller: _search,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Search...',
          ),
          onChanged: (text) {
            ///
            /// Switch case untuk menambahkan berita sesuai method onChanged untuk
            /// di tambahkan ke list hasil search
            ///
            switch (_tabController.index) {
              case 0:
                _nonClickbaitSearchResult.clear();
                print('Non Clickbait Filter ' + '$text');

                /// Tambahkan text onChanged ke list hasil search
                _newsListNonClickbait.forEach((news) {
                  if (news.title.toLowerCase().contains(text))
                    _nonClickbaitSearchResult.add(news);
                });
                setState(() {});
                break;
              case 1:
                _clickbaitSearchResult.clear();
                print('Clickbait Filter ' + '$text');

                /// Tambahkan text onChanged ke list hasil search
                _newsListClickbait.forEach((news) {
                  if (news.title.toLowerCase().contains(text))
                    _clickbaitSearchResult.add(news);
                });
                setState(() {});
                break;
            }
          },
          onSubmitted: (_) {
            /// Ketika di submit maka kembalikan ke appBar default
            setState(() {
              this._searchIcon = Icon(Icons.search);
              this._appBarTitle = _appBarDefault;
            });
            _search.clear();
          },
        );
      } else {
        /// Kembalikan ke appBar default
        this._searchIcon = Icon(Icons.search);
        this._appBarTitle = _appBarDefault;
        _search.clear();
      }
    });
  }

  /// Widget appBar dibuat terpisah agar content di dalamnya dapat dynamic
  Widget _appBar() {
    var _dynamicAppBar;

    /// Ketika tab ada pada index 2 (Halaman saved) maka sembunyikan tombol search
    if (_tabController.index != 2) {
      setState(() {
        _dynamicAppBar = AppBar(
          elevation: 1.0,
          backgroundColor: Colors.orange,
          title: _appBarTitle,
          actions: <Widget>[
            IconButton(
              icon: _searchIcon,
              onPressed: _searchPressed,
            ),
          ],
        );
      });
    } else if (_tabController.index == 2) {
      setState(() {
        _dynamicAppBar = AppBar(
            elevation: 1.0,
            backgroundColor: Colors.orange,
            title: _appBarTitle);
      });
    }
    return _dynamicAppBar;
  }

  /// Method saat refresh Indicator tab non-klikbait ter trigger
  Future<Null> _handleRefreshNonClickBait() async {
    print('Refresh Non-Klikbait');
    setState(() {
      _isNonClickbaitRequestSent = false;
    });

    /// Clear hasil search
    _search.clear();
    _clickbaitSearchResult.clear();

    _downloadDataNonClickbait();
  }

  /// Method saat refresh Indicator tab klikbait ter trigger
  Future<Null> _handleRefreshClickBait() async {
    print('Refresh Klikbait');
    setState(() {
      _isNonClickbaitRequestSent = false;
    });

    /// Clear hasil search
    _search.clear();
    _nonClickbaitSearchResult.clear();

    _downloadDataClickbait();
  }

  void retryRequest() {
    setState(() {
      // Let's just reset the fields.
      _isNonClickbaitRequestSent = false;
      _isNonClickbaitRequestFailed = false;
      _isClickbaitRequestSent = false;
      _isClickbaitRequestFailed = false;
    });
  }

  /// Widget saat koneksi error
  Widget _showRetryUI() {
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            "Request Failed",
            style: new TextStyle(fontSize: 16.0),
          ),
          new Padding(
            padding: new EdgeInsets.only(top: 10.0),
            child: new RaisedButton(
              onPressed: retryRequest,
              child: new Text(
                "Retry Request",
                style: new TextStyle(color: Colors.white),
              ),
              color: Theme
                  .of(context)
                  .accentColor,
              splashColor: Colors.deepOrangeAccent,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _appBar(),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[

            /// Widget class untuk list view
            NewsWidgetBuilder(
              isRequestSent: _isNonClickbaitRequestSent,
              isRequestFailed: _isNonClickbaitRequestFailed,
              refreshIndicatorKey: _refreshIndicatorKeyNonClickbait,
              scrollController: _scrollController,

              ///
              /// Jika search bar terisi, maka tampilkan list hasil pencarian
              /// bila kosong, maka tampilkan list berita dari RestAPI
              newsList: _nonClickbaitSearchResult.length != 0 ||
                  _search.text.isNotEmpty
                  ? _nonClickbaitSearchResult
                  : _newsListNonClickbait,
              url: _urlNonClickbait,
              onRefresh: () => _handleRefreshNonClickBait(),
              retryUi: _showRetryUI(),
            ),

            /// Widget class untuk list view
            NewsWidgetBuilder(
              isRequestSent: _isClickbaitRequestSent,
              isRequestFailed: _isClickbaitRequestFailed,
              refreshIndicatorKey: _refreshIndicatorKeyClickbait,
              scrollController: _scrollController,

              ///
              /// Jika search bar terisi, maka tampilkan list hasil pencarian
              /// bila kosong, maka tampilkan list berita dari RestAPI
              newsList:
              _clickbaitSearchResult.length != 0 || _search.text.isNotEmpty
                  ? _clickbaitSearchResult
                  : _newsListClickbait,
              url: _urlClickbait,
              onRefresh: () => _handleRefreshClickBait(),
              retryUi: _showRetryUI(),
            ),
            SavedNewsPage(scrollController: _scrollController),
          ],
        ),
        bottomNavigationBar: BottomNavBar(controller: _tabController),
      ),
    );
  }
}
