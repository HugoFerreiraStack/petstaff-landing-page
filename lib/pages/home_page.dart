import 'package:flutter/material.dart';
import 'package:landing/core/app_strings.dart';
import 'package:landing/core/theme/app_colors.dart';
import 'package:landing/pages/main_page.dart';

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

class _SquaresSection extends StatefulWidget {
  const _SquaresSection({required this.isCompact});
  final bool isCompact;

  @override
  State<_SquaresSection> createState() => _SquaresSectionState();
}

class _SquaresSectionState extends State<_SquaresSection> {
  final GlobalKey _whiteKey = GlobalKey();
  final GlobalKey _blackKey = GlobalKey();

  double? _whiteMeasuredH;
  double? _blackMeasuredH;
  double? _lastCardWidth;
  bool? _lastCompact;

  static const double _gap = 16;

  void _scheduleMeasure() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final hW = _whiteKey.currentContext?.size?.height;
      final hB = _blackKey.currentContext?.size?.height;

      if (hW != null && hW != _whiteMeasuredH) {
        setState(() => _whiteMeasuredH = hW);
      }
      if (hB != null && hB != _blackMeasuredH) {
        setState(() => _blackMeasuredH = hB);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: LayoutBuilder(
        builder: (context, c) {
          final bool isCompact = widget.isCompact;

          final double sectionPad = isCompact ? 0 : 0;
          final double innerPad = isCompact ? 30 : 80;

          final double innerWidth = (c.maxWidth - sectionPad * 2).clamp(
            0,
            double.infinity,
          );

          final double cardWidth = isCompact
              ? innerWidth
              : (innerWidth - _gap) / 2;

          if (_lastCardWidth != cardWidth || _lastCompact != isCompact) {
            _lastCardWidth = cardWidth;
            _lastCompact = isCompact;
            _whiteMeasuredH = null;
            _blackMeasuredH = null;
          }

          final double? fixedHeight =
              (_whiteMeasuredH != null || _blackMeasuredH != null)
              ? [
                  (_whiteMeasuredH ?? 0),
                  (_blackMeasuredH ?? 0),
                ].reduce((a, b) => a > b ? a : b)
              : null;

          _scheduleMeasure();

          Widget blackCard({Key? key}) {
            final content = Container(
              key: key,
              width: cardWidth, // width priorizado
              padding: EdgeInsets.all(innerPad),
              color: Colors.black,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.homePageBlackSquare,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Image.asset(
                    AppStrings.pathGooglePlay,
                    height: 46,
                    fit: BoxFit.contain,
                  ),
                  Image.asset(
                    AppStrings.pathAppStore,
                    height: 64,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            );

            // Se já temos a altura medida, travamos a mesma para os dois
            return fixedHeight == null
                ? content
                : SizedBox(
                    width: cardWidth,
                    height: fixedHeight,
                    child: content,
                  );
          }

          Widget whiteCard({Key? key}) {
            final content = Container(
              key: key,
              width: cardWidth, // width priorizado
              padding: EdgeInsets.all(innerPad),
              color: Colors.white,
              child: Center(
                child: Text(
                  AppStrings.homePageWhiteSquare,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );

            return fixedHeight == null
                ? content
                : SizedBox(
                    width: cardWidth,
                    height: fixedHeight,
                    child: content,
                  );
          }

          // Layout final com padding externo
          return Padding(
            padding: EdgeInsets.all(sectionPad),
            child: isCompact
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // preto em cima
                      blackCard(key: _blackKey),
                      const SizedBox(height: _gap),
                      // branco embaixo
                      whiteCard(key: _whiteKey),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      blackCard(key: _blackKey),
                      const SizedBox(width: _gap),
                      whiteCard(key: _whiteKey),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

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
                  AppStrings.homePageLTCarousel1,
                  style: titleStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 400),
                  child: Image.asset(
                    AppStrings.homePageImageCarousel1,
                    height: 160,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 24),
                Column(
                  children: [
                    Image.asset(
                      AppStrings.pathLogoPng,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 6),
                    Text(
                      AppStrings.appName.toUpperCase(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        AppStrings.homePageLTCarousel1,
                        style: titleStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 400),
                        child: Image.asset(
                          AppStrings.homePageImageCarousel1,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Image.asset(
                            AppStrings.pathLogoPng,
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 6),
                          Text(
                            AppStrings.appName.toUpperCase(),
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
