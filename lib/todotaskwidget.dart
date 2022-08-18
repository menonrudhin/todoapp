import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        ElevatedButton(
          onPressed: ()=> setState(() {
          //print('remove ${widget.index}');
          widget.removeTask(widget.index);
        }), child: const Icon(Icons.delete)),
        ElevatedButton(
              child : const Icon(Icons.edit),
              onPressed : () {
                openModal();
              },
          )
        ]
      )
    );
  }

  Future openModal() => showDialog(
            // context and builder are
            // required properties in this widget
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Enter Note')
            )
  );
}

