import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class EnhancedServiceLink extends StatefulWidget {
  final String text;
  final String url;
  final IconData icon;
  final Duration delay;

  const EnhancedServiceLink({
    super.key,
    required this.text,
    required this.url,
    required this.icon,
    this.delay = Duration.zero,
  });

  @override
  State<EnhancedServiceLink> createState() => _EnhancedServiceLinkState();
}

class _EnhancedServiceLinkState extends State<EnhancedServiceLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _launchURL(widget.url),
        child:
            AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? Colors.white.withOpacity(0.08)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: _isHovered
                        ? Border.all(color: Colors.white.withOpacity(0.15))
                        : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: _isHovered
                              ? const Color(0xFF3B82F6).withOpacity(0.2)
                              : Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          widget.icon,
                          size: 16,
                          color: _isHovered
                              ? const Color(0xFF3B82F6)
                              : Colors.white.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.text,
                          style: TextStyle(
                            color: _isHovered
                                ? const Color(0xFF3B82F6)
                                : Colors.white.withOpacity(0.8),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            decoration: _isHovered
                                ? TextDecoration.underline
                                : TextDecoration.none,
                            decorationColor: const Color(0xFF3B82F6),
                          ),
                        ),
                      ),
                      if (_isHovered)
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 12,
                          color: const Color(0xFF3B82F6),
                        ),
                    ],
                  ),
                )
                .animate(delay: widget.delay)
                .fadeIn(duration: 600.ms)
                .slideX(begin: -0.1, curve: Curves.easeOutCubic),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    try {
      final uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }
}
