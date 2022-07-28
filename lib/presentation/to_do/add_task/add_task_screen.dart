import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/presentation/widgets/defaultTextFormField.dart';
import 'package:to_do_app/presentation/widgets/default_button.dart';
import 'package:to_do_app/utils/bloc/cubit.dart';
import 'package:to_do_app/utils/bloc/states.dart';
import 'package:to_do_app/utils/styles/colors.dart';

class AddTaskScreen extends StatelessWidget {

  final TextEditingController? reminderController;

  const AddTaskScreen({
    Key? key,

    this.reminderController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
            ),
            title: const Text(
              'Add Task',
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Title',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  DefaultTextFormField(

                    keyboardType: TextInputType.text,
                    text: 'Meeting',
                    validate: 'please enter the task title',
                    controller: cubit.titleController,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  DefaultTextFormField(
                    suffixIcon: Icons.keyboard_arrow_down_outlined,
                    text: '21-07-2022',
                    controller: cubit.dateController,
                    keyboardType: TextInputType.none,
                    validate: 'Please chose the task date',
                    function: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.parse('2032-08-06'),
                      ).then((value) {
                        cubit.dateController.text = DateFormat('yyyy-MM-dd').format(value!);
                        debugPrint(cubit.dateController.text);
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Start Time',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 170,
                            child: DefaultTextFormField(
                              suffixIcon: Icons.timer_outlined,
                              text: '6:00',
                              controller: cubit.startTimeController,
                              keyboardType: TextInputType.none,
                              validate: 'Please choose the task start time',
                              function: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  cubit.startTimeController.text = value!.format(context).toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'End Time',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 170,
                            child: DefaultTextFormField(
                              suffixIcon: Icons.timer_outlined,
                              text: '8:00',
                              controller: cubit.endTimeController,
                              keyboardType: TextInputType.none,
                              validate: 'Please choose the task end time',
                              function: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  cubit.endTimeController.text = value!.format(context).toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Reminder',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  DropdownButton(
                    isExpanded: true,
                    hint: const Text(
                      '1 Day before',
                    ),
                    onChanged: (value){
                      debugPrint(value.toString());
                    },
                    items: const [
                      DropdownMenuItem(
                        value: "1 Day",
                        child: Text(
                        '1 day before',
                      ),
                      ),
                      DropdownMenuItem(
                        value: "1 Hour",
                        child: Text(
                        '1 Hour before',
                      ),
                      ),
                      DropdownMenuItem(
                        value: "30 minutes",
                        child: Text(
                        '30 minutes before',
                      ),
                      ),
                      DropdownMenuItem(
                        value: "10 minutes",
                        child: Text(
                        '1- minutes before',
                      ),
                      ),
                    ],
                  ),
                  // DefaultTextFormField(
                  //   validate: 'please set your reminder',
                  //   keyboardType: TextInputType.datetime,
                  //   controller: reminderController,
                  //   text: '10 minutes early',
                  //   suffixIcon: Icons.keyboard_arrow_down_sharp,
                  // ),
                  DefaultButton(
                    title: 'Create a Task',
                    function: (){
                      cubit.insetToDatabase();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
