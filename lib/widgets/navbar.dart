import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:landing/core/theme/app_colors.dart';

/// Modelo dos itens do menu
class NavItem {
  final String label;
  final String name;
  final String path;
  // final IconData icon;
  const NavItem({
    required this.label,
    required this.name,
    required this.path,
    // required this.icon,
  });
}

const navItems = <NavItem>[
  NavItem(
    label: 'Início',
    name: 'home',
    path: '/',
    //  icon: Icons.home,
  ),
  NavItem(
    label: 'Entre em Contato',
    name: 'contact',
    path: '/contact',
    // icon: Icons.info_outline,
  ),
  NavItem(
    label: 'Políticas de Privacidade',
    name: 'about',
    path: '/about',
    // icon: Icons.alternate_email,
  ),
];

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({
    super.key,
    required this.currentPath,
    required this.isCompact,
    this.height = kToolbarHeight,
  });

  final String currentPath;
  final bool isCompact;
  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);

  bool _isSelected(String loc, String path) {
    if (path == '/') return loc == '/';
    return loc == path || loc.startsWith('$path/');
  }

  Widget _buildButton(BuildContext context, NavItem item) {
    final selected = _isSelected(currentPath, item.path);
    final label = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          item.label,
          style: TextStyle(
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            color: selected ? AppColors.primary : Colors.black87,
          ),
        ),
      ],
    );
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: selected
            ? TextButton(onPressed: () {}, child: label)
            : TextButton(
                onPressed: () => context.goNamed(item.name),
                child: label,
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: theme.colorScheme.surface,
      surfaceTintColor: Colors.transparent,

      // ——— MODO COMPACTO: ícone de menu + Drawer (sem centralização de itens aqui)
      automaticallyImplyLeading: isCompact, // mostra o menu quando há Drawer
      title: isCompact
          ? const SizedBox.shrink()
          // ——— MODO LARGO: itens centralizados dentro do title
          : Row(
              mainAxisSize: MainAxisSize.min, // deixa a linha justa
              mainAxisAlignment: MainAxisAlignment.spaceAround, // centraliza
              children: [for (final n in navItems) _buildButton(context, n)],
            ),
      centerTitle: true,

      // Muito importante: não use actions no modo largo, para não "puxar" o centro.
      actions: isCompact ? null : const <Widget>[],
      // (opcional) garanta que não apareça leading no modo largo:
      leading: isCompact ? null : const SizedBox.shrink(),
    );
  }
}

// DRAWER: aparece no modo compacto e lista as rotas
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.currentPath});
  final String currentPath;

  bool _isSelected(String loc, String path) {
    if (path == '/') return loc == '/';
    return loc == path || loc.startsWith('$path/');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Menu',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            const Divider(height: 1),
            for (final n in navItems)
              ListTile(
                title: Text(n.label),
                selected: _isSelected(currentPath, n.path),
                onTap: () {
                  Navigator.of(context).pop();
                  context.goNamed(n.name);
                },
              ),
          ],
        ),
      ),
    );
  }
}
