import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bandnames/models/band.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Bon Jovi', votes: 7),
    Band(id: '3', name: 'Nightwish', votes: 9),
    Band(id: '4', name: 'La oreja de Van Gogh', votes: 6),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Band Names', style: TextStyle(color: Colors.black87),),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: ( _ , index ) =>  _bandTile(bands[index]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addNewBand,
        elevation: 1,
      ),
   );
  }

  Widget _bandTile(Band b) {
    return Dismissible(
      key: Key(b.id),
      onDismissed: (direction) {
        print('Borrando: ${b.id} - ${b.name}');
      },
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Icon(Icons.delete_outline, color: Colors.white,),
              Text('Delete Band', style: TextStyle(color: Colors.white, fontSize: 18.0),),
            ],
          )
        ),
      ),
      child: ListTile(
          leading: CircleAvatar(
            child: Text(b.name.substring(0,2)),
            backgroundColor: Colors.blue[100],
          ),
          title: Text(b.name),
          trailing: Text(b.votes.toString(), style: TextStyle(fontSize: 20,),),
          onTap: () => print(b.name),
      ),
    );
  }



  _addNewBand(){
    final TextEditingController txtCtrl = new TextEditingController();
    if(Platform.isAndroid){

      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Add new band'),
          content: TextField(controller: txtCtrl,),
          actions: <Widget>[
            MaterialButton(
              elevation: 5,
              child: Text('ADD'),
              textColor: Colors.blue,
              onPressed: () => _addBandToList(txtCtrl.text) ,
            ),
          ],
        ),
      );
    }

     showCupertinoDialog(
      context: context, 
      builder: ( _ ) => CupertinoAlertDialog(
        title: Text('Add new band'),
        content: CupertinoTextField(controller: txtCtrl,),
        actions: <Widget>[
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context) ,
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Add'),
            onPressed: () => _addBandToList(txtCtrl.text) ,
          ),
        ],
      ),
    );
  }

  _addBandToList(String name){
    print(name);
    if(name.length > 1){
      //Can continue
      this.bands.add(Band(id: DateTime.now().toString(), name: name));
      setState(() {
      });
    }
    Navigator.pop(context);
  }
}