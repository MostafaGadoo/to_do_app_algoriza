import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/presentation/to_do/add_task/add_task_screen.dart';
import 'package:to_do_app/presentation/to_do/schedule_screen/schedule_screen.dart';
import 'package:to_do_app/presentation/widgets/default_button.dart';
import 'package:to_do_app/utils/bloc/cubit.dart';
import 'package:to_do_app/utils/bloc/states.dart';

class ToDoAppBoardingScreen extends StatelessWidget {
  const ToDoAppBoardingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Board',
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    AppCubit.get(context).getScheduledTasks(date: DateTime.now().toString());
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>  const ScheduleScreen()));
                  },
                  icon: const Icon(
                    Icons.calendar_month,
                  ),
                ),
              ],
              bottom: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.black,
                onTap: (index) {
                  cubit.changeIndex(index);
                  // debugPrint(index.toString());
                },
                // controller: tabController,
                tabs: const [
                  Tab(
                    text: 'All',
                  ),
                  Tab(
                    text: 'Completed',
                  ),
                  Tab(
                    text: 'Uncompleted',
                  ),
                  Tab(
                    text: 'Favorites',
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ConditionalBuilder(
                      condition: true,
                      builder: (context) => cubit.screens[cubit.currentIndex],
                      fallback: (context) => const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  DefaultButton(
                    title: 'Add a Task',
                    function: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddTaskScreen(),));
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
