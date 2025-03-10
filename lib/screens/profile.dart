import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:url_launcher/url_launcher.dart';

class EnhancedProfileSection extends StatefulWidget {
  const EnhancedProfileSection({super.key});

  @override
  State<EnhancedProfileSection> createState() => _EnhancedProfileSectionState();
}

class _EnhancedProfileSectionState extends State<EnhancedProfileSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Color> _colorPalette;
  late List<Animation<Color?>> _colorAnimations;

  @override
  void initState() {
    super.initState();

    // Create a vibrant color palette
    _colorPalette = [
      const Color(0xFF6200EA), // Deep Purple
      const Color(0xFF2979FF), // Blue
      const Color(0xFF00B0FF), // Light Blue
      const Color(0xFF00BFA5), // Teal
      const Color(0xFF00C853), // Green
      const Color(0xFFFFD600), // Yellow
      const Color(0xFFFF6D00), // Orange
      const Color(0xFFD50000), // Red
      const Color(0xFFAA00FF), // Purple
      const Color(0xFF6200EA), // Deep Purple (repeated to complete the cycle)
    ];

    // Animation controller for the entire cycle
    _controller = AnimationController(
      duration: const Duration(
          seconds: 24), // Total duration for the entire color cycle
      vsync: this,
    );

    // Create smooth color transitions
    _setupColorAnimations();

    // Start the animation
    _controller.repeat();
  }

  void _setupColorAnimations() {
    // Create three animations for the three gradient colors
    _colorAnimations = List.generate(3, (index) {
      // Each animation will cycle through all the colors in the palette
      List<TweenSequenceItem<Color?>> colorSequence = [];

      // Calculate duration for each transition
      final int totalColors = _colorPalette.length - 1;
      final double intervalPerColor = 1.0 / totalColors;

      // Create a sequence of color transitions
      for (int i = 0; i < totalColors; i++) {
        colorSequence.add(
          TweenSequenceItem(
            weight: 1.0,
            tween: ColorTween(
              begin: _colorPalette[i],
              end: _colorPalette[i + 1],
            ),
          ),
        );
      }

      // Create the animation with offset for each gradient color
      // Fixed interval values to ensure they don't exceed 1.0
      double startOffset = (index * 0.1) % 1.0;
      return TweenSequence(colorSequence).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            startOffset,
            math.min(
                startOffset + 0.7, 1.0), // Ensure end value doesn't exceed 1.0
            curve: Curves.easeInOut,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Extract current colors from animations
        final List<Color> currentGradient = _colorAnimations
            .map((animation) => animation.value ?? Colors.purple)
            .toList();

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: currentGradient[1].withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 15,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            return Stack(
              children: [
                // Animated background
                CustomPaint(
                  painter: WavePainter(
                    animation: _controller,
                    gradientColors: currentGradient,
                  ),
                  size: Size(constraints.maxWidth,
                      400), // Fixed height instead of infinite
                ),

                // Floating bubbles
                SizedBox(
                  width: constraints.maxWidth,
                  height: 400, // Fixed height to match CustomPaint
                  child: BubblesAnimation(controller: _controller),
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // Glow effect around profile picture
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: currentGradient[0].withOpacity(0.5),
                              spreadRadius: 10,
                              blurRadius: 25,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 65,
                            backgroundImage: AssetImage('assets/profile.jpg'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Abhishek Poojary',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black45,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: const Text(
                          'Software Developer | Flutter Developer  | MERN Stack',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Tooltip(
                            message: 'Send an email',
                            child: _buildContactButton(
                              icon: Icons.email_outlined,
                              label: 'poojaryabhishek26@gmail.com',
                              onTap: () {
                                launchUrl(Uri.parse(
                                    'mailto:poojaryabhishek26@gmail.com'));
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Tooltip(
                            message: 'Call this number',
                            child: _buildContactButton(
                              icon: Icons.phone_outlined,
                              label: '+919945726449',
                              onTap: () {
                                launchUrl(Uri.parse('tel:+919945726449'));
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Tooltip(
                            message: 'View location on map',
                            child: _buildContactButton(
                              icon: Icons.location_on_outlined,
                              label: 'Bengaluru',
                              onTap: () {
                                launchUrl(Uri.parse(
                                    'https://www.google.com/maps/search/?api=1&query=Bengaluru'));
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildContactButton(
                            icon: Icons.link,
                            label: 'GitHub',
                            onTap: () {
                              launchUrl(Uri.parse(
                                  'https://github.com/Abhishek-poojary1'));
                            },
                          ),
                          const SizedBox(width: 16),
                          _buildContactButton(
                            icon: Icons.business,
                            label: 'LinkedIn',
                            onTap: () {
                              launchUrl(Uri.parse(
                                  'https://www.linkedin.com/in/abhishek-poojary-a50281268'));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }

  Widget _buildContactButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Animated bubbles widget
class BubblesAnimation extends StatelessWidget {
  final AnimationController controller;
  final int bubbleCount = 15;

  const BubblesAnimation({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: List.generate(bubbleCount, (index) {
            final random = math.Random(index);
            final size = 10.0 + random.nextDouble() * 20;
            final initialX = random.nextDouble() * constraints.maxWidth;
            final initialY = random.nextDouble() * constraints.maxHeight;
            final speed = 50 + random.nextDouble() * 100;

            return AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                final animationValue =
                    (controller.value + index / bubbleCount) % 1.0;

                // Calculate bubble path - moving upward in a slight sine wave
                final x = initialX + math.sin(animationValue * 5) * 20;
                final y = initialY - (animationValue * speed);

                // Make bubble reappear at bottom when it reaches the top
                final currentY = y < 0 ? constraints.maxHeight + y : y;

                return Positioned(
                  left: x,
                  top: currentY,
                  child: Opacity(
                    opacity: 0.4 +
                        (math.sin(controller.value * math.pi * 2) + 1) / 5,
                    child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                            .withOpacity(0.5 + random.nextDouble() * 0.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.3),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        );
      },
    );
  }
}

// Custom painter for creating the animated wave background
class WavePainter extends CustomPainter {
  final Animation<double> animation;
  final List<Color> gradientColors;

  WavePainter({required this.animation, required this.gradientColors})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    // Base gradient background
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: gradientColors,
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // First wave layer
    _drawWave(
      canvas: canvas,
      size: size,
      amplitude: 25,
      wavelength: size.width / 1.5,
      phase: animation.value * 2 * math.pi,
      color: Colors.white.withOpacity(0.15),
    );

    // Second wave layer (different phase and wavelength)
    _drawWave(
      canvas: canvas,
      size: size,
      amplitude: 20,
      wavelength: size.width / 1.2,
      phase: animation.value * 2 * math.pi + math.pi / 3,
      color: Colors.white.withOpacity(0.1),
    );

    // Third wave layer
    _drawWave(
      canvas: canvas,
      size: size,
      amplitude: 30,
      wavelength: size.width / 0.8,
      phase: -animation.value * 2 * math.pi,
      color: Colors.white.withOpacity(0.08),
    );

    // Add glowing particle effect
    _drawGlowingParticles(canvas, size);
  }

  void _drawWave({
    required Canvas canvas,
    required Size size,
    required double amplitude,
    required double wavelength,
    required double phase,
    required Color color,
  }) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height / 2);

    for (double x = 0; x <= size.width; x++) {
      final y = size.height / 2 +
          amplitude * math.sin((2 * math.pi * x / wavelength) + phase);
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  void _drawGlowingParticles(Canvas canvas, Size size) {
    final random = math.Random(42); // Fixed seed for deterministic particles

    // Draw particles with glow effects
    for (int i = 0; i < 80; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;

      // Base radius that depends on position (for variation)
      final baseRadius = 1.0 + random.nextDouble() * 3.0;

      // Add animation to particle size
      final animSin = math.sin(animation.value * 2 * math.pi + i);
      final radius = baseRadius * (0.8 + 0.4 * animSin);

      // Vary opacity with animation
      final opacity = 0.2 + 0.3 * (1 + animSin) / 2;

      // Draw glow effect (larger, more transparent circle)
      final glowPaint = Paint()
        ..color = Colors.white.withOpacity(opacity * 0.3)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(x, y), radius * 2.5, glowPaint);

      // Draw particle core
      final particlePaint = Paint()..color = Colors.white.withOpacity(opacity);
      canvas.drawCircle(Offset(x, y), radius, particlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) {
    return oldDelegate.animation != animation ||
        oldDelegate.gradientColors != gradientColors;
  }
}
