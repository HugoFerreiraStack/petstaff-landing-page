import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:landing/pages/main_page.dart';
import '../pages/home_page.dart';
import '../pages/about_page.dart';
import '../pages/contact_page.dart';
import '../pages/professional_registration_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) =>
          MainPage(currentPath: state.matchedLocation, child: child),
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/contact',
          name: 'contact',
          builder: (context, state) => const ContactPage(),
        ),
        GoRoute(
          path: '/professional-registration',
          name: 'professional-registration',
          builder: (context, state) => const ProfessionalRegistrationPage(),
        ),
        GoRoute(
          path: '/privacy',
          name: 'privacy',
          builder: (context, state) => const PrivacyPage(),
        ),
      ],
    ),
  ],

  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Página não encontrada')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Página não encontrada: ${state.uri}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('Voltar ao início'),
          ),
        ],
      ),
    ),
  ),
);
