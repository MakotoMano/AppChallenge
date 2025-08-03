import 'package:flutter/material.dart';

class AnimatedLogo extends StatefulWidget {
  const AnimatedLogo({Key? key}) : super(key: key);
  @override
  _AnimatedLogoState createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _slide; // para mover o brilho
  late final Animation<double> _pop;   // pra escala inicial

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // move de -1 (fora à esquerda) até +1 (fora à direita) repetidamente
    _slide = Tween(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.linear),
    );

    // pulinho elástico só no início (0–0.5s)
    _pop = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: const Interval(0, 0.15, curve: Curves.elasticOut)),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, child) {
        // posição atual do brilho
        final pos = _slide.value;
        return Transform.scale(
          scale: (_pop.value.clamp(0.8,1.0)), // escala de 0.8→1.0 no pop
          child: ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                begin: Alignment(pos - 1, 0),
                end:   Alignment(pos + 1, 0),
                colors: const [
                  Colors.white,
                  Colors.yellowAccent,
                  Colors.white,
                ],
                stops: const [0.4, 0.5, 0.6],
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcIn,
            child: child,
          ),
        );
      },
      child: const Text(
        'INOVA+',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white, // cor base (serve de fallback)
        ),
      ),
    );
  }
}
