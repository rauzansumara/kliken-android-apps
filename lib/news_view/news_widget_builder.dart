import 'package:flutter/material.dart';
import 'package:kliken/components/loader.dart';
import 'package:kliken/components/news_card.dart';
import 'package:kliken/model/library.dart';

class NewsWidgetBuilder extends StatefulWidget {
  const NewsWidgetBuilder({
    Key key,
    @required bool isRequestSent,
    @required bool isRequestFailed,
    @required GlobalKey<RefreshIndicatorState> refreshIndicatorKey,
    @required ScrollController scrollController,
    @required List<News> newsList,
    @required String url,
    @required VoidCallback onRefresh,
    @required Widget retryUi,
  })  : _isRequestSent = isRequestSent,
        _isRequestFailed = isRequestFailed,
        _refreshIndicatorKey = refreshIndicatorKey,
        _scrollController = scrollController,
        _newsList = newsList,
        _url = url,
        _onRefresh = onRefresh,
        _retryUi = retryUi,
        super(key: key);

  final bool _isRequestSent;
  final bool _isRequestFailed;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey;
  final ScrollController _scrollController;
  final List<News> _newsList;
  final String _url;
  final VoidCallback _onRefresh;
  final Widget _retryUi;

  @override
  NewsWidgetBuilderState createState() {
    return new NewsWidgetBuilderState();
  }
}

class NewsWidgetBuilderState extends State<NewsWidgetBuilder>
    with AutomaticKeepAliveClientMixin<NewsWidgetBuilder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: !widget._isRequestSent
          // Request has not been sent, let's show a progress indicator
          ? Loader()
          // Request has been sent but did it fail?
          : widget._isRequestFailed
              // Yes, it has failed. Show a retry UI
              ? widget._retryUi
              // No it didn't fail. Show the data
              : RefreshIndicator(
                  key: widget._refreshIndicatorKey,
                  onRefresh: widget._onRefresh,
                  child: ListView.builder(
                    controller: widget._scrollController,
                    itemCount: widget._newsList.length,
                    itemBuilder: (BuildContext context, int i) {
                      if (widget._newsList != null) {
                        return NewsCard(
                          news: widget._newsList,
                          i: i,
                          newsType: widget._url,
                        );
                      }
                    },
                  ),
                ),
    );
  }

  @override
  // Supaya posisi scroll tidak berubah ketika pindah tab
  bool get wantKeepAlive => true;
}
