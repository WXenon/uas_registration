import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uas_registration/providers/db_provider.dart';

import 'models/dartmodel.dart';

class PendingUASView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PendingUASViewPage(),
    );
  }
}

class PendingUASViewPage extends StatefulWidget {
  @override
  _PendingUASViewPage createState() => _PendingUASViewPage();
}

class _PendingUASViewPage extends State<PendingUASViewPage> with AutomaticKeepAliveClientMixin<PendingUASViewPage> {
  @override
  bool get wantKeepAlive => true;

  Future<Uas> _loadingUas;

  UASRegClient client = new UASRegClient();

  @override
  void initState() {
    _loadingUas = client.getAllUas(); // only create the future once.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // because we use the keep alive mixin.
    return new FutureBuilder(
      future: _loadingUas,
      initialData: ["There are no pending UAS applications"],
      builder: (BuildContext context, snapshot){
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (_, int position) {
            final item = snapshot.data[position];
            return Card(
              child: ListTile(
                title: Text("UAS: " + snapshot.data[position]),
              ),
            );
          },
        ) : Column(
          children: <Widget>[CircularProgressIndicator()] ,
        );
      },
    );
  }
}