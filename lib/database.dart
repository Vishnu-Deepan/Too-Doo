import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase{

  //reference the box
  final _mybox = Hive.box('mybox');

  List toDoList=[];

  //first ever opening app
  void createInitialData(){
    toDoList=[
      ["Add Tasks",false],
      ["Swipe to Delete",true],
    ];
  }

  //load data from database
  void loadData(){
    toDoList = _mybox.get("TODOLIST");
  }

  //uodate data from database
  void updatedatabase(){
    _mybox.put("TODOLIST", toDoList);
  }

}