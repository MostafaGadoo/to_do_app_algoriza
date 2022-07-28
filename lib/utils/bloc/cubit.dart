import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/presentation/to_do/all_tasks/all_tasks_screen.dart';
import 'package:to_do_app/presentation/to_do/completed_tasks/completed_tasks_screen.dart';
import 'package:to_do_app/presentation/to_do/favorites_tasks/favorites_tasks_screen.dart';
import 'package:to_do_app/presentation/to_do/uncompleted_tasks/uncompleted_tasks_screen.dart';
import 'package:to_do_app/utils/bloc/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppInitialState());
  }

  List<Widget> screens = [
    const AllTasksScreen(),
    const CompletedTasksScreen(),
    const UnCompletedTasksScreen(),
    const FavoritesTasksScreen(),
  ];

  // List<dynamic> reminderItems =[
  //
  //     const DropdownMenuItem(
  //       value: "1 Day",
  //       child: Text(
  //         '1 day before',
  //       ),
  //     ),
  //     const DropdownMenuItem(
  //       value: "1 Hour",
  //       child: Text(
  //         '1 Hour before',
  //       ),
  //     ),
  //     const DropdownMenuItem(
  //       value: "30 minutes",
  //       child: Text(
  //         '30 minutes before',
  //       ),
  //     ),
  //     const DropdownMenuItem(
  //       value: "10 minutes",
  //       child: Text(
  //         '1- minutes before',
  //       ),
  //     ),
  //
  // ];

  late Database database;

  void initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'ToDo.db');
    debugPrint('AppDataBaseInitialized');
    openAppDatabase(
      path: path,
    );
    emit(AppDataBaseInitialState());
  }

  void openAppDatabase({
    required String path,
  }) async {
    await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, startTime TEXT, endTime TEXT, status TEXT)');
      debugPrint('Table created');
    }, onOpen: (Database db) {
      debugPrint('Data base opened');
      database = db;
      getToDoData();
    });
  }

  /*
  final TextEditingController? titleController;
  final TextEditingController? dateController;
  final TextEditingController? startTimeController;
  final TextEditingController? endTimeController;
  final TextEditingController? reminderController;
  */

  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  void insetToDatabase() async {
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO tasks(title,date,startTime,endTime,status) VALUES("${titleController.text}","${dateController.text}","${startTimeController.text}","${endTimeController.text}","All")');
    }).then((value) {
      debugPrint('Data inserted');
      titleController.clear();
      dateController.clear();
      startTimeController.clear();
      endTimeController.clear();
      getToDoData();
      emit(AppDataBaseUserCreatedState());
    });
  }

  List<Map<dynamic,dynamic>> todoAllTasks = [];
  List<Map<dynamic,dynamic>> todoCompletedTasks = [];
  List<Map<dynamic,dynamic>> todoUnCompletedTasks = [];
  List<Map<dynamic,dynamic>> todoFavoritesTasks = [];

  void getToDoData() async {
    todoAllTasks = [];
    todoCompletedTasks = [];
    todoUnCompletedTasks = [];
    todoFavoritesTasks = [];
    emit(AppDataBaseLoadingState());
    await database.rawQuery('SELECT * FROM tasks').then((value) {
      todoAllTasks = value;
      value.forEach((element) {
        if(element['status'] == 'MenuItems.completed'){
          todoCompletedTasks.add(element);
        }else if(element['status']== 'MenuItems.unCompleted'){
          todoUnCompletedTasks.add(element);
        }else if(element['status'] == 'MenuItems.favorite'){
          todoFavoritesTasks.add(element);
        }
      });
      debugPrint('database data Fetched');
      debugPrint(todoAllTasks.toString());
      debugPrint(todoCompletedTasks.toString());
      debugPrint(todoUnCompletedTasks.toString());
      debugPrint(todoFavoritesTasks.toString());

      emit(AppDatabaseToDo());
    });
  }

  void updateTaskStatus({
  required String status,
  required int id,
})async{
     await database.rawUpdate(
        'UPDATE tasks SET status = ?WHERE id = ?',
        [status, id]).then((value) {
          getToDoData();
          emit(TaskStatusUpdate());
     });
  }

  void deleteFromDataBase({
  required int id,
})async{
    await database
        .rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
          getToDoData();
          emit(ToDoTaskDeletedState());
    });
  }


  List<Map<dynamic,dynamic>> scheduledTasks = [];
  void getScheduledTasks({
  required String date,
}) async{
    scheduledTasks = [];
    emit(AppDataBaseLoadingState());
     await database.rawQuery('SELECT * FROM Tasks WHERE date = ?', [date])
         .then((value) {
           scheduledTasks = value;
           debugPrint(scheduledTasks.toString());
           emit(ScheduledTasksState());
     });
  }
}
