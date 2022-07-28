import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/presentation/widgets/tasks_widget.dart';
import 'package:to_do_app/utils/bloc/cubit.dart';
import 'package:to_do_app/utils/bloc/states.dart';

class UnCompletedTasksScreen extends StatelessWidget {
  const UnCompletedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state){},
      builder: (context, state){
        AppCubit cubit = AppCubit.get(context);
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context,index) => TasksWidget(data: cubit.todoUnCompletedTasks[index]),
          separatorBuilder: (context,index) => Container(
            height: 1,
            color: Colors.grey,
            width: double.infinity,
          ),
          itemCount: cubit.todoUnCompletedTasks.length,
        );
      },
    );
  }
}
