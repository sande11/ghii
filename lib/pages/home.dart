import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/repo_provider.dart';
import '../utils/repo_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repoProvider = Provider.of<RepositoryProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          "GitHub Repositories",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[600],
      ),
      body: repoProvider.isLoading
          ? const Center(child: Text("Getting repos..."))
          : repoProvider.repositories.isEmpty
              ? const Center(child: Text("No repositories saved."))
              : ListView.builder(
                  itemCount: repoProvider.repositories.length,
                  itemBuilder: (context, index) {
                    return RepoTile(
                      repo: repoProvider.repositories[index],
                      isLoading: repoProvider.isLoading,
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[600],
        onPressed: () async {
          await repoProvider.fetchAndStoreRepositories();
        },
        child: const Icon(Icons.cloud_download, color: Colors.white),
      ),
    );
  }
}
