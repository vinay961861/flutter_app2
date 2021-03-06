import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp1/Services.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
class group extends StatefulWidget {
  @override
  _groupState createState() => _groupState();
}

class _groupState extends State<group> {
  CrudServices crudServices=CrudServices();
  File _image;
  var group = {
    'imageUrl': imageUrl,
    'GroupName': groupName,
    'Description': descrption,
    'Duration': water
  };
  static var water;
  static var groupName;
  static var descrption;
  static var imageUrl="image/jpeg;base64,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";
  var _time = ['7:00PM', '6:00PM'];
  var _star = "time";
  int ini = 0;
  int _interwal = 1;
  int res1 = 0;
  int res2 = 0;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen[200],
          title: Text(
            "Create Group",
            style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 25.0),
          ),
          actions: <Widget>[
            Container(
                margin: EdgeInsets.only(right: 30.0),
                child: Center(
                    child: InkWell(onTap: (){
                      uploadImage(context);
                      Firestore.instance.collection('create').add(group).catchError((e){print(e);});
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Uploaded Succesfull"),));
                    },
                      child: Text(
                        "Save",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    )))
          ],
        ),
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              primary: true,
              pinned: true,
              centerTitle: false,
              actionsIconTheme: IconThemeData(color: Colors.blue, size: 500.0),
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                background: InkWell(
                  onTap: () {
                    getImage();
                  },
                  child: Container(
                    child: _image == null
                        ? Image.asset(
                      'images/c1.jpg',
                      fit: BoxFit.fill,
                    )
                        : Image.file(_image),),
                ),
              ),
              expandedHeight: 250.0,
            ),
            SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Group name",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 10.0, left: 20.0, right: 10.0),
                                child: SizedBox(
                                  height: 50.0,
                                  child: RaisedButton(
                                    child: Center(
                                      child: Text("Water amount : $_interwal"),
                                    ),
                                    color: Colors.lightGreen[300],
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40.0)),
                                    onPressed: () {
                                      ShowAlert(context);
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 10.0, left: 20.0, right: 10.0),
                                child: DropdownButton<String>(
                                  icon: Icon(Icons.timer),
                                  items: _time.map((String drop) {
                                    return DropdownMenuItem<String>(
                                      value: drop,
                                      child: Text(drop),
                                    );
                                  }).toList(),
                                  onChanged: (String str) {
                                    setState(() {
                                      this._star = str;
                                    });
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 200.0,
                      )
                    ],
                  )
                ]))
          ],
        ),
        drawerEdgeDragWidth: 10.0,
      ),
    );
  }

  void ShowAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext conntext) {
          return AlertDialog(
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: <Widget>[Text("Water Interval")],
                  ),
                  NumberPicker.integer(
                      initialValue: ini,
                      itemExtent: 40.0,
                      listViewWidth: 30.0,
                      minValue: 0,
                      maxValue: 100,
                      onChanged: (res) {
                        setState(() {
                          ini = res;
                          res1 = res;
                          water=res;
                        });
                      }),
                  Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          setState(() {
                            ini = 0;
                            Navigator.of(context).pop();
                          });
                        },
                        child: Text(
                          "CANCEL",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            ini = res1;
                            Navigator.of(context).pop();
                          });
                        },
                        child: Text(
                          "OK",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  )
                ],
              ),
            ),
          );
        });
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future uploadImage(BuildContext context) async {
    String filename = basename(_image.path);
    StorageReference storageReference =
    FirebaseStorage.instance.ref().child(filename);
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    imageUrl = FirebaseStorage.instance
        .ref()
        .child(filename)
        .getDownloadURL()
        .toString();
  }
}