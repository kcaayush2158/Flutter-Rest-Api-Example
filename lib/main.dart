import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() => runApp(HomeApp());
class HomeApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: RestState(),
    );
  }
}

class RestState extends StatefulWidget {
  @override
  _RestStateState createState() => _RestStateState();
}

class _RestStateState extends State<RestState> {
  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = jsonDecode(response.body);
    });
    print(data[1]["title"]);
    return "success";
  }

  @override
  void initState(){
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List view"),backgroundColor: Colors.blue,),
      body:new ListView.builder(
        itemCount :data==null?0:data.length,
        itemBuilder: (BuildContext context,int index){
          return Card(
            child:Text(data[index]["title"]),
          );
        },
      ),
    );
  }
}
