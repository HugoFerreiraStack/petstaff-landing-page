// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class ContactPage extends StatelessWidget {
//   const ContactPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Contato'),
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => context.go('/'),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Icon(
//               Icons.contact_mail,
//               size: 64,
//               color: Colors.blue,
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Entre em Contato',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Card(
//               child: Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(Icons.email, color: Colors.blue),
//                         SizedBox(width: 12),
//                         Text(
//                           'Email: contato@petstaff.com',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 12),
//                     Row(
//                       children: [
//                         Icon(Icons.phone, color: Colors.blue),
//                         SizedBox(width: 12),
//                         Text(
//                           'Telefone: (11) 99999-9999',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 12),
//                     Row(
//                       children: [
//                         Icon(Icons.location_on, color: Colors.blue),
//                         SizedBox(width: 12),
//                         Text(
//                           'Endereço: São Paulo, SP',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Horário de Atendimento:',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Text('Segunda a Sexta: 8h às 18h'),
//             const Text('Sábado: 8h às 12h'),
//             const Text('Domingo: Fechado'),
//             const SizedBox(height: 30),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () => context.go('/'),
//                 child: const Text('Voltar ao início'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:landing/widgets/float_action_button.dart';
import 'package:emailjs/emailjs.dart' as emailjs;

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  bool _notifiedLimit = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeEmailJS();
  }

  void _initializeEmailJS() {
    // Configuração global do EmailJS (opcional, mas recomendado)
    emailjs.init(const emailjs.Options(
      publicKey: 'msPJ93QWu5VsWtWai',
      // privateKey: 'YOUR_PRIVATE_KEY', // Adicione se tiver
    ));
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _subjectCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  bool _isValidEmail(String v) {
    final email = v.trim();
    // regex simples (boa o bastante p/ validação de formulário)
    final re = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]{2,}$");
    return re.hasMatch(email);
  }

  Future<void> _sendEmail() async {
    if (_isLoading) return;
    
    setState(() {
      _isLoading = true;
    });

    try {
      final email = _emailCtrl.text.trim();
      final subject = _subjectCtrl.text.trim();
      final description = _descCtrl.text.trim();

      // Dados do template do EmailJS - usando apenas parâmetros básicos
      final templateParams = {
        'from_name': email,
        'from_email': email,
        'subject': subject,
        'message': description,
      };

      log('Enviando email com parâmetros: $templateParams');
      log('Service ID: service_hg2cs4v');
      log('Template ID: template_s1ko309');

      // Enviar email usando EmailJS
      final result = await emailjs.send(
        'service_hg2cs4v', // Service ID
        'template_s1ko309', // Template ID
        templateParams,
        const emailjs.Options(
          publicKey: 'msPJ93QWu5VsWtWai',
          privateKey: 'EYeq-fV3nC5AIpcaOFdKw',
        ),
      );
      
      log('Resultado do envio: $result');

      if (mounted) {
        // Mostrar sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email enviado com sucesso!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );

        // Limpar formulário
        _emailCtrl.clear();
        _subjectCtrl.clear();
        _descCtrl.clear();
        _notifiedLimit = false;
      }
    } catch (e) {
      if (mounted) {
        log(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao enviar email: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onSubmit() {
    FocusScope.of(context).unfocus();
    final ok = _formKey.currentState?.validate() ?? false;
    
    if (ok) {
      _sendEmail();
    } else {
      showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Verifique os campos'),
          content: const Text(
            'Você precisa preencher corretamente todos os campos para continuar.',
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.of(dialogContext, rootNavigator: true).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: CustomFloatActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, c) {
            final isCompact = c.maxWidth < 768;
            final screenPad = isCompact ? 20.0 : 50.0;
            final maxWidth = isCompact ? c.maxWidth : 800.0;

            final baseFontSize =
                Theme.of(context).textTheme.bodyMedium?.fontSize ?? 16;
            final avgCharW = baseFontSize * 0.6;
            final innerFieldHPad = 32.0;
            final charsPerLine = ((maxWidth - innerFieldHPad) / avgCharW)
                .clamp(10, 2000)
                .floor();
            final neededLines = (1000 / charsPerLine).ceil();
            final descLines = neededLines.clamp(6, 24);

            final titleStyle = TextStyle(
              fontSize: isCompact ? 28 : 40,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            );
            const labelStyle = TextStyle(color: Colors.white);

            return SingleChildScrollView(
              padding: EdgeInsets.all(screenPad),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: DefaultTextStyle.merge(
                    style: const TextStyle(color: Colors.white),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                      Text('Entre em contato!', style: titleStyle),
                      const SizedBox(height: 8),
                      Text(
                        'Envie uma mensagem e entraremos em contato o mais breve',
                        style: TextStyle(
                          fontSize: isCompact ? 18 : 24,
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      const Divider(color: Colors.white24, thickness: 1),
                      const SizedBox(height: 24),

                      // EMAIL
                      const Text(
                        'Seu e-mail para entrarmos em contato',
                        style: labelStyle,
                      ),
                      const SizedBox(height: 8),
                      _Input(
                        controller: _emailCtrl,
                        hintText: 'voce@exemplo.com',
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Informe seu e-mail';
                          }
                          if (!_isValidEmail(v)) return 'E-mail inválido';
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // MOTIVO / ASSUNTO
                      const Text('Motivo do contato', style: labelStyle),
                      const SizedBox(height: 8),
                      _Input(
                        controller: _subjectCtrl,
                        hintText: 'Assunto do e-mail',
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Informe o motivo/assunto';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // DESCRIÇÃO (até 1000)
                      const Text('Descrição', style: labelStyle),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _descCtrl,
                        minLines: descLines,
                        maxLines: descLines,
                        maxLength: 1000,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        onChanged: (v) {
                          // mostra aviso quando atingir o limite (uma vez)
                          if (v.length >= 1000 && !_notifiedLimit) {
                            _notifiedLimit = true;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Você atingiu o limite de 1000 caracteres.',
                                ),
                              ),
                            );
                          }
                          if (v.length < 1000 && _notifiedLimit) {
                            _notifiedLimit = false;
                          }
                          setState(() {});
                        },
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Descreva sua necessidade';
                          }
                          if (v.length > 1000) {
                            return 'Máximo de 1000 caracteres';
                          }
                          return null;
                        },
                        decoration: _inputDecoration('Digite sua mensagem'),
                        style: const TextStyle(color: Colors.black),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${_descCtrl.text.length}/1000'
                          '${_descCtrl.text.length >= 1000 ? ' — limite atingido' : ''}',
                          style: TextStyle(
                            color: _descCtrl.text.length >= 1000
                                ? Colors.redAccent
                                : Colors.white70,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: FilledButton(
                          onPressed: _isLoading ? null : _onSubmit,
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : const Text('Enviar'),
                        ),
                      ),
                      const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(color: Colors.black54),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.white70, width: 1.4),
      ),
      errorMaxLines: 2,
      counterText: '', // escondo o counter padrão; usamos o nosso abaixo
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
}

class _Input extends StatelessWidget {
  const _Input({
    required this.controller,
    this.hintText,
    this.keyboardType,
    this.validator,
  });

  final TextEditingController controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(color: Colors.black54),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.white70, width: 1.4),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }
}
