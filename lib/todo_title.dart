import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class TodoTile extends StatelessWidget {

  late final String taskName;
  late final bool taskCompleted;
  Function(bool?)? onChanged;

  Function(BuildContext)? deleteFunction;

  TodoTile({
    super.key,
    required this.onChanged,
    required this.taskCompleted,
    required this.taskName,
    required this.deleteFunction
  });




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(),
            children:[SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(12),


            ),]
        ),
        child: Container(
          padding: EdgeInsets.all(25),
          child: Row(
            children: [
             Checkbox(value: taskCompleted,onChanged:onChanged,activeColor: Colors.pink[700],),
              Text(
                  taskName,
                  style: TextStyle(
                    color: Colors.white,
                    decoration:(taskCompleted? TextDecoration.lineThrough :TextDecoration.none ),
                  ),
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.black54,

              borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
