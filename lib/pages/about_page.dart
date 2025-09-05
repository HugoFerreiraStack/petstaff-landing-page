import 'package:flutter/material.dart';
import 'package:landing/core/app_strings.dart';
import 'package:landing/core/theme/app_colors.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final isCompact = c.maxWidth < 800;
        final hPad = isCompact ? 50.0 : 120.0;

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: c.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Topo preto com título (h=100)
                      Container(
                        height: 100,
                        color: Colors.black,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Políticas de Privacidade Pet Staff',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),

                      // Texto principal (padding 24v / 120h ou 50h)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: hPad,
                        ),
                        child: const _PrivacyText(),
                      ),

                      const Spacer(),

                      _Footer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        color: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Esquerda
            Expanded(
              child: Text(
                'CODIFYPRO',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Direita
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'PET STAFF',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Image.asset(
                  AppStrings.pathLogoPng,
                  height: 60,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PrivacyText extends StatelessWidget {
  const _PrivacyText();

  @override
  Widget build(BuildContext context) {
    // Todo conteúdo real da política
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Introdução', style: TextStyle(fontWeight: FontWeight.w700)),
        SizedBox(height: 8),
        Text(
          'Esta Política de Privacidade descreve como coletamos, usamos e protegemos seus dados no Pet Staff.',
        ),
        SizedBox(height: 16),
        Text('Coleta de Dados', style: TextStyle(fontWeight: FontWeight.w700)),
        SizedBox(height: 8),
        Text(
          'Podemos coletar informações fornecidas por você e dados técnicos de uso para melhorar nossos serviços.Podemos coletar informações fornecidas por você e dados técnicos de uso para melhorar nossos serviços.Podemos coletar informações fornecidas por você e dados técnicos de uso para melhorar nossos serviços.Podemos coletar informações fornecidas por você e dados técnicos de uso para melhorar nossos serviços.Podemos coletar informações fornecidas por você e dados técnicos de uso para melhorar nossos serviços.Podemos coletar informações fornecidas por você e dados técnicos de uso para melhorar nossos serviços.Podemos coletar informações fornecidas por você e dados técnicos de uso para melhorar nossos serviços.Podemos coletar informações fornecidas por você e dados técnicos de uso para melhorar nossos serviços.Podemos coletar informações fornecidas por você e dados técnicos de uso para melhorar nossos serviços.Podemos coletar informações fornecidas por você e dados técnicos de uso para melhorar nossos serviços.Podemos coletar informações fornecidas por você e dados técnicos de uso para melhorar nossos serviços.Podemos coletar informações fornecidas por você e dados técnicos de uso para melhorar nossos serviços.Podemos coletar informações fornecidas por você e dados técnicos de uso para melhorar nossos serviços.Podemos coletar informações fornecidas por você e dados técnicos de uso para melhorar nossos serviços.Podemos coletar informações fornecidas por você e dados técnicos de uso para melhorar nossos serviços.Podemos coletar informações fornecidas por você e dados técnicos de uso para melhorar nossos serviços.Podemos coletar informações fornecidas por você e dados técnicos de uso para melhorar nossos serviços.Podemos coletar informações fornecidas por você e dados técnicos de uso para melhorar nossos serviços.',
        ),
        SizedBox(height: 16),
        Text('Uso de Dados', style: TextStyle(fontWeight: FontWeight.w700)),
        SizedBox(height: 8),
        Text(
          'Usamos os dados para operação do aplicativo, suporte ao cliente e melhorias de produto.',
        ),
        SizedBox(height: 16),
        Text('Seus Direitos', style: TextStyle(fontWeight: FontWeight.w700)),
        SizedBox(height: 8),

        SizedBox(height: 16),
        Text('Contato', style: TextStyle(fontWeight: FontWeight.w700)),
        SizedBox(height: 8),
        Text('Em caso de dúvidas, entre em contato com nosso suporte.'),
        SizedBox(height: 24),
      ],
    );
  }
}
