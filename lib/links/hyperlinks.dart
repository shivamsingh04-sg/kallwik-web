import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class EnhancedHyperLink extends StatefulWidget {
  final String text;
  final String url;
  final bool isLegal;
  final Duration delay;
  final bool isExternal;

  const EnhancedHyperLink({
    super.key,
    required this.text,
    required this.url,
    this.isLegal = false,
    this.delay = Duration.zero,
    this.isExternal = false,
  });

  @override
  State<EnhancedHyperLink> createState() => _EnhancedHyperLinkState();
}

class _EnhancedHyperLinkState extends State<EnhancedHyperLink> {
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
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                    vertical: widget.isLegal ? 4 : 8,
                    horizontal: widget.isLegal ? 0 : 4,
                  ),
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? Colors.white.withOpacity(0.05)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: _isHovered && !widget.isLegal
                        ? Border.all(color: Colors.white.withOpacity(0.1))
                        : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!widget.isLegal && _isHovered)
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            size: 14,
                            color: const Color(0xFF3B82F6),
                          ),
                        ),
                      Text(
                        widget.text,
                        style: TextStyle(
                          color: _isHovered
                              ? const Color(0xFF3B82F6)
                              : Colors.white.withOpacity(
                                  widget.isLegal ? 0.6 : 0.8,
                                ),
                          fontSize: widget.isLegal ? 12 : 14,
                          fontWeight: widget.isLegal
                              ? FontWeight.w500
                              : FontWeight.w600,
                          decoration: _isHovered
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          decorationColor: const Color(0xFF3B82F6),
                        ),
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
