import 'package:flutter/material.dart';
import 'package:profitpolio/main.dart';
import 'package:profitpolio/screens/contact.dart';
import 'package:profitpolio/screens/skillsections.dart';

class AnimatedSections extends StatefulWidget {
  const AnimatedSections({super.key});

  @override
  State<AnimatedSections> createState() => _AnimatedSectionsState();
}

class _AnimatedSectionsState extends State<AnimatedSections> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildAnimatedCard(
            icon: Icons.summarize_rounded,
            title: 'Summary',
            child: const SummarySection(),
            delay: 100,
          ),
          _buildAnimatedCard(
            icon: Icons.work_outline_rounded,
            title: 'Experience',
            child: const ExperienceSection(),
            delay: 200,
          ),
          _buildAnimatedCard(
            icon: Icons.code_rounded,
            title: 'Skills',
            child: const EnhancedSkillsSection(),
            delay: 300,
          ),
          _buildAnimatedCard(
            icon: Icons.folder_special_rounded,
            title: 'Projects',
            child: const EnhancedProjectsSection(),
            delay: 400,
          ),
          _buildAnimatedCard(
            icon: Icons.school_outlined,
            title: 'Education',
            child: const EducationSection(),
            delay: 500,
          ),
          _buildAnimatedCard(
            icon: Icons.emoji_events_outlined,
            title: 'Achievements',
            child: const AchievementsSection(),
            delay: 600,
          ),
          _buildAnimatedCard(
            icon: Icons.contact_mail_outlined,
            title: 'Contact',
            child: const EnhancedContactSection(),
            delay: 700,
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedCard({
    required IconData icon,
    required String title,
    required Widget child,
    required int delay,
  }) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: Colors.blue[700],
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            child,
          ],
        ),
      ),
    );
  }
}
