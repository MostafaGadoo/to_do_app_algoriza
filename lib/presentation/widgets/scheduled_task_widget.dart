import 'package:flutter/material.dart';
import 'package:to_do_app/utils/bloc/cubit.dart';
import 'package:to_do_app/utils/styles/colors.dart';

class ScheduledTaskWidget extends StatelessWidget {
  final Map scheduledTask;

  const ScheduledTaskWidget({
    Key? key,
    required this.scheduledTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.teal,
              ),
              height: 80.0,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            '${scheduledTask['startTime']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 21.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          child: Text(
                            '${scheduledTask['title']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      AppCubit.get(context).updateTaskStatus(
                        status: 'MenuItems.completed',
                        id: scheduledTask['id'],
                      );
                    },
                    icon: const Icon(
                      Icons.check_circle_outline,
                      color:Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
