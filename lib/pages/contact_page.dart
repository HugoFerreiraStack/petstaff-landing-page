import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contato'),
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
              Icons.contact_mail,
              size: 64,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            const Text(
              'Entre em Contato',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.email, color: Colors.blue),
                        SizedBox(width: 12),
                        Text(
                          'Email: contato@petstaff.com',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.phone, color: Colors.blue),
                        SizedBox(width: 12),
                        Text(
                          'Telefone: (11) 99999-9999',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.blue),
                        SizedBox(width: 12),
                        Text(
                          'Endereço: São Paulo, SP',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Horário de Atendimento:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text('Segunda a Sexta: 8h às 18h'),
            const Text('Sábado: 8h às 12h'),
            const Text('Domingo: Fechado'),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Voltar ao início'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
