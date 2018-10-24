import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: FirebaseDemo(),
  ));
}

class DemoTabs extends StatefulWidget {
  @override
  _DemoTabsState createState() => _DemoTabsState();
}

class _DemoTabsState extends State<DemoTabs> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: [
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.phone), title: Text("Phone")),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.conversation_bubble), title: Text("Chat"))
      ]),
      tabBuilder: (context, position) {
        return CupertinoPageScaffold(
          child: Center(
            child: Text("Tab ${position + 1}"),
          ),
        );
      },
    );
  }
}

class SimplePage extends StatefulWidget {
  @override
  _SimplePageState createState() => _SimplePageState();
}

class _SimplePageState extends State<SimplePage> {
  CupertinoPageScaffold buildCupertinoPageScaffold() {
    return CupertinoPageScaffold(
      child: Center(
        child: Text("Jignesh"),
      ),
      navigationBar: CupertinoNavigationBar(
        leading: Icon(CupertinoIcons.back),
        middle: Text("App Name"),
        trailing: Icon(CupertinoIcons.search),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildCupertinoPageScaffold();
  }
}

class SliverDemo extends StatefulWidget {
  @override
  _SliverDemoState createState() => _SliverDemoState();
}

class _SliverDemoState extends State<SliverDemo> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text("Chat"),
          ),
          SliverFillRemaining(
            child: Center(
              child: Text("WhatsApp"),
            ),
          )
        ],
      ),
    );
  }
}

class FirebaseDemo extends StatefulWidget {
  @override
  _FirebaseDemoState createState() => _FirebaseDemoState();
}

class _FirebaseDemoState extends State<FirebaseDemo> {

  var quoteController = TextEditingController();
  var authorController = TextEditingController();

  void addDocument(){
    var docRef = Firestore.instance.collection("simple-data").document("test");
    docRef.setData({
      "Quote" : quoteController.text,
      "Author" : authorController.text
    },).then((_){
      print("Document saved successfully");
    },).catchError((e){
      print("Error while saving document");
      print(e);
    },);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Form(
        child: ListView(
          children: <Widget>[
            Material(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Quotation"
                ),
                controller: quoteController,
              ),
            ),
            Material(
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Author"
                ),
                controller: authorController,
              ),
            ),
            CupertinoButton(child: Text("Save"), onPressed: addDocument)
          ],
        ),
      ),
    );
  }
}
