// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:landing/core/theme/app_colors.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.pets, size: 100, color: AppColors.secondary),
//             const SizedBox(height: 20),
//             const Text(
//               'Bem-vindo ao PetStaff!',
//               style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//             ),
//             Image.asset(
//               'assets/images/logo_pet.png',
//               width: 120,
//               height: 120,
//               fit: BoxFit.contain,
//             ),
//             SvgPicture.asset('assets/images/game_kiss.svg'),
//             const SizedBox(height: 10),
//             const Text(
//               'Sua plataforma completa para gestão de pets',
//               style: TextStyle(fontSize: 16, color: AppColors.tertiary),
//             ),
//             const SizedBox(height: 40),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton.icon(
//                   onPressed: () => context.go('/about'),
//                   icon: const Icon(Icons.info_outline),
//                   label: const Text('Sobre'),
//                 ),
//                 ElevatedButton.icon(
//                   onPressed: () => context.go('/contact'),
//                   icon: const Icon(Icons.contact_mail),
//                   label: const Text('Contato'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:landing/core/app_strings.dart';
import 'package:landing/core/theme/app_colors.dart';
import 'package:landing/pages/main_page.dart';

// Assumo que você já tem AppColors.primary / AppColors.secondary definidos.
// Assumo também que MainPage.kCompactBreakpoint existe (static const double = 800).

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final isCompact = c.maxWidth < MainPage.kCompactBreakpoint;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeroSection(isCompact: isCompact),
              _SquaresSection(isCompact: isCompact),
              _FinalPrimarySection(isCompact: isCompact),
            ],
          ),
        );
      },
    );
  }
}

// =====================================================
// 1) HERO (container primary, full width, padding 50/20)
//    - Largo: logo à esquerda, título/descrição à direita (brancos)
//    - Compacto: logo em cima, título abaixo, descrição abaixo
// =====================================================
class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.isCompact});
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w700,
    );
    final descStyle = Theme.of(
      context,
    ).textTheme.bodyLarge?.copyWith(color: Colors.white.withOpacity(.95));

    return Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: EdgeInsets.symmetric(
        vertical: isCompact ? 20 : 50,
        horizontal: 20,
      ),
      child: isCompact
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppStrings.pathLogoPng,
                  height: 120,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 12),
                Text(
                  AppStrings.homePageTitle,
                  style: titleStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  AppStrings.homePageSubtitle,
                  style: descStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : Row(
              children: [
                // Esquerda: logo
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    AppStrings.pathLogoPng,
                    height: 140,
                    fit: BoxFit.contain,
                  ),
                ),
                // Direita: título em cima, descrição embaixo
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(AppStrings.homePageTitle, style: titleStyle),
                      const SizedBox(height: 8),
                      Text(
                        AppStrings.homePageSubtitle,
                        style: descStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

// =====================================================
// 2) PADDING(20) com 2 QUADRADOS flexíveis
//    - Esquerda: fundo preto, texto branco e 2 imagens abaixo do texto
//    - Direita: fundo branco, texto com AppColors.secondary
//    - < 800: empilha (preto em cima, branco embaixo)
// =====================================================
class _SquaresSection extends StatelessWidget {
  const _SquaresSection({required this.isCompact});
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final gap = isCompact
        ? const SizedBox(height: 16)
        : const SizedBox(width: 16);

    Widget blackSquare() {
      return AspectRatio(
        aspectRatio: 1,
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Texto do quadrado esquerdo',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  Image.asset(
                    'assets/logo_pet.png',
                    height: 64,
                    fit: BoxFit.contain,
                  ),
                  Image.asset(
                    'assets/app_phone.png',
                    height: 64,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget whiteSquare() {
      return AspectRatio(
        aspectRatio: 1,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              'Texto do quadrado direito',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.secondary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: isCompact
          ? Column(children: [blackSquare(), gap, whiteSquare()])
          : Row(
              children: [
                Expanded(child: blackSquare()),
                gap,
                Expanded(child: whiteSquare()),
              ],
            ),
    );
  }
}

// =====================================================
// 3) CONTAINER primary final
//    - Largo: Row centralizada com: [texto à esquerda] [app_phone] [logo_pet]
//    - < 800: empilha: texto (acima) → app_phone → logo_pet (abaixo)
//    - Tudo centralizado no container
// =====================================================
class _FinalPrimarySection extends StatelessWidget {
  const _FinalPrimarySection({required this.isCompact});
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.headlineSmall?.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w700,
    );

    return Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: EdgeInsets.symmetric(
        vertical: isCompact ? 24 : 40,
        horizontal: 16,
      ),
      child: isCompact
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Baixe o app agora',
                  style: titleStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Image.asset(
                  'assets/app_phone.png',
                  height: 160,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 12),
                Image.asset(
                  'assets/logo_pet.png',
                  height: 60,
                  fit: BoxFit.contain,
                ),
              ],
            )
          : Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center, // centraliza o grupo
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 360),
                  child: Text(
                    'Baixe o app agora',
                    style: titleStyle,
                    textAlign: TextAlign.left, // texto à esquerda
                  ),
                ),
                const SizedBox(width: 32),
                Image.asset(
                  'assets/app_phone.png',
                  height: 180,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 32),
                Image.asset(
                  'assets/logo_pet.png',
                  height: 72,
                  fit: BoxFit.contain,
                ),
              ],
            ),
    );
  }
}
