// lib/pages/explore_page.dart

import 'package:flutter/material.dart';
import '../widgets/background_scaffold.dart';
import '../widgets/animated_logo_image.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({Key? key}) : super(key: key);

  void _onTapNav(BuildContext context, int idx) {
    switch (idx) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/qr');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/points');
        break;
      case 3:
        // já estamos aqui
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> ideas = [
      {
        'asset':    'assets/images/robo1.png',
        'title':    'Assistente Robótico para Atendimentos',
        'subtitle': 'Auxiliar colaboradores em tarefas diárias',
        'author':   'Carlos Oliveira',
        'points':   230,
        'likes':    25,
        'comments': 8,
      },
      {
        'asset':    'assets/images/robo2.png',
        'title':    'Laboratório Móvel de Testes',
        'subtitle': 'Realizar exames diretamente nas unidades',
        'author':   'Ana Souza',
        'points':   180,
        'likes':    18,
        'comments': 4,
      },
      {
        'asset':    'assets/images/robo3.png',
        'title':    'Plataforma de Ideias',
        'subtitle': 'Enviar e discutir sugestões de inovação',
        'author':   'Lucas Pereira',
        'points':   150,
        'likes':    20,
        'comments': 6,
      },
      {
        'asset':    'assets/images/robo4.png',
        'title':    'Linha de Produção Automatizada',
        'subtitle': 'Aumentar a eficiência na fábrica',
        'author':   'Mariana Carvalho',
        'points':   260,
        'likes':    34,
        'comments': 12,
      },
      {
        'asset':    'assets/images/robo5.png',
        'title':    'Farmácia Automatizada',
        'subtitle': 'Dispenser inteligente de medicamentos',
        'author':   'Rafael Mendes',
        'points':   200,
        'likes':    22,
        'comments': 5,
      },
      {
        'asset':    'assets/images/robo6.png',
        'title':    'Rastreamento de Estoque em Tempo Real',
        'subtitle': 'Gerenciar insumos pela nuvem',
        'author':   'Beatriz Lima',
        'points':   210,
        'likes':    19,
        'comments': 7,
      },
      {
        'asset':    'assets/images/robo7.png',
        'title':    'Telemedicina Integrada',
        'subtitle': 'Consulta remota com profissionais',
        'author':   'Pedro Santos',
        'points':   240,
        'likes':    28,
        'comments': 9,
      },
    ];

    return WillPopScope(
      onWillPop: () async {
        if (ModalRoute.of(context)?.settings.name != '/home') {
          Navigator.pushReplacementNamed(context, '/home');
          return false;
        }
        return true;
      },
      child: BackgroundScaffold(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          itemCount: ideas.length + 2,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, idx) {
            if (idx == 0) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  AnimatedLogoImage(height: 40),
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                ],
              );
            } else if (idx == 1) {
              return const Text(
                'Explorar Ideias',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              );
            }

            final item = ideas[idx - 2];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          item['asset'] as String,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          item['title'] as String,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        children: [
                          const Icon(Icons.star, color: Colors.amber),
                          const SizedBox(height: 4),
                          Text(
                            '${item['points']} pts',
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['subtitle'] as String,
                    style: const TextStyle(
                        fontSize: 14, color: Color(0xFF666666)),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        item['author'] as String,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      const Icon(Icons.favorite_border,
                          size: 16, color: Colors.red),
                      const SizedBox(width: 4),
                      Text('${item['likes']}'),
                      const SizedBox(width: 16),
                      const Icon(Icons.comment,
                          size: 16, color: Colors.black54),
                      const SizedBox(width: 4),
                      Text('${item['comments']}'),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 3, // Explorar
          onTap: (i) => _onTapNav(context, i),
          backgroundColor: Colors.white.withOpacity(0.9),
          selectedItemColor: const Color(0xFF1877F2),
          unselectedItemColor: Colors.black54,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.lightbulb_outline), label: 'Ideias'),
            BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_scanner), label: 'QR code'),
            BottomNavigationBarItem(
                icon: Icon(Icons.emoji_events_outlined),
                label: 'Pontuação'),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline), label: 'Explorar'),
          ],
        ),
      ),
    );
  }
}
