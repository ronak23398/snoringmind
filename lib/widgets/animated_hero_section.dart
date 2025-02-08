import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedHeroSection extends StatefulWidget {
  const AnimatedHeroSection({super.key});

  @override
  State<AnimatedHeroSection> createState() => _AnimatedHeroSectionState();
}

class _AnimatedHeroSectionState extends State<AnimatedHeroSection>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _shapeController;
  late AnimationController _contentController;
  late Animation<double> _titleAnimation;
  late Animation<double> _subtitleAnimation;
  late Animation<double> _buttonAnimation;

  Offset? _mousePosition;
  final List<ShapeData> _shapes = [];
  final List<ParticleData> _particles = [];

  // Define color palette
  static const primaryGradient = [
    Color(0xFF2C3E50), // Dark blue-gray
    Color(0xFF3498DB), // Bright blue
  ];

  static const shapeColors = [
    Color(0xFFE74C3C), // Red
    Color(0xFFF1C40F), // Yellow
    Color(0xFF2ECC71), // Green
  ];

  @override
  void initState() {
    super.initState();
    _setupAnimationControllers();
    _setupAnimations();
    _generateShapes();
    _generateParticles();
  }

  void _setupAnimationControllers() {
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _shapeController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _contentController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
  }

  void _setupAnimations() {
    _titleAnimation = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );

    _subtitleAnimation = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
    );

    _buttonAnimation = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    );

    _contentController.forward();
  }

  void _generateShapes() {
    for (int i = 0; i < 15; i++) {
      _shapes.add(ShapeData(
        offset: Offset(
          math.Random().nextDouble() * 400 - 200,
          math.Random().nextDouble() * 400 - 200,
        ),
        size: math.Random().nextDouble() * 100 + 50,
        rotation: math.Random().nextDouble() * math.pi,
        opacity: math.Random().nextDouble() * 0.4 + 0.2,
        type: ShapeType.values[math.Random().nextInt(ShapeType.values.length)],
        color: shapeColors[math.Random().nextInt(shapeColors.length)],
      ));
    }
  }

  void _generateParticles() {
    for (int i = 0; i < 50; i++) {
      _particles.add(ParticleData(
        position: Offset(
          math.Random().nextDouble() * 800 - 400,
          math.Random().nextDouble() * 600,
        ),
        velocity: Offset(
          math.Random().nextDouble() * 2 - 1,
          math.Random().nextDouble() * 2 - 1,
        ),
        size: math.Random().nextDouble() * 4 + 1,
        color: Colors.white.withOpacity(math.Random().nextDouble() * 0.5 + 0.3),
      ));
    }
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _shapeController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 600,
      child: MouseRegion(
        onHover: (event) {
          setState(() {
            _mousePosition = event.localPosition;
          });
        },
        onExit: (_) {
          setState(() {
            _mousePosition = null;
          });
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _buildAnimatedBackground(),
            _buildFloatingShapes(),
            _buildParticles(),
            _buildMouseTrail(),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: _buildContent(),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(), // Right side space for shapes
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _backgroundController,
      builder: (context, child) {
        return Container(
          height: 600,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: primaryGradient,
              transform: GradientRotation(
                _backgroundController.value * 2 * math.pi,
              ),
            ),
          ),
          child: CustomPaint(
            painter: WavePainter(
              animation: _backgroundController,
              mousePosition: _mousePosition,
              waveColor: Colors.white.withOpacity(0.1),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFloatingShapes() {
    return Stack(
      children: _shapes.asMap().entries.map((entry) {
        final index = entry.key;
        final shape = entry.value;
        return AnimatedBuilder(
          animation: _shapeController,
          builder: (context, child) {
            final progress = _shapeController.value * 2 * math.pi;
            final movement = Offset(
              math.sin(progress + index) * 30,
              math.cos(progress + index) * 30,
            );

            return Positioned(
              left: MediaQuery.of(context).size.width / 2 +
                  shape.offset.dx +
                  movement.dx,
              top: 300 + shape.offset.dy + movement.dy,
              child: Transform.rotate(
                angle: shape.rotation + progress,
                child: _buildShape(shape),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildShape(ShapeData shape) {
    switch (shape.type) {
      case ShapeType.circle:
        return Container(
          width: shape.size,
          height: shape.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: shape.color.withOpacity(shape.opacity),
          ),
        );
      case ShapeType.square:
        return Container(
          width: shape.size,
          height: shape.size,
          decoration: BoxDecoration(
            color: shape.color.withOpacity(shape.opacity),
          ),
        );
      case ShapeType.triangle:
        return CustomPaint(
          size: Size(shape.size, shape.size),
          painter: TrianglePainter(
            color: shape.color.withOpacity(shape.opacity),
          ),
        );
    }
  }

  Widget _buildParticles() {
    return AnimatedBuilder(
      animation: _shapeController,
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return CustomPaint(
              size: Size(
                constraints.maxWidth,
                constraints.maxHeight,
              ),
              painter: ParticlePainter(
                particles: _particles,
                animation: _shapeController.value,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMouseTrail() {
    if (_mousePosition == null) return const SizedBox.shrink();
    return Positioned(
      left: _mousePosition!.dx - 100,
      top: _mousePosition!.dy - 100,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.white.withOpacity(0.15), // Slightly increased opacity
              Colors.white.withOpacity(0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _titleAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 50 * (1 - _titleAnimation.value)),
                child: Opacity(
                  opacity: _titleAnimation.value,
                  child: const Text(
                    'Find the Right Support for You',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          AnimatedBuilder(
            animation: _subtitleAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 30 * (1 - _subtitleAnimation.value)),
                child: Opacity(
                  opacity: _subtitleAnimation.value,
                  child: const Text(
                    'Get professional help for your mental well-being – anytime, anywhere.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 255, 255, 255),
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(0, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
          AnimatedBuilder(
            animation: _buttonAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _buttonAnimation.value,
                child: _buildAnimatedButton(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedButton() {
    return MouseRegion(
      onEnter: (_) => setState(() {}),
      onExit: (_) => setState(() {}),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
        ),
        child: const Text(
          'Request an Appointment',
          style: TextStyle(
            fontSize: 18,
            color:
                Color(0xFF2C3E50), // Matching the dark blue-gray from gradient
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// Helper classes and painters
class ShapeData {
  final Offset offset;
  final double size;
  final double rotation;
  final double opacity;
  final ShapeType type;
  final Color color;

  ShapeData({
    required this.offset,
    required this.size,
    required this.rotation,
    required this.opacity,
    required this.type,
    required this.color,
  });
}

enum ShapeType { circle, square, triangle }

class ParticleData {
  Offset position;
  Offset velocity;
  final double size;
  final Color color;

  ParticleData({
    required this.position,
    required this.velocity,
    required this.size,
    required this.color,
  });
}

class WavePainter extends CustomPainter {
  final Animation<double> animation;
  final Offset? mousePosition;
  final Color waveColor;

  WavePainter({
    required this.animation,
    this.mousePosition,
    this.waveColor = const Color(0x1AFFFFFF),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = waveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    var y = size.height / 2;

    for (var x = 0.0; x < size.width; x++) {
      y = size.height / 2 +
          math.sin(x / 50 + animation.value * 2 * math.pi) * 20;

      if (x == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => true;
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) => false;
}

class ParticlePainter extends CustomPainter {
  final List<ParticleData> particles;
  final double animation;

  ParticlePainter({required this.particles, required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      particle.position += particle.velocity;

      if (particle.position.dx > size.width) {
        particle.position = Offset(0, particle.position.dy);
      } else if (particle.position.dx < 0) {
        particle.position = Offset(size.width, particle.position.dy);
      }
      if (particle.position.dy > size.height) {
        particle.position = Offset(particle.position.dx, 0);
      } else if (particle.position.dy < 0) {
        particle.position = Offset(particle.position.dx, size.height);
      }

      final paint = Paint()..color = particle.color;
      canvas.drawCircle(particle.position, particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}
