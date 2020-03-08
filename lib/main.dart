import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//--//
void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corona Radars',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Corona Detection'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Row(
          children: [
            Expanded(
              child: Text(
                document['city'],
                style: Theme
                    .of(context)
                    .textTheme
                    .headline,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color(0xffddddff),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Text(
                document['case'].toString(),
                style: Theme
                    .of(context)
                    .textTheme
                    .display1,
              ),
            ),
          ]
      ),
//      onTap: () {
//        print("Should increase votes here.");
//      },
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('City').snapshots(),
        builder:(context,snapshot){
          if (!snapshot.hasData) return const Text('Loading...');
          return ListView.builder(
            itemExtent: 80.0,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) =>
                _buildListItem(context, snapshot.data.documents[index]),
          );
        }
      ),
    );
  }
}

