import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;

  const MenuButton({
    super.key,
    required this.title,
    required this.icon,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => Navigator.pushNamed(context, route),
        child: Ink(
          height: 70,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              const SizedBox(width: 20),
              CircleAvatar(
                backgroundColor: color,
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(width: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Icon(Icons.chevron_right, color: color),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }
}
