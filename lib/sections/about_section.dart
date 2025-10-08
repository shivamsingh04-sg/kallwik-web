import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 768;
    final isTablet = screenSize.width >= 768 && screenSize.width < 1024;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : (isTablet ? 40 : 80),
        vertical: isMobile ? 60 : 100,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
        image: DecorationImage(
          image: const NetworkImage(
            "https://images.unsplash.com/photo-1557804506-669a67965ba0",
          ),
          fit: BoxFit.cover,
          opacity: isDark ? 0.03 : 0.02,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isMobile
              ? _buildMobileLayout(context, theme, isDark)
              : _buildDesktopLayout(context, theme, isDark),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    ThemeData theme,
    bool isDark,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 1, child: _buildImageSection(context, theme, isDark)),
        const SizedBox(width: 80),
        Expanded(flex: 1, child: _buildContentSection(context, theme, isDark)),
      ],
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    ThemeData theme,
    bool isDark,
  ) {
    return Column(
      children: [
        _buildContentSection(context, theme, isDark),
        const SizedBox(height: 40),
        _buildImageSection(context, theme, isDark),
      ],
    );
  }

  Widget _buildImageSection(
    BuildContext context,
    ThemeData theme,
    bool isDark,
  ) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 768;

    return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.15),
                blurRadius: 30,
                offset: const Offset(0, 10),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Stack(
            children: [
              // Main image
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Image.network(
                    "https://images.unsplash.com/photo-1600880292203-757bb62b4baf",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: isDark
                            ? const Color(0xFF1E293B)
                            : const Color(0xFFE2E8F0),
                        child: Icon(
                          Icons.business,
                          size: 80,
                          color: isDark ? Colors.white24 : Colors.black26,
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Gradient overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.4),
                      ],
                    ),
                  ),
                ),
              ),

              // Enhanced animated overlay
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: _buildAnimatedOverlay(isDark, isMobile),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 1000.ms, delay: 200.ms)
        .slideX(begin: -0.3, curve: Curves.easeOutCubic);
  }

  Widget _buildAnimatedOverlay(bool isDark, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.95),
            Colors.white.withOpacity(0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Title with shimmer
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                    Icons.workspace_premium_rounded,
                    color: const Color(0xFF3B82F6),
                    size: isMobile ? 18 : 20,
                  )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(duration: 2000.ms, color: const Color(0xFF60A5FA))
                  .rotate(
                    duration: 3000.ms,
                    begin: 0,
                    end: 0.05,
                    curve: Curves.easeInOut,
                  ),
              SizedBox(width: isMobile ? 6 : 8),
              Text(
                "Why Choose Us",
                style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 12 : 16),
          // Animated feature badges
          Wrap(
            alignment: WrapAlignment.center,
            spacing: isMobile ? 8 : 12,
            runSpacing: isMobile ? 8 : 12,
            children: [
              _buildFeatureBadge(
                icon: Icons.rocket_launch_rounded,
                label: "Fast Delivery",
                color: const Color(0xFF3B82F6),
                delay: 300,
                isMobile: isMobile,
              ),
              _buildFeatureBadge(
                icon: Icons.verified_user_rounded,
                label: "Trusted",
                color: const Color(0xFF10B981),
                delay: 500,
                isMobile: isMobile,
              ),
              _buildFeatureBadge(
                icon: Icons.star_rounded,
                label: "Excellence",
                color: const Color(0xFFF59E0B),
                delay: 700,
                isMobile: isMobile,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureBadge({
    required IconData icon,
    required String label,
    required Color color,
    required int delay,
    required bool isMobile,
  }) {
    return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 10 : 12,
            vertical: isMobile ? 6 : 8,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.15), color.withOpacity(0.05)],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withOpacity(0.3), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: isMobile ? 14 : 16)
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(
                    duration: 2000.ms,
                    color: Colors.white.withOpacity(0.5),
                    delay: Duration(milliseconds: delay),
                  )
                  .scale(
                    duration: 2000.ms,
                    begin: const Offset(1.0, 1.0),
                    end: const Offset(1.1, 1.1),
                    curve: Curves.easeInOut,
                  )
                  .then()
                  .scale(
                    duration: 2000.ms,
                    begin: const Offset(1.1, 1.1),
                    end: const Offset(1.0, 1.0),
                    curve: Curves.easeInOut,
                  ),
              SizedBox(width: isMobile ? 4 : 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: isMobile ? 11 : 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(
          duration: 600.ms,
          delay: Duration(milliseconds: delay),
        )
        .scale(
          begin: const Offset(0.8, 0.8),
          curve: Curves.easeOutBack,
          delay: Duration(milliseconds: delay),
        )
        .then(delay: 200.ms)
        .shimmer(duration: 2500.ms, color: color.withOpacity(0.3));
  }

  Widget _buildContentSection(
    BuildContext context,
    ThemeData theme,
    bool isDark,
  ) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 768;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section badge
        Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF3B82F6).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                "ABOUT US",
                style: TextStyle(
                  fontSize: isMobile ? 10 : 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF3B82F6),
                  letterSpacing: 1.5,
                ),
              ),
            )
            .animate()
            .fadeIn(duration: 800.ms, delay: 400.ms)
            .slideY(begin: 0.2, curve: Curves.easeOutCubic),

        SizedBox(height: isMobile ? 16 : 24),

        // Main heading
        Text(
              "Empowering Digital Innovation",
              style: TextStyle(
                fontSize: isMobile ? 28 : 42,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
                height: 1.2,
                letterSpacing: -0.5,
              ),
            )
            .animate()
            .fadeIn(duration: 1000.ms, delay: 600.ms)
            .slideY(begin: 0.3, curve: Curves.easeOutCubic),

        SizedBox(height: isMobile ? 12 : 16),

        // Subheading
        Text(
              "Building Tomorrow's Technology Today",
              style: TextStyle(
                fontSize: isMobile ? 16 : 20,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF3B82F6),
                letterSpacing: 0.3,
              ),
            )
            .animate()
            .fadeIn(duration: 1000.ms, delay: 800.ms)
            .slideY(begin: 0.2, curve: Curves.easeOutCubic),

        SizedBox(height: isMobile ? 20 : 32),

        // Main description
        Text(
              "Kallwik Technologies is a forward-thinking software company that specializes in building scalable, user-friendly, and innovative digital solutions. Our team of experts is committed to helping businesses transform and grow through cutting-edge technology.",
              style: TextStyle(
                fontSize: isMobile ? 15 : 18,
                color: isDark
                    ? Colors.white.withOpacity(0.8)
                    : const Color(0xFF64748B),
                height: 1.7,
                letterSpacing: 0.2,
              ),
            )
            .animate()
            .fadeIn(duration: 1000.ms, delay: 1000.ms)
            .slideY(begin: 0.2, curve: Curves.easeOutCubic),

        SizedBox(height: isMobile ? 20 : 24),

        // Key points
        Column(
          children: [
            _buildKeyPoint(
              "🚀 Innovation-Driven",
              "Leveraging cutting-edge technologies to deliver exceptional results",
              isDark,
              1200,
              isMobile,
            ),
            SizedBox(height: isMobile ? 12 : 16),
            _buildKeyPoint(
              "🎯 Client-Focused",
              "Tailored solutions that align with your business objectives",
              isDark,
              1400,
              isMobile,
            ),
            SizedBox(height: isMobile ? 12 : 16),
            _buildKeyPoint(
              "⚡ Performance Optimized",
              "Scalable architecture designed for growth and efficiency",
              isDark,
              1600,
              isMobile,
            ),
          ],
        ),

        SizedBox(height: isMobile ? 30 : 40),

        // CTA Buttons
        isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildCTAButton(
                    "Learn More",
                    const Color(0xFF3B82F6),
                    Colors.white,
                    true,
                    1800,
                    isMobile,
                  ),
                  const SizedBox(height: 12),
                  _buildCTAButton(
                    "Our Portfolio",
                    Colors.transparent,
                    isDark ? Colors.white : const Color(0xFF0F172A),
                    false,
                    2000,
                    isMobile,
                  ),
                ],
              )
            : Row(
                children: [
                  _buildCTAButton(
                    "Learn More",
                    const Color(0xFF3B82F6),
                    Colors.white,
                    true,
                    1800,
                    isMobile,
                  ),
                  const SizedBox(width: 16),
                  _buildCTAButton(
                    "Our Portfolio",
                    Colors.transparent,
                    isDark ? Colors.white : const Color(0xFF0F172A),
                    false,
                    2000,
                    isMobile,
                  ),
                ],
              ),
      ],
    );
  }

  Widget _buildKeyPoint(
    String title,
    String description,
    bool isDark,
    int delay,
    bool isMobile,
  ) {
    return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.only(top: 8, right: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: isMobile ? 13 : 14,
                      color: isDark
                          ? Colors.white.withOpacity(0.7)
                          : const Color(0xFF64748B),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
        .animate()
        .fadeIn(
          duration: 800.ms,
          delay: Duration(milliseconds: delay),
        )
        .slideX(begin: 0.2, curve: Curves.easeOutCubic);
  }

  Widget _buildCTAButton(
    String text,
    Color bgColor,
    Color textColor,
    bool isPrimary,
    int delay,
    bool isMobile,
  ) {
    return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: isPrimary
                ? const LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                  )
                : null,
            border: isPrimary
                ? null
                : Border.all(color: textColor.withOpacity(0.3), width: 2),
            boxShadow: isPrimary
                ? [
                    BoxShadow(
                      color: const Color(0xFF3B82F6).withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                debugPrint("$text button pressed");
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20 : 24,
                  vertical: isMobile ? 14 : 12,
                ),
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: isMobile ? 14 : 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(
          duration: 800.ms,
          delay: Duration(milliseconds: delay),
        )
        .scale(begin: const Offset(0.9, 0.9), curve: Curves.easeOutBack);
  }
}
