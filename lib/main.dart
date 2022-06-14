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
      title: 'TodoApp',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'TODO App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _addTask() {
    setState(() {
      _counter++;
    });
  }

  void _removeTask() {
    setState(() {
      _counter--;
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
    const double val = 8.0;
    Size screenSize = MediaQuery.of(context).size;
    var h = screenSize.height;
    var maxItems = 10;
    double fontSizeVal = 20.0;
    //var h = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(mainAxisAlignment: MainAxisAlignment.start, 
          children: <
              Widget>[
                TodoTaskWidget(val: val, h: h, maxItems: maxItems, fontSizeVal: fontSizeVal, text : 'Grocery Shopping', color : Colors.lightBlue),
                TodoTaskWidget(val: val, h: h, maxItems: maxItems, fontSizeVal: fontSizeVal, text : 'Buy Gifts', color : Colors.lightGreen)
              ])),
      /*floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),*/ // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class TodoTaskWidget extends StatelessWidget {
  const TodoTaskWidget({
    Key? key,
    required this.val,
    required this.h,
    required this.maxItems,
    required this.fontSizeVal,
    required this.text,
    required this.color,
  }) : super(key: key);

  final double val;
  final double h;
  final int maxItems;
  final double fontSizeVal;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(val*2),
      margin: EdgeInsets.all(val),
      decoration: BoxDecoration(
        color: color,
      ),
      constraints: BoxConstraints.expand(height: h/maxItems),
      child: Text(text,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSizeVal
        ),
      )
    );
  }
}
