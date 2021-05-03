import 'package:flutter/material.dart';

class PopUpAction {
  Future<Null> waiting(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(" Mohon tunggu"),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<Null> doneDialog(BuildContext context, String _action) {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Icon(Icons.check),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Center(
                    child: Text("Berita telah di $_action"),
                  ),
                )
              ],
            ),
          ),
          children: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
  }

  Future<Null> confirmDialog(
    BuildContext context,
    void onYes(),
    String _title,
    String _description,
    String _action,
    String _doneAction,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(_description),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Batal',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              color: Colors.orange,
              child: Text(
                _action,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                waiting(context);
                onYes();
                await doneDialog(context, _doneAction);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
