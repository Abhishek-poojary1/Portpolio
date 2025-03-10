import 'dart:math';

import 'package:flutter/material.dart';
import 'package:profitpolio/screens/profile.dart';
import 'package:profitpolio/screens/project.dart';
import 'package:profitpolio/screens/url_launcher_web.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Abhishek Poojary - Resume',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: const ResumeScreen(),
    );
  }
}

class ResumeScreen extends StatelessWidget {
  const ResumeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              EnhancedProfileSection(),
              SizedBox(height: 16),
              AnimatedSections(),
            ],
          ),
        ),
      ),
    );
  }
}

class SummarySection extends StatelessWidget {
  const SummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        'I am a seasoned software developer with expertise in multiple programming languages and frameworks. I possess a versatile skill set with a proven track record of delivering high-quality software solutions. Proficient in Flutter, Dart, C++, Python, Java, JavaScript, and the MERN stack, I thrive in both front-end and back-end development, focusing on creating scalable, user-friendly applications.',
        style: TextStyle(
          fontSize: 16,
          height: 1.5,
        ),
      ),
    );
  }
}

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildExperienceItem(
            company: 'SmartBuild Automation Pvt Ltd',
            position: 'Assistant Software Developer',
            duration: 'Jan 2024 - Present',
            location: 'Bengaluru, Karnataka',
            responsibilities: [
              'Developed and launched a cross-platform mobile application using Flutter, integrating SQLite for local storage and Firebase Realtime Database for cloud synchronization.',
              'Implemented dynamic UI updates based on real-time data, optimized app performance, and enhanced user experience with custom widgets.',
              'Deployed app with secure authentication, IoT service integrations, and complex state management.',
            ],
          ),
          const Divider(),
          _buildExperienceItem(
            company: 'Melange Systems Pvt Ltd',
            position: 'Software Developer Intern',
            duration: 'Oct 2023 - Jan 2024',
            location: 'Bengaluru, Karnataka',
            responsibilities: [
              'Assisted in the development of front-end and back-end components using technologies such as Node.js and React.js.',
              'Actively participated in team meetings, providing updates on project progress, discussing challenges, and brainstorming solutions.',
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceItem({
    required String company,
    required String position,
    required String duration,
    required String location,
    required List<String> responsibilities,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue[700],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    position,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    company,
                    style: TextStyle(
                      color: Colors.blue[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        duration,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.location_on,
                          size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        location,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...responsibilities.map((responsibility) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '•',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[700],
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                responsibility,
                                style: const TextStyle(height: 1.5),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class EnhancedSkillsSection extends StatefulWidget {
  const EnhancedSkillsSection({Key? key}) : super(key: key);

  @override
  State<EnhancedSkillsSection> createState() => _EnhancedSkillsSectionState();
}

class _EnhancedSkillsSectionState extends State<EnhancedSkillsSection>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  late AnimationController _pulseController;
  late AnimationController _flowController;
  late AnimationController _bgAnimationController;

  final List<Map<String, dynamic>> skills = [
    {'name': 'Flutter', 'icon': Icons.mobile_friendly, 'color': Colors.blue},
    {'name': 'MERN Stack', 'icon': Icons.web, 'color': Colors.green},
    {'name': 'Dart', 'icon': Icons.devices, 'color': Colors.purple},
    {'name': 'Firebase', 'icon': Icons.storage, 'color': Colors.orange},
    {'name': 'SQLite', 'icon': Icons.sync_alt, 'color': Colors.red},
    {'name': 'javascript', 'icon': Icons.storage, 'color': Colors.teal},
    {'name': 'Provider', 'icon': Icons.storage, 'color': Colors.teal},
  ];

  // For background particle animation
  final List<Particle> _particles = [];
  final int _particleCount = 15;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    // Initialize particles
    for (int i = 0; i < _particleCount; i++) {
      _particles.add(Particle(
        x: _random.nextDouble() * 300,
        y: _random.nextDouble() * 200,
        size: _random.nextDouble() * 8 + 4,
        speed: _random.nextDouble() * 0.5 + 0.3,
        opacity: _random.nextDouble() * 0.5 + 0.1,
        color: skills[_random.nextInt(skills.length)]['color'] as Color,
      ));
    }

    // Initial appear animations
    _controllers = List.generate(
      skills.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 600 + (index * 100)),
        vsync: this,
      ),
    );

    _animations = _controllers
        .map((controller) => CurvedAnimation(
              parent: controller,
              curve: Curves.easeInOut,
            ))
        .toList();

    // Continuous pulse animation
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    // Continuous flow animation
    _flowController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    // Background animation controller
    _bgAnimationController = AnimationController(
      duration: const Duration(milliseconds: 16),
      vsync: this,
    )..repeat();

    _bgAnimationController.addListener(() {
      // Update particle positions
      for (var particle in _particles) {
        particle.y -= particle.speed;

        // Reset particle when it goes off screen
        if (particle.y < 0) {
          particle.y = 200;
          particle.x = _random.nextDouble() * 300;
        }
      }
    });

    // Start animations with staggered delay
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: 100 * i), () {
        if (mounted) {
          _controllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _pulseController.dispose();
    _flowController.dispose();
    _bgAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background animation
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _bgAnimationController,
            builder: (context, _) {
              return CustomPaint(
                painter: ParticlePainter(_particles),
              );
            },
          ),
        ),

        // Skills content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Skills",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  skills.length,
                  (index) => AnimatedBuilder(
                    animation: Listenable.merge([
                      _animations[index],
                      _pulseController,
                      _flowController,
                    ]),
                    builder: (context, child) {
                      // Calculate flow effect offset
                      final flowValue = _flowController.value;
                      final waveOffset =
                          math.sin(flowValue * 2 * math.pi + index) * 3;

                      return Transform.translate(
                        offset: Offset(0, waveOffset),
                        child: Transform.scale(
                          scale: _animations[index].value *
                              (1 + _pulseController.value * 0.05),
                          child: FadeTransition(
                            opacity: _animations[index],
                            child: _buildSkillChip(skills[index], index),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSkillChip(Map<String, dynamic> skill, int index) {
    final Color skillColor = skill['color'] as Color;

    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: skillColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border.all(
          color: skillColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1 + _pulseController.value * 0.1,
                  child: Icon(
                    skill['icon'] as IconData,
                    color: skillColor,
                    size: 16,
                  ),
                );
              }),
          const SizedBox(width: 6),
          Text(
            skill['name'] as String,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

// Particle class for background animation
class Particle {
  double x;
  double y;
  double size;
  double speed;
  double opacity;
  Color color;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
    required this.color,
  });
}

// Custom painter for rendering particles
class ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      final paint = Paint()
        ..color = particle.color.withOpacity(particle.opacity)
        ..style = PaintingStyle.fill;

      // Draw soft circle
      canvas.drawCircle(
        Offset(particle.x, particle.y),
        particle.size,
        paint,
      );

      // Draw connecting lines between nearby particles
      for (var otherParticle in particles) {
        if (particle == otherParticle) continue;

        double distance = _calculateDistance(
            particle.x, particle.y, otherParticle.x, otherParticle.y);

        if (distance < 60) {
          final opacity = (1 - distance / 60) * 0.2;
          final linePaint = Paint()
            ..color = particle.color.withOpacity(opacity)
            ..strokeWidth = 0.5;

          canvas.drawLine(
            Offset(particle.x, particle.y),
            Offset(otherParticle.x, otherParticle.y),
            linePaint,
          );
        }
      }
    }
  }

  double _calculateDistance(double x1, double y1, double x2, double y2) {
    return math.sqrt(math.pow(x2 - x1, 2) + math.pow(y2 - y1, 2));
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}

class EnhancedProjectsSection extends StatelessWidget {
  const EnhancedProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> projects = [
      {
        'title': 'IoT Home Automation App',
        'description':
            'A cross-platform application for controlling smart home devices with real-time updates.',
        'technologies': [
          'Flutter',
          'TCP Communication',
          'UDP Communication'
              'Firebase',
          'Socket Programming',
          'Provider',
          'IoT'
        ],
        'icon': Icons.home_outlined,
        'link':
            'https://apps.apple.com/in/app/sb-auto/id6478853565', // Add your GitHub or project link here
      },
      {
        'title': 'IoT Home Automation App Using Mqtt',
        'description':
            'A cross-platform application for controlling smart home devices with real-time updates.',
        'technologies': [
          'Flutter',
          'Firebase',
          'MQTT'
              'Socket Programming',
          'Provider',
          'IoT'
        ],
        'icon': Icons.home_outlined,
        'link':
            'https://apps.apple.com/in/app/sba-home/id6739250335', // Add your GitHub or project link here
      },
      {
        'title': 'Custom Design Website',
        'description':
            'A website for design the Automation Switch Board with Dynamic Controls and switchs with responsive design.',
        'technologies': ['React', 'Node.js', 'Express', 'MongoDB'],
        'icon': Icons.web_outlined,
        'link':
            'https://github.com/Abhishek-poojary1/Swicthboard_final.git', // Add your website URL here
      },
      {
        'title': 'Portfolio Website',
        'description':
            'Personal portfolio website showcasing projects and skills with responsive design.',
        'technologies': ['Flutter', 'Provider', 'Dart', 'Firebase'],
        'icon': Icons.web_outlined,
        'link': 'https://yourportfolio.com', // Add your website URL here
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: projects
            .map((project) => _buildProjectCard(project, context))
            .toList(),
      ),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project, BuildContext context) {
    void handleTap() {
      if (project['link'] != null) {
        launchURL(project['link'] as String);
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: handleTap,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          project['icon'] as IconData,
                          color: Colors.blue[700],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project['title'] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              project['description'] as String,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (project['link'] != null)
                        Icon(
                          Icons.open_in_new,
                          color: Colors.blue[700],
                          size: 20,
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (project['technologies'] as List<String>)
                        .map((tech) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                tech,
                                style: TextStyle(
                                  color: Colors.blue[700],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> achievements = [
      {
        'title': 'App Development Success',
        'description':
            'Developed and launched 3 cross-platform apps using Flutter.',
        'icon': Icons.rocket_launch,
      },
      {
        'title': 'Backend Optimization',
        'description': 'Reduced app load time by 40% by optimizing backend.',
        'icon': Icons.speed,
      },
      {
        'title': 'IoT Integration Expert',
        'description':
            'Implemented 5 IoT integrations with secure authentication.',
        'icon': Icons.devices_other,
      },
      {
        'title': 'Performance Enhancement',
        'description':
            'Improved software performance by 30% through troubleshooting.',
        'icon': Icons.trending_up,
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: achievements
            .map((achievement) => _buildAchievementItem(achievement))
            .toList(),
      ),
    );
  }

  Widget _buildAchievementItem(Map<String, dynamic> achievement) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              achievement['icon'] as IconData,
              color: Colors.blue[700],
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement['title'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  achievement['description'] as String,
                  style: const TextStyle(
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
