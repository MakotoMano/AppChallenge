// lib/pages/inova_plus_page.dart

import 'package:flutter/material.dart';
import '../widgets/background_scaffold.dart';
import '../widgets/animated_logo_image.dart';
import '../widgets/touch_animated_button.dart';

class InovaPlusPage extends StatelessWidget {
  const InovaPlusPage({Key? key}) : super(key: key);

  void _onTapNav(BuildContext context, int idx) {
    switch (idx) {
      case 0:
        // Ideias (home)
        Navigator.of(context).pushReplacementNamed('/home');
        break;
      case 1:
        // QR code
        Navigator.of(context).pushReplacementNamed('/qr');
        break;
      case 2:
        // Pontuação
        Navigator.of(context).pushReplacementNamed('/points');
        break;
      case 3:
        // Explorar
        Navigator.of(context).pushReplacementNamed('/explore');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Align(
          alignment: Alignment.centerLeft,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Header(),
                const SizedBox(height: 32),
                TouchAnimatedButton(
                  label: 'SUBMETER IDEIA',
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/submit');
                  },
                ),
                const SizedBox(height: 40),
                const _SectionTitle('Minhas ideias'),
                const SizedBox(height: 12),
                const IdeaCard(),
                const SizedBox(height: 40),
                const _SectionTitle('Pontos'),
                const SizedBox(height: 12),
                const PointsCard(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Índice da aba “Ideias”
        onTap: (idx) => _onTapNav(context, idx),
        backgroundColor: Colors.white.withOpacity(0.9),
        selectedItemColor: const Color(0xFF1877F2),
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb_outline), label: 'Ideias'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'QR code'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events_outlined), label: 'Pontuação'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Explorar'),
        ],
      ),
    );
  }
}

/// ----------------------------------------------------------------------------
/// Header com logo animado + avatar
/// ----------------------------------------------------------------------------
class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        AnimatedLogoImage(height: 40),
        CircleAvatar(radius: 24, backgroundImage: AssetImage('assets/images/avatar.png')),
      ],
    );
  }
}

// Continue definindo _SectionTitle, IdeaCard, PointsCard… exatamente como antes.

/// --------------------------------------------------------------------------
/// Título de seção
/// --------------------------------------------------------------------------
class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

/// --------------------------------------------------------------------------
/// Card de ideia (hover/scale)
/// --------------------------------------------------------------------------
class IdeaCard extends StatefulWidget {
  const IdeaCard({Key? key}) : super(key: key);
  @override
  _IdeaCardState createState() => _IdeaCardState();
}

class _IdeaCardState extends State<IdeaCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        width: double.infinity,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()..scale(_hovering ? 1.02 : 1.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: _hovering ? 12 : 4,
              offset: Offset(0, _hovering ? 6 : 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Aplicativo para treinamentos', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Em análise', style: TextStyle(fontSize: 14, color: Color(0xFF666666))),
            SizedBox(height: 4),
            Text('12 out 2023', style: TextStyle(fontSize: 14, color: Color(0xFF666666))),
          ],
        ),
      ),
    );
  }
}

/// --------------------------------------------------------------------------
/// Card de pontos (hover/scale)
/// --------------------------------------------------------------------------
class PointsCard extends StatefulWidget {
  const PointsCard({Key? key}) : super(key: key);
  @override
  _PointsCardState createState() => _PointsCardState();
}

class _PointsCardState extends State<PointsCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        width: double.infinity,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()..scale(_hovering ? 1.02 : 1.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: _hovering ? 12 : 4,
              offset: Offset(0, _hovering ? 6 : 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('280', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: const Color(0xFF1877F2)),
              child: const Text('resgatar recompensas', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
