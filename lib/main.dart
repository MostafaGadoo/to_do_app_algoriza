import 'dart:ui';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/presentation/to_do/all_tasks/all_tasks_screen.dart';
import 'package:to_do_app/presentation/to_do/boarding/boarding_screen.dart';
import 'package:to_do_app/presentation/to_do/schedule_screen/schedule_screen.dart';
import 'package:to_do_app/services/notification_service/local_notification.dart';
import 'package:to_do_app/utils/bloc/cubit.dart';
import 'presentation/to_do/add_task/add_task_screen.dart';

void main() {
  // AwesomeNotifications()
  //     .initialize('resource://drawable-hdpi/ic_flutterNotification', [
  //   NotificationChannel(
  //     channelKey: 'basic_channel',
  //     channelName: 'Basic notifications',
  //     defaultColor: Colors.teal,
  //     importance: NotificationImportance.High,
  //     channelDescription: 'Notification description',
  //   ),
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..initDatabase(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 1.0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
            actionsIconTheme: IconThemeData(
              color: Colors.black,
              size: 24.0,
            ),
            toolbarTextStyle: TextStyle(
              color: Colors.black,
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
        ),
        home: const ToDoAppBoardingScreen(),
      ),
    );
  }
}
