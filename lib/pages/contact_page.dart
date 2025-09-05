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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:landing/widgets/float_action_button.dart';

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

  void _onSubmit() {
    // TODO HUGO ENVIAR EMAIL
    FocusScope.of(context).unfocus();
    final ok = _formKey.currentState?.validate() ?? false;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(ok ? 'Tudo certo!' : 'Verifique os campos'),
        content: Text(
          ok
              ? 'Validação ok. (Envio de e-mail desativado por enquanto.)'
              : 'Você precisa preencher corretamente todos os campos para continuar.',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: CustomFloatActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, c) {
            const screenPad = 50.0;
            final maxW = c.maxWidth;
            final formWidth = maxW - screenPad * 2;

            final baseFontSize =
                Theme.of(context).textTheme.bodyMedium?.fontSize ?? 16;
            final avgCharW = baseFontSize * 0.6;
            final innerFieldHPad = 32.0;
            final charsPerLine = ((formWidth - innerFieldHPad) / avgCharW)
                .clamp(10, 2000)
                .floor();
            final neededLines = (1000 / charsPerLine).ceil();
            final descLines = neededLines.clamp(6, 24);

            final titleStyle = const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            );
            const labelStyle = TextStyle(color: Colors.white);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(screenPad),
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
                          fontSize: 30,
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                        ),
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 500),
                          child: _Input(
                            controller: _emailCtrl,
                            hintText: 'voce@exemplo.com',
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) {
                              if (v == null || v.trim().isEmpty)
                                return 'Informe seu e-mail';
                              if (!_isValidEmail(v)) return 'E-mail inválido';
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // MOTIVO / ASSUNTO
                      const Text('Motivo do contato', style: labelStyle),
                      const SizedBox(height: 8),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 500),
                          child: _Input(
                            controller: _subjectCtrl,
                            hintText: 'Assunto do e-mail',
                            validator: (v) {
                              if (v == null || v.trim().isEmpty)
                                return 'Informe o motivo/assunto';
                              return null;
                            },
                          ),
                        ),
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
                          if (v == null || v.trim().isEmpty)
                            return 'Descreva sua necessidade';
                          if (v.length > 1000)
                            return 'Máximo de 1000 caracteres';
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

                      Align(
                        alignment: Alignment.center,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 400),
                          child: SizedBox(
                            width: double.infinity, // ocupa até o limite (200)
                            height: 50,
                            child: FilledButton(
                              onPressed: _onSubmit,
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                              ),
                              child: const Text('Enviar'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
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
