import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/repo.dart';
import '../provider/repo_provider.dart';

class RepoTile extends StatelessWidget {
  final Repository repo;
  final bool isLoading; 

  const RepoTile({super.key, required this.repo, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final repoProvider =
        Provider.of<RepositoryProvider>(context, listen: false);

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: isLoading 
            ? const Center(
                child: Text(
                  "Getting repos...",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(repo.avatarUrl),
                        radius: 30,
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              repo.fullname,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                    
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => repoProvider.deleteRepository(repo.id),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(height: 10),
                  Text('Private: ${repo.private}'),
                  Text('Login: ${repo.login}'),
                  Text('Type: ${repo.type}'),
                  const SizedBox(height: 10),
                  Text(
                    'Description: ${repo.description ?? 'No description available'}',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ],
              ),
      ),
    );
  }
}
