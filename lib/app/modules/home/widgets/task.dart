import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/ui/todo_list_icons.dart';
import 'package:todo_list/app/models/task_model.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';

class Task extends StatelessWidget {
  final TaskModel model;
  final dateFormat = DateFormat('dd/MM/y');
  Task({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.grey),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: IntrinsicHeight(
        child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          leading: Checkbox(
            value: model.finished,
            onChanged: (value) =>
                context.read<HomeController>().checkOrUncheckTask(model),
          ),
          title: Text(
            model.description,
            style: TextStyle(
                decoration: model.finished ? TextDecoration.lineThrough : null),
          ),
          subtitle: Text(
            dateFormat.format(model.dateTime),
            style: TextStyle(
                decoration: model.finished ? TextDecoration.lineThrough : null),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(width: 1),
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: IconButton(
              onPressed: () => _deleteTask(context),
              icon: const Icon(
                TodoListIcons.trash,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _deleteTask(BuildContext context) {
    final controller = context.read<HomeController>();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Deseja deletar a tarefa?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                controller.deleteTask(model);
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }
}
