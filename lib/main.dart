import 'dart:developer';

import 'package:flutter/material.dart';
import 'todotaskwidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoApp',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'TODO App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  List<TodoTaskWidget> todoTasks = <TodoTaskWidget>[];
  int index = 0;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var colors = [Colors.lightBlue, Colors.deepOrange, Colors.purpleAccent, Colors.green];
  late TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  void _removeTask(int index){
    //print('remove task $index');
    int i = 0;
    for (var element in widget.todoTasks) {
      //print('element in list : ${element.index}');
      if(element.index==index) {
        break;
      }
      ++i;
    }
    //print("index  = $i");
    setState(() {
      widget.todoTasks.removeAt(i);  
    });    
  }

  void submit(){
      Navigator.of(context).pop(controller.text);
  }

  _addTask() async {
    controller.clear();
    const double val = 8.0;
    Size screenSize = MediaQuery.of(context).size;
    var h = screenSize.height;
    var maxItems = 10;
    double fontSizeVal = 20.0;
    
    final text = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter text'),
        content: TextField(
          autofocus: true,
          controller : controller,      
      ),
      actions: [
        TextButton(          
          onPressed: submit,
          child: const Text("Submit")
          )
      ]
      ,
    ));

    log('Text input = $text');

    setState(() {
      var index = widget.index++;
      widget.todoTasks.add(TodoTaskWidget(index: index, val: val, h: h, maxItems: maxItems, fontSizeVal: fontSizeVal, text : text.toString(), color : colors[index%4], removeTask: _removeTask));
    });

    
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    
    //var h = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Scrollbar(
        // scroll through the todo tasks
            child : ListView.builder(
                itemCount: widget.todoTasks.length,
                itemBuilder: (c, i) => widget.todoTasks.elementAt(i)
            ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


