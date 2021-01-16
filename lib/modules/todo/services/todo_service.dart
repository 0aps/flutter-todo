import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/todo.dart';

class TodoService {
  final FirebaseFirestore _firestore;
  static const String collectionName = 'todos';

  TodoService(this._firestore);

  Future<List<Todo>> loadTodos(userId) async {
    return _firestore
        .collection(collectionName)
        .where('userId', isEqualTo: userId)
        .orderBy('order')
        .get()
        .then(
          (qs) => qs.docs
              .map((doc) => Todo.fromJson(doc.data()).copy(id: doc.id))
              .toList(),
        );
  }

  Future<void> addTodo(Todo todo) {
    return _firestore.collection(collectionName).add(todo.toJson());
  }

  Future<void> updateTodo(Todo todo) {
    return _firestore
        .collection(collectionName)
        .doc(todo.id)
        .set(todo.toJson());
  }

  Future<void> removeTodo(Todo todo) {
    return _firestore.collection(collectionName).doc(todo.id).delete();
  }

  Future<void> updateTodos(List<Todo> todos) {
    WriteBatch batch = _firestore.batch();

    todos.forEach(
      (todo) {
        DocumentReference todoDoc =
            _firestore.collection(collectionName).doc(todo.id);
        batch.set(todoDoc, todo.toJson());
      },
    );

    return batch.commit();
  }

  Future<void> removeAllTodos(List<Todo> todos) {
    WriteBatch batch = _firestore.batch();

    todos.forEach(
      (todo) {
        DocumentReference todoDoc =
            _firestore.collection(collectionName).doc(todo.id);
        batch.delete(todoDoc);
      },
    );

    return batch.commit();
  }
}
