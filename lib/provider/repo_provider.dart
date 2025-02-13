import 'package:flutter/material.dart';
import '../models/repo.dart';
import '../services/api.dart';
import '../services/db.dart';

class RepositoryProvider extends ChangeNotifier {
  List<Repository> _repositories = [];
  bool _isLoading = false;
  String _loadingMessage = '';

  List<Repository> get repositories => _repositories;
  bool get isLoading => _isLoading;
  String get loadingMessage => _loadingMessage;

  Future<void> fetchAndStoreRepositories() async {
    _setLoadingState(true, 'Loading repos...');
    List<Repository> fetchedRepos = await ApiService.fetchRepositories();
    for (var repo in fetchedRepos) {
      await DatabaseService.insertRepository(repo);
    }
    await loadRepositories();
    _setLoadingState(false, '');
  }

  Future<void> loadRepositories() async {
    _repositories = await DatabaseService.getRepositories();
    notifyListeners();
  }

  Future<void> deleteRepository(int id) async {
    await DatabaseService.deleteRepository(id);
    await loadRepositories();
  }

  void _setLoadingState(bool isLoading, String message) {
    _isLoading = isLoading;
    _loadingMessage = message;
    notifyListeners();
  }
}
