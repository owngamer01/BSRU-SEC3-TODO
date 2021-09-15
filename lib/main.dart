import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final nameController = TextEditingController();
  List<String> items = [];

  void addTodoItem() {
    setState(() {
      this.items.add(this.nameController.text);
      this.nameController.clear();
    });
  }

  void deleteTodoItem(int index) {
    setState(() {
      this.items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My App")
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          // color: Color(0xff3b5998),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: nameController,
                    )
                  ),
                  ElevatedButton(
                    onPressed: addTodoItem, 
                    child: Text("Add me")
                  )
                ]
              ),

              // List<String> => List<Widget>
              // List<String> => [null, null, null]
              // List<String> => [ItemBox, ItemBox, ItemBox]
              // Column(
              //   children: this.items.map((msg) => ItemBox(message: msg)).toList()
              // )
              
              ...this.items.asMap().map((index, msg) => 
                MapEntry(index, 
                  ItemBox(
                    message: msg, 
                    index: index,
                    onDelete: () {
                      this.deleteTodoItem(index);
                    },
                  )
                )
              ).values.toList()

            ]
          ),
        ),
      )
    );
  }
}

class ItemBox extends StatelessWidget {

  final String message;
  final int index;
  final void Function() onDelete;

  const ItemBox({ Key? key, 
    required this.message, 
    required this.index,
    required this.onDelete
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15
      ),
      margin: EdgeInsets.only(top: 5),
      color: Colors.orange,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(message),
          IconButton(
            iconSize: 20,
            constraints: BoxConstraints(
              maxHeight: 34,
              maxWidth: 34
            ),
            onPressed: onDelete, 
            icon: Icon(Icons.delete)
          )
        ],
      )
    );
  }
}
