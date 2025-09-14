// lib/pages/explore_page.dart

import 'package:flutter/material.dart';
import '../widgets/background_scaffold.dart';
import '../widgets/animated_logo_image.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class Idea {
  Idea({
    required this.asset,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.points,
    required this.likes,
    List<String>? comments,
    this.isLiked = false,
  }) : comments = comments ?? [];

  final String asset;
  final String title;
  final String subtitle;
  final String author;

  int points;
  int likes;
  bool isLiked;
  final List<String> comments;
}

class _ExplorePageState extends State<ExplorePage> {
  late final List<Idea> _ideas;

  @override
  void initState() {
    super.initState();
    _ideas = [
      Idea(
        asset: 'assets/images/robo1.png',
        title: 'Assistente Robótico para Atendimentos',
        subtitle: 'Auxiliar colaboradores em tarefas diárias',
        author: 'Carlos Oliveira',
        points: 230,
        likes: 25,
        comments: ['Excelente!', 'Isso economiza tempo.'],
      ),
      Idea(
        asset: 'assets/images/robo2.png',
        title: 'Laboratório Móvel de Testes',
        subtitle: 'Realizar exames diretamente nas unidades',
        author: 'Ana Souza',
        points: 180,
        likes: 18,
        comments: ['Muito útil no dia a dia.', 'Top!'],
      ),
      Idea(
        asset: 'assets/images/robo3.png',
        title: 'Plataforma de Ideias',
        subtitle: 'Enviar e discutir sugestões de inovação',
        author: 'Lucas Pereira',
        points: 150,
        likes: 20,
        comments: ['Engaja a galera!', 'Vai bombar.'],
      ),
      Idea(
        asset: 'assets/images/robo4.png',
        title: 'Linha de Produção Automatizada',
        subtitle: 'Aumentar a eficiência na fábrica',
        author: 'Mariana Carvalho',
        points: 260,
        likes: 34,
        comments: ['Produtividade vai lá em cima.'],
      ),
    ];
  }

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
          itemCount: _ideas.length + 2,
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

            final idea = _ideas[idx - 2];
            return IdeaTile(
              idea: idea,
              onChanged: () => setState(() {}),
              pointsPerLike: 5, // ajuste se quiser
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 3,
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
                icon: Icon(Icons.emoji_events_outlined), label: 'Pontuação'),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline), label: 'Explorar'),
          ],
        ),
      ),
    );
  }
}

/// Card com like animado, contadores e modal de comentários
class IdeaTile extends StatefulWidget {
  const IdeaTile({
    Key? key,
    required this.idea,
    required this.onChanged,
    this.pointsPerLike = 5,
  }) : super(key: key);

  final Idea idea;
  final VoidCallback onChanged;
  final int pointsPerLike;

  @override
  State<IdeaTile> createState() => _IdeaTileState();
}

class _IdeaTileState extends State<IdeaTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _likeCtrl;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _likeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(parent: _likeCtrl, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _likeCtrl.dispose();
    super.dispose();
  }

  Future<void> _toggleLike() async {
    setState(() {
      widget.idea.isLiked = !widget.idea.isLiked;
      if (widget.idea.isLiked) {
        widget.idea.likes += 1;
        widget.idea.points += widget.pointsPerLike;
      } else {
        widget.idea.likes = (widget.idea.likes - 1).clamp(0, 1 << 31);
        widget.idea.points =
            (widget.idea.points - widget.pointsPerLike).clamp(0, 1 << 31);
      }
    });

    // animação do coração
    await _likeCtrl.forward(from: 0);
    await _likeCtrl.reverse();

    widget.onChanged();
  }

  Future<void> _openComments() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _CommentsSheet(idea: widget.idea),
    );
    // quando o modal fecha, pedimos pra rebuildar os contadores
    setState(() {});
    widget.onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final idea = widget.idea;

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
                  idea.asset,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  idea.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              // pontos + estrela com leve troca animada
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(height: 4),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 180),
                    transitionBuilder: (child, anim) =>
                        FadeTransition(opacity: anim, child: child),
                    child: Text(
                      '${idea.points} pts',
                      key: ValueKey(idea.points),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              idea.subtitle,
              style: const TextStyle(fontSize: 14, color: Color(0xFF666666)),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                idea.author,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const Spacer(),

              // botão de like com animação de scale
              GestureDetector(
                onTap: _toggleLike,
                child: Row(
                  children: [
                    ScaleTransition(
                      scale: _scaleAnim,
                      child: Icon(
                        idea.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 18,
                        color: idea.isLiked ? Colors.red : Colors.black54,
                      ),
                    ),
                    const SizedBox(width: 6),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 180),
                      transitionBuilder: (c, a) =>
                          FadeTransition(opacity: a, child: c),
                      child: Text(
                        '${idea.likes}',
                        key: ValueKey(idea.likes),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // botão de comentários
              InkWell(
                onTap: _openComments,
                borderRadius: BorderRadius.circular(6),
                child: Row(
                  children: [
                    const Icon(Icons.comment, size: 18, color: Colors.black54),
                    const SizedBox(width: 6),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 180),
                      transitionBuilder: (c, a) =>
                          FadeTransition(opacity: a, child: c),
                      child: Text(
                        '${idea.comments.length}',
                        key: ValueKey(idea.comments.length),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ---------- BottomSheet de comentários ----------
class _CommentsSheet extends StatefulWidget {
  const _CommentsSheet({Key? key, required this.idea}) : super(key: key);
  final Idea idea;

  @override
  State<_CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<_CommentsSheet> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _addComment() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      widget.idea.comments.add(text);
    });
    _ctrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.65,
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Comentários',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 24),

            // lista de comentários
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: widget.idea.comments.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (_, i) {
                  final c = widget.idea.comments[i];
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 14,
                          backgroundImage:
                              AssetImage('assets/images/avatar.png'),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            c,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // caixa de texto + enviar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _ctrl,
                      decoration: InputDecoration(
                        hintText: 'Escreva um comentário...',
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                      ),
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _addComment(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton(
                    heroTag: null,
                    mini: true,
                    backgroundColor: const Color(0xFF1877F2),
                    onPressed: _addComment,
                    child: const Icon(Icons.send, color: Colors.white, size: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
