import 'package:az_health_care/shared/cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/helper_functions/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];

  List<Widget> screens = [
    // NewTaskScreen(),
    // DoneTaskScreen(),
    // ArchivedTaskScreen(),
  ];

  void changeNavBarIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print("Database created");
        database
            .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)',
            )
            .then((value) {
              print("table created");
            })
            .catchError((error) {
              print("Error When Creating Table ${error.toString()}");
            });
      },
      onOpen: (database) {
        print("Database Opened");
        getDataFromDatabase(database);
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    await database?.transaction((txn) async {
      txn
          .rawInsert(
            'INSERT INTO tasks (title, date,time,status) VALUES ("$title","$date","$time","new")',
          )
          .then((value) {
            print("$value Inserted Successfully");
            emit(AppInsertToDatabaseState());
            getDataFromDatabase(database);
          })
          .catchError((error) {
            print("Error When Inserting New Record ${error.toString()}");
          });
    });
  }

  void getDataFromDatabase(database) {
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      newTasks = [];
      doneTasks = [];
      archivedTasks = [];
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
        print(element['status']);
      });
      emit(AppGetDatabaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({required bool isShow, required IconData icon}) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  void updateData({required String status, required int id}) async {
    await database!
        .rawUpdate('UPDATE tasks SET status = ? WHERE id = ?', [status, id])
        .then((value) {
          getDataFromDatabase(database);
          emit(AppUpdateDatabaseState());
        });
  }

  void deleteData({required int id}) async {
    await database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((
      value,
    ) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeThemeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBool(key: 'isDark', value: isDark)
          .then((value) {
            emit(AppChangeThemeModeState());
          })
          .catchError((value) {
            print(value.toString());
          });
    }
  }
}
