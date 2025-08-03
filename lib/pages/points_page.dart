// lib/pages/points_page.dart

import 'package:flutter/material.dart';
import '../widgets/background_scaffold.dart';
import '../widgets/animated_logo_image.dart';

class PointsPage extends StatelessWidget {
  const PointsPage({Key? key}) : super(key: key);

  void _onTapNav(BuildContext context, int idx) {
    switch (idx) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/qr');
        break;
      case 2:
        // já estamos aqui
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/explore');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // se não estivermos na home, volte pra home
        if (ModalRoute.of(context)?.settings.name != '/home') {
          Navigator.pushReplacementNamed(context, '/home');
          return false;
        }
        return true;
      },
      child: BackgroundScaffold(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
          child: Center(
            child: Column(
              children: const [
                AnimatedLogoImage(height: 80),
                SizedBox(height: 32),
                Text(
                  'Pontuação',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Aqui você vê seus pontos acumulados.',
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
                // TODO: substituir pelo ListView de recompensas/pontos
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 2, // Pontuação é a terceira aba
          onTap: (idx) => _onTapNav(context, idx),
          backgroundColor: Colors.white.withOpacity(0.9),
          selectedItemColor: const Color(0xFF1877F2),
          unselectedItemColor: Colors.black54,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb_outline),
              label: 'Ideias',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner),
              label: 'QR code',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events_outlined),
              label: 'Pontuação',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              label: 'Explorar',
            ),
          ],
        ),
      ),
    );
  }
}
