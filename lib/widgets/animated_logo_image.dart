import 'package:flutter/material.dart';

/// Logo estático (PNG/SVG) com um “shine” animado por ShaderMask
class AnimatedLogoImage extends StatefulWidget {
  const AnimatedLogoImage({Key? key, this.height = 40}) : super(key: key);

  /// Altura do logo
  final double height;

  @override
  _AnimatedLogoImageState createState() => _AnimatedLogoImageState();
}

class _AnimatedLogoImageState extends State<AnimatedLogoImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _shinePos;
  late final Animation<double> _pop;

  @override
  void initState() {
    super.initState();
    // controladora de 2s para o brilho deslizar
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _shinePos = Tween(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.linear),
    );

    // pulinho elástico ao montar (0–0.3s)
    _pop = Tween(begin: 0.8, end: 1.0).animate(
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
      builder: (context, child) {
        final pos = _shinePos.value;
        return Transform.scale(
          scale: _pop.value,
          child: ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (bounds) => LinearGradient(
              begin: Alignment(pos - 0.3, 0),
              end: Alignment(pos + 0.3, 0),
              colors: const [
                Colors.white24,
                Colors.white70,
                Colors.white24,
              ],
              stops: [0, 0.5, 1],
            ).createShader(bounds),
            child: child,
          ),
        );
      },
      child: Image.asset(
        'assets/images/inova_logo.png',
        height: widget.height,
      ),
    );
  }
}
