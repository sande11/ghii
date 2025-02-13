import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/repo_provider.dart';
import 'pages/home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RepositoryProvider()..loadRepositories(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
