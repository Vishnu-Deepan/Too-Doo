import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_doo/database.dart';
import 'package:to_doo/dialog_box.dart';
import 'package:to_doo/todo_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //reference the hive box
  final _mybox = Hive.box('mybox');

  @override
  void initState() {

    //if its first ever
    if(_mybox.get("TODOLIST")==null){
      db.createInitialData();
    } else{
      db.loadData();
    }

    super.initState();
  }

  //text controller
  final _controller = TextEditingController();


// list of to do tasks
  ToDoDatabase db = ToDoDatabase();

  // save new task
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text,false]);
      _controller.clear();
    });
    Navigator.of(context).pop();

    db.updatedatabase();
  }


  // delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });

    db.updatedatabase();
  }

  //create new task
  void createNewTask(){
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller:_controller,
            onCancel:() => Navigator.of(context).pop(),
            onSave: () => saveNewTask(),

          );
        }
          );

  }

  //checkbox was tapped
  void checkBoxChanged(bool? value,int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1] ;
    });
    db.updatedatabase();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("TOO DOO"),
        backgroundColor: Colors.transparent,

      ),

      floatingActionButton: FloatingActionButton(
          child: Icon(
                Icons.add,
            ),
          backgroundColor: Colors.pink[700],
          onPressed: (){
            createNewTask();

          }
      ),

        body:  Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg2.jpg"),
              fit: BoxFit.cover,
            ),
          ),


        child: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (BuildContext context, int index) {
            return TodoTile(
                onChanged: (value)=> checkBoxChanged(value, index) ,
            taskCompleted: db.toDoList[index][1],
            taskName: (db.toDoList[index][0]),
              deleteFunction: (context) => deleteTask(index) ,
            );
          }
        ),
      ),

    );
  }
}
