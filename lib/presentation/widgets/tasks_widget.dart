import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/widgets/functions.dart';
import 'package:to_do_app/utils/bloc/cubit.dart';

class TasksWidget extends StatelessWidget {
  final  Map data;

  const TasksWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: true,
                onChanged: (bool? value) {
                  value = false;
                },
              ),
              Text(
                '${data['title']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const Spacer(),
              PopupMenuButton(
                  onSelected: (value) {
                    if(value == MenuItems.delete){
                      AppCubit.get(context).deleteFromDataBase(id: data['id']);
                    }else{
                      AppCubit.get(context).updateTaskStatus(
                        status: value.toString(),
                        id: data['id'],
                      );
                    }
                  },
                  itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: MenuItems.completed,
                          child: Text(
                            'Completed',
                          ),
                        ),
                        const PopupMenuItem(
                          value: MenuItems.unCompleted,
                          child: Text(
                            'UnCompleted',
                          ),
                        ),
                        const PopupMenuItem(
                          value: MenuItems.favorite,
                          child: Text(
                            'Favorites',
                          ),
                        ),
                        const PopupMenuItem(
                          value: MenuItems.delete,
                          child: Text(
                            'Delete',
                          ),
                        ),
                      ]),
            ],
          ),
        ],
      ),
    );
  }
}
