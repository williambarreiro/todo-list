import 'package:todo_list/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list/app/models/task_filter_enum.dart';

class HomeController extends DefaultChangeNotifier {
  final filterSelected = TaskFilterEnum.today;
}
