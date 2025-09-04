import 'package:flutter/material.dart';
import 'package:landing/widgets/navbar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key, required this.child, required this.currentPath});
  final Widget child;
  final String currentPath;

  static const double kCompactBreakpoint = 750;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final bool isCompact = c.maxWidth < kCompactBreakpoint;

        return Scaffold(
          appBar: NavBar(currentPath: currentPath, isCompact: isCompact),
          // Drawer só aparece no modo compacto (assim some o ícone de menu no modo largo)
          drawer: isCompact ? AppDrawer(currentPath: currentPath) : null,
          body: child,
        );
      },
    );
  }
}
