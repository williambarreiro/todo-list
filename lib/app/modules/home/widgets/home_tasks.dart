import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';
import 'package:todo_list/app/models/task_model.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';
import 'package:todo_list/app/modules/home/widgets/task.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final tasksList = context.select<HomeController, List<TaskModel>>(
        (controller) => controller.filteredTasks);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Selector<HomeController, String>(
            selector: (context, controller) {
              return controller.filterSelected.description;
            },
            builder: (context, value, child) {
              return Text(
                'TASKS $value',
                style: context.titleStyle,
              );
            },
          ),
          Visibility(
            visible: tasksList.isNotEmpty,
            replacement: Expanded(
              child: Center(
                child: Text(
                  'Sem tasks',
                  style: context.titleStyle,
                ),
              ),
            ),
            child: Column(
              children: tasksList.map((t) => Task(model: t)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
