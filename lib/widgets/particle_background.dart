// lib/widgets/particle_background.dart

import 'dart:math';
import 'package:flutter/material.dart';

/// Fundo de partículas animadas em código puro.
/// Usar dentro de um Stack para ficar atrás do conteúdo.
class ParticleBackground extends StatefulWidget {
  const ParticleBackground({Key? key}) : super(key: key);

  @override
  _ParticleBackgroundState createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<_Particle> _particles = [];
  final int _numParticles = 80;

  @override
  void initState() {
    super.initState();
    final rnd = Random();
    // Cria partículas com posição/velocidade/raio/alpha aleatórios
    for (var i = 0; i < _numParticles; i++) {
      _particles.add(_Particle(
        position: Offset(rnd.nextDouble(), rnd.nextDouble()),
        velocity: Offset(rnd.nextDouble() - .5, rnd.nextDouble() - .5) * 0.001,
        radius: rnd.nextDouble() * 3 + 1,
        color: Colors.white.withOpacity(rnd.nextDouble() * .5 + .2),
      ));
    }
    // Controlador que dispara atualização a cada tick
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )
      ..addListener(_updateParticles)
      ..repeat();
  }

  void _updateParticles() {
    for (var p in _particles) {
      p.position += p.velocity;
      // Se sair dos limites normalizados [0,1], inverte direção
      if (p.position.dx < 0 || p.position.dx > 1) {
        p.velocity = Offset(-p.velocity.dx, p.velocity.dy);
      }
      if (p.position.dy < 0 || p.position.dy > 1) {
        p.velocity = Offset(p.velocity.dx, -p.velocity.dy);
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // CustomPaint preenche toda a área disponível
    return CustomPaint(
      painter: _ParticlePainter(_particles),
      size: MediaQuery.of(context).size,
    );
  }
}

/// Modelo de uma única partícula.
class _Particle {
  Offset position;
  Offset velocity;
  final double radius;
  final Color color;

  _Particle({
    required this.position,
    required this.velocity,
    required this.radius,
    required this.color,
  });
}

/// Desenha todas as partículas no Canvas.
class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;

  _ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (var p in particles) {
      paint.color = p.color;
      final offset = Offset(
        p.position.dx * size.width,
        p.position.dy * size.height,
      );
      canvas.drawCircle(offset, p.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}
