import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o PetStaff'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.info,
              size: 64,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            const Text(
              'Sobre o PetStaff',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'O PetStaff é uma plataforma inovadora desenvolvida para facilitar a gestão e cuidado dos seus animais de estimação.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Nossos recursos incluem:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            const Text('• Agendamento de consultas veterinárias'),
            const Text('• Controle de vacinas e medicamentos'),
            const Text('• Histórico médico completo'),
            const Text('• Lembretes personalizados'),
            const Text('• Comunicação com veterinários'),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () => context.go('/contact'),
                child: const Text('Entre em contato'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
