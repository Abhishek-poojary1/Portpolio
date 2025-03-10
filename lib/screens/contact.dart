import 'package:flutter/material.dart';

class EnhancedContactSection extends StatelessWidget {
  const EnhancedContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildContactItem(
            icon: Icons.email_outlined,
            title: 'Email',
            subtitle: 'poojaryabhishek26@gmail.com',
            onTap: () {},
          ),
          const Divider(),
          _buildContactItem(
            icon: Icons.phone_outlined,
            title: 'Phone',
            subtitle: '+91 9945726449',
            onTap: () {},
          ),
          const Divider(),
          _buildContactItem(
            icon: Icons.location_on_outlined,
            title: 'Location',
            subtitle: 'Bengaluru, Karnataka',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Colors.blue[700],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
