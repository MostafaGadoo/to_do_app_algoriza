import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/presentation/widgets/tasks_widget.dart';
import 'package:to_do_app/utils/bloc/cubit.dart';
import 'package:to_do_app/utils/bloc/states.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state){},
      builder: (context, state){
        AppCubit cubit = AppCubit.get(context);
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context,index) => TasksWidget(data: cubit.todoCompletedTasks[index]),
          separatorBuilder: (context,index) => Container(
            height: 1,
            color: Colors.grey,
            width: double.infinity,
          ),
          itemCount: cubit.todoCompletedTasks.length,
        );
      },
    );
  }
}
