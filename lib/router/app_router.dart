import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/home/presentation/pages/home_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      // Pin detail — to be implemented in Day 2
      GoRoute(
        path: '/pin/:id',
        name: 'pinDetail',
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Pin Detail')),
          body: const Center(child: Text('Coming in Day 2')),
        ),
      ),
    ],
  );
}
