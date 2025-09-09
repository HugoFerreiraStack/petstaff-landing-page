import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomFloatActionButton extends StatelessWidget {
  const CustomFloatActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _openWhatsApp,
      backgroundColor: Colors.transparent,
      child: Image.asset('assets/images/wppicon.png'),
    );
  }

  Future<void> _openWhatsApp() async {
    const phone = '5511999163774';
    final msg = Uri.encodeComponent('Olá estou vindo através do site');
    final uri = Uri.parse('https://wa.me/$phone?text=$msg');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    }
  }
}
