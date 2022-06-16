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

  void _addTask(){
    const double val = 8.0;
    Size screenSize = MediaQuery.of(context).size;
    var h = screenSize.height;
    var maxItems = 10;
    double fontSizeVal = 20.0;
    
    setState(() {
      var index = widget.index++;
      widget.todoTasks.add(TodoTaskWidget(index: index, val: val, h: h, maxItems: maxItems, fontSizeVal: fontSizeVal, text : 'Grocery Shopping $index', color : Colors.lightBlue, removeTask: _removeTask));
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
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(mainAxisAlignment: MainAxisAlignment.start, 
          children: //[
                //TodoTaskWidget(val: val, h: h, maxItems: maxItems, fontSizeVal: fontSizeVal, text : 'Grocery Shopping', color : Colors.lightBlue),
                //TodoTaskWidget(val: val, h: h, maxItems: maxItems, fontSizeVal: fontSizeVal, text : 'Buy Gifts', color : Colors.lightGreen)
              //]
                widget.todoTasks
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class TodoTaskWidget extends StatefulWidget {
  TodoTaskWidget({
    Key? key,
    required this.index,
    required this.val,
    required this.h,
    required this.maxItems,
    required this.fontSizeVal,
    required this.text,
    required this.color,
    required this.removeTask,
  });

  final int index;
  final double val;
  final double h;
  final int maxItems;
  final double fontSizeVal;
  final String text;
  final Color color;
  final removeTask;
  IconData checkBoxType = Icons.check_box_outline_blank;

  @override
  State<TodoTaskWidget> createState() => _TodoTaskWidget();
}

class _TodoTaskWidget extends State<TodoTaskWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(widget.val*2),
      margin: EdgeInsets.all(widget.val),
      decoration: BoxDecoration(
        color: widget.color,
      ),
      constraints: BoxConstraints.expand(height: widget.h/widget.maxItems),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children : [
          Text(widget.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: widget.fontSizeVal
          ),
        ),
        ElevatedButton(onPressed: ()=> setState(() {
          widget.checkBoxType=(widget.checkBoxType==Icons.check_box_outline_blank)?Icons.check_box:Icons.check_box_outline_blank;
        }), 
        child: Icon(widget.checkBoxType)),
        ElevatedButton(onPressed: ()=> setState(() {
          //print('remove ${widget.index}');
          widget.removeTask(widget.index);
        }), child: const Icon(Icons.delete))
        ]
      )
    );
  }
}
