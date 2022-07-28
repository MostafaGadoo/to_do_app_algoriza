import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/presentation/widgets/scheduled_task_widget.dart';
import 'package:to_do_app/utils/bloc/cubit.dart';
import 'package:to_do_app/utils/bloc/states.dart';
import 'package:to_do_app/utils/styles/colors.dart';

class ScheduleScreen extends StatelessWidget {


  const ScheduleScreen({
    Key? key,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        // String? selectedDate;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
            ),
            title: const Text(
              'Schedule',
            ),
          ),
          body: Column(
            children: [
              HorizontalCalendar(
                date: DateTime.now(),
                initialDate: DateTime.now(),
                onDateSelected: (date) {
                  String selectedDate = date.toString();
                  // selectedDate =date.toString();
                  debugPrint(date.toString());
                  AppCubit.get(context)
                      .getScheduledTasks(date: date.toString());
                },
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[400],
                  height: 1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 10.0,
                      left: 10.0,
                      right: 10.0,
                    ),
                    child: Text(
                      'Tasks for the day',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => ScheduledTaskWidget(
                      scheduledTask: cubit.scheduledTasks[index]),
                  itemCount: cubit.scheduledTasks.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
