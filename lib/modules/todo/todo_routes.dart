import '../../shared/models/base_routes.dart';
import 'screens/containers/add_todo_screen_container.dart';
import 'screens/todos_screen.dart';

class TodoRoutes implements BaseRoutes {
  static final todos = '/todos';
  static final addTodo = '/addTodo';

  getRoutes() {
    return {
      todos: (context) => TodosScreen(),
      addTodo: (context) => AddTodoScreenContainer()
    };
  }
}
