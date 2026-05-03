import 'package:flutter/material.dart';
import '../../../services/firestore_service.dart';
import 'task_model.dart';

class TaskProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  final String _collectionPath = 'tasks';

  List<TaskModel> _tasks = [];
  bool _isLoading = false;

  List<TaskModel> get tasks => _tasks;
  bool get isLoading => _isLoading;

  int get totalTasks => _tasks.length;
  int get completedTasks => _tasks.where((t) => t.isCompleted).length;
  int get pendingTasks => _tasks.where((t) => !t.isCompleted).length;
  double get completionRate =>
      totalTasks == 0 ? 0 : completedTasks / totalTasks;

  void fetchTasks(String userId) {
    _firestoreService
        .streamCollection<TaskModel>(
          path: 'users/$userId/$_collectionPath',
          builder: (data, id) => TaskModel.fromMap(data, id),
          queryBuilder: (query) => query.orderBy('createdAt', descending: true),
        )
        .listen((tasks) {
          _tasks = tasks;
          notifyListeners();
        });
  }

  Future<void> addTask(String userId, String title, String description) async {
    try {
      debugPrint('Đang chuẩn bị thêm task cho user: $userId');
      final task = TaskModel(
        id: '',
        title: title,
        description: description,
        createdAt: DateTime.now(),
      );

      final data = task.toMap();
      debugPrint('Dữ liệu gửi lên Firestore: $data');

      await _firestoreService.addData(
        path: 'users/$userId/$_collectionPath',
        data: data,
      );
      debugPrint('Thêm task thành công!');
    } catch (e) {
      debugPrint('Lỗi tại TaskProvider.addTask: $e');
      rethrow;
    }
  }

  Future<void> updateTask(String userId, TaskModel task) async {
    await _firestoreService.setData(
      path: 'users/$userId/$_collectionPath/${task.id}',
      data: task.toMap(),
      merge: true,
    );
  }

  Future<void> deleteTask(String userId, String taskId) async {
    await _firestoreService.deleteData(
      path: 'users/$userId/$_collectionPath/$taskId',
    );
  }

  Future<void> toggleTaskStatus(String userId, TaskModel task) async {
    await updateTask(userId, task.copyWith(isCompleted: !task.isCompleted));
  }
}
