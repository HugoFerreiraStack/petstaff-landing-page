import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:landing/widgets/float_action_button.dart';
import 'package:emailjs/emailjs.dart' as emailjs;

class ProfessionalRegistrationPage extends StatefulWidget {
  const ProfessionalRegistrationPage({super.key});

  @override
  State<ProfessionalRegistrationPage> createState() => _ProfessionalRegistrationPageState();
}

class _ProfessionalRegistrationPageState extends State<ProfessionalRegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  bool _isLoading = false;
  String? _selectedCategory;

  // Categorias de profissionais
  final List<Map<String, String>> _categories = [
    {'value': 'veterinario', 'label': 'Veterinário'},
    {'value': 'pet_groomer', 'label': 'Pet Groomer'},
    {'value': 'adestrador', 'label': 'Adestrador'},
    {'value': 'pet_sitter', 'label': 'Pet Sitter'},
    {'value': 'hotel_pet', 'label': 'Hotel Pet'},
    {'value': 'dog_walker', 'label': 'Dog Walker'},
  ];

  @override
  void initState() {
    super.initState();
    _initializeEmailJS();
  }

  void _initializeEmailJS() {
    // Configuração global do EmailJS
    emailjs.init(const emailjs.Options(
      publicKey: 'msPJ93QWu5VsWtWai',
      privateKey: 'EYeq-fV3nC5AIpcaOFdKw',
    ));
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  bool _isValidEmail(String v) {
    final email = v.trim();
    final re = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]{2,}$");
    return re.hasMatch(email);
  }

  bool _isValidPhone(String v) {
    final phone = v.trim();
    // Remove todos os caracteres não numéricos
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');
    // Verifica se tem pelo menos 10 dígitos
    return cleanPhone.length >= 10;
  }

  Future<void> _sendRegistrationRequest() async {
    if (_isLoading) return;
    
    setState(() {
      _isLoading = true;
    });

    try {
      final firstName = _firstNameCtrl.text.trim();
      final lastName = _lastNameCtrl.text.trim();
      final email = _emailCtrl.text.trim();
      final phone = _phoneCtrl.text.trim();
      final category = _selectedCategory ?? '';

      // Encontrar o label da categoria
      final categoryLabel = _categories
          .firstWhere((cat) => cat['value'] == category, orElse: () => {'label': 'Não especificado'})['label'];

      // Dados do template do EmailJS
      final templateParams = {
        'from_name': '$firstName $lastName',
        'from_email': email,
        'subject': 'Solicitação de Cadastro - $categoryLabel',
        'message': '''
Nova solicitação de cadastro de profissional:

Nome: $firstName $lastName
Email: $email
Telefone: $phone
Categoria: $categoryLabel

Solicitação enviada através do app PetStaff.
        ''',
      };

      log('Enviando solicitação de cadastro: $templateParams');

      // Enviar email usando EmailJS
      final result = await emailjs.send(
        'service_hg2cs4v',
        'template_s1ko309',
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
            content: Text('Solicitação enviada com sucesso! Entraremos em contato em breve.'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 4),
          ),
        );

        // Limpar formulário
        _firstNameCtrl.clear();
        _lastNameCtrl.clear();
        _emailCtrl.clear();
        _phoneCtrl.clear();
        _selectedCategory = null;
        setState(() {});
      }
    } catch (e) {
      log('Erro ao enviar solicitação: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao enviar solicitação: $e'),
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
    
    if (ok && _selectedCategory != null) {
      _sendRegistrationRequest();
    } else if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, selecione uma categoria de profissional'),
          backgroundColor: Colors.orange,
        ),
      );
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
      floatingActionButton: const CustomFloatActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, c) {
            final isCompact = c.maxWidth < 768;
            final screenPad = isCompact ? 20.0 : 50.0;
            final maxWidth = isCompact ? c.maxWidth : 800.0;

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
                      Text('Seja um Profissional PetStaff!', style: titleStyle),
                      const SizedBox(height: 8),
                      Text(
                        'Preencha o formulário e entraremos em contato para validar seu cadastro',
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

                      // NOME
                      const Text('Nome', style: labelStyle),
                      const SizedBox(height: 8),
                      _Input(
                        controller: _firstNameCtrl,
                        hintText: 'Seu nome',
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Informe seu nome';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // SOBRENOME
                      const Text('Sobrenome', style: labelStyle),
                      const SizedBox(height: 8),
                      _Input(
                        controller: _lastNameCtrl,
                        hintText: 'Seu sobrenome',
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Informe seu sobrenome';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // EMAIL
                      const Text('E-mail', style: labelStyle),
                      const SizedBox(height: 8),
                      _Input(
                        controller: _emailCtrl,
                        hintText: 'seu@email.com',
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

                      // TELEFONE
                      const Text('Telefone', style: labelStyle),
                      const SizedBox(height: 8),
                      _Input(
                        controller: _phoneCtrl,
                        hintText: '(11) 99999-9999',
                        keyboardType: TextInputType.phone,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Informe seu telefone';
                          }
                          if (!_isValidPhone(v)) return 'Telefone inválido';
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // CATEGORIA
                      const Text('Tipo de Profissional', style: labelStyle),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          decoration: const InputDecoration(
                            hintText: 'Selecione sua categoria',
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          ),
                          dropdownColor: Colors.white,
                          style: const TextStyle(color: Colors.black),
                          items: _categories.map((category) {
                            return DropdownMenuItem<String>(
                              value: category['value'],
                              child: Text(category['label']!),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Selecione uma categoria';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 30),

                      // BOTÃO ENVIAR
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
                              : const Text('Enviar Solicitação'),
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
