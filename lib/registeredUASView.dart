import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uas_registration/providers/db_provider.dart';

import 'models/dartmodel.dart';

class RegisteredUASView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegisteredUASViewPage(),
    );
  }
}

class RegisteredUASViewPage extends StatefulWidget {
  @override
  _RegisteredUASViewPage createState() => _RegisteredUASViewPage();
}

class _RegisteredUASViewPage extends State<RegisteredUASViewPage> with AutomaticKeepAliveClientMixin<RegisteredUASViewPage> {
  @override
  bool get wantKeepAlive => true;

  UASRegClient client = new UASRegClient();

  List uasrList = [];

  Future<List<Uasr>> getUasrList() async{
    client.getUasr().then((list){
      uasrList.add(list);
    });
    return uasrList;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // because we use the keep alive mixin.
    return new FutureBuilder(
      future: getUasrList(),
      initialData: ["There are no approved UAS"],
      builder: (BuildContext context, snapshot){
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Container(
              child: ListView.builder(
                  itemCount: uasrList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Text('${uasrList[index].title }');
                  }
              )
          );
        }
      },
    );
  }
}