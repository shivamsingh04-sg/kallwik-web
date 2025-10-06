import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width >= 768 && screenSize.width < 1024;
    final isMobile = screenSize.width < 768;
    final isVerySmallScreen = screenSize.height < 600; // Very small screens

    return Container(
      // Use safe height constraints
      height: _getResponsiveHeight(screenSize),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0F172A), // Dark slate
            const Color(0xFF1E293B).withOpacity(0.9),
            const Color(0xFF334155).withOpacity(0.7),
          ],
        ),
        // Optimized background for mobile performance
        image: isMobile
            ? null
            : const DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1451187580459-43490279c0fa",
                ),
                fit: BoxFit.cover,
                opacity: 0.3,
              ),
      ),
      child: Container(
        // Enhanced overlay with subtle gradient
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.3),
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight > 0
                        ? constraints.maxHeight * 0.8
                        : 400,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 16 : (isTablet ? 32 : 48),
                        vertical: isVerySmallScreen ? 16 : (isMobile ? 24 : 32),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Add top spacer for better centering
                          if (!isVerySmallScreen) const Spacer(flex: 1),

                          // Company name with enhanced typography
                          Text(
                                "Kallwik Technologies",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: _getResponsiveFontSize(
                                    screenSize,
                                    mobile: isVerySmallScreen ? 24 : 28,
                                    tablet: 36,
                                    desktop: 48,
                                  ),
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.5,
                                  height: 1.1,
                                ),
                                textAlign: TextAlign.center,
                              )
                              .animate()
                              .fadeIn(duration: 1000.ms, delay: 200.ms)
                              .slideY(begin: -0.3, curve: Curves.easeOutCubic),

                          SizedBox(height: isVerySmallScreen ? 12 : 20),

                          // Enhanced tagline with better hierarchy
                          Text(
                                "Empowering Digital Transformation",
                                style: TextStyle(
                                  color: const Color(0xFF60A5FA), // Blue accent
                                  fontSize: _getResponsiveFontSize(
                                    screenSize,
                                    mobile: isVerySmallScreen ? 14 : 16,
                                    tablet: 18,
                                    desktop: 24,
                                  ),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                                textAlign: TextAlign.center,
                              )
                              .animate()
                              .fadeIn(duration: 1000.ms, delay: 400.ms)
                              .slideY(begin: 0.2, curve: Curves.easeOutCubic),

                          SizedBox(height: isVerySmallScreen ? 8 : 12),

                          // Main description with better readability
                          Container(
                                constraints: BoxConstraints(
                                  maxWidth: isMobile ? double.infinity : 600,
                                ),
                                child: Text(
                                  isMobile
                                      ? "Building scalable software solutions and modern web applications for the digital age"
                                      : "Building scalable software solutions, modern web applications, and robust cloud infrastructure for the digital age",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: _getResponsiveFontSize(
                                      screenSize,
                                      mobile: isVerySmallScreen ? 12 : 14,
                                      tablet: 16,
                                      desktop: 18,
                                    ),
                                    fontWeight: FontWeight.w400,
                                    height: 1.5,
                                    letterSpacing: 0.2,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                              .animate()
                              .fadeIn(duration: 1000.ms, delay: 600.ms)
                              .slideY(begin: 0.2, curve: Curves.easeOutCubic),

                          SizedBox(height: isVerySmallScreen ? 24 : 32),

                          // Enhanced CTA buttons - Mobile optimized
                          _buildCTASection(isMobile, isVerySmallScreen),

                          SizedBox(height: isVerySmallScreen ? 24 : 40),

                          // Trust indicators/stats - Conditional for very small screens
                          if (!isVerySmallScreen || screenSize.height > 500)
                            _buildTrustIndicators(isMobile)
                                .animate()
                                .fadeIn(duration: 1000.ms, delay: 1200.ms)
                                .slideY(begin: 0.3, curve: Curves.easeOutCubic),

                          // Bottom spacer for better centering
                          if (!isVerySmallScreen) const Spacer(flex: 1),

                          // Minimum bottom spacing
                          SizedBox(height: isVerySmallScreen ? 16 : 24),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  double _getResponsiveHeight(Size screenSize) {
    if (screenSize.width < 768)
      return screenSize.height < 600 ? 500 : 600; // Mobile
    if (screenSize.width < 1024) return 550; // Tablet
    return 650; // Desktop
  }

  double _getResponsiveFontSize(
    Size screenSize, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    if (screenSize.width < 768) return mobile;
    if (screenSize.width < 1024) return tablet;
    return desktop;
  }

  Widget _buildCTASection(bool isMobile, bool isVerySmallScreen) {
    if (isMobile) {
      // Stack buttons vertically on mobile for better touch targets
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: _buildCTAButton(
              text: "Explore Services",
              isPrimary: true,
              onPressed: () {
                debugPrint("Navigate to services");
              },
              delay: 800,
              isFullWidth: true,
              isCompact: isVerySmallScreen,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: _buildCTAButton(
              text: "Get Consultation",
              isPrimary: false,
              onPressed: () {
                debugPrint("Navigate to consultation");
              },
              delay: 1000,
              isFullWidth: true,
              isCompact: isVerySmallScreen,
            ),
          ),
        ],
      );
    } else {
      // Horizontal layout for tablet/desktop
      return Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: [
          _buildCTAButton(
            text: "Explore Services",
            isPrimary: true,
            onPressed: () {
              debugPrint("Navigate to services");
            },
            delay: 800,
            isFullWidth: false,
            isCompact: false,
          ),
          _buildCTAButton(
            text: "Get Consultation",
            isPrimary: false,
            onPressed: () {
              debugPrint("Navigate to consultation");
            },
            delay: 1000,
            isFullWidth: false,
            isCompact: false,
          ),
        ],
      );
    }
  }

  Widget _buildCTAButton({
    required String text,
    required bool isPrimary,
    required VoidCallback onPressed,
    required int delay,
    required bool isFullWidth,
    required bool isCompact,
  }) {
    return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isPrimary
                ? const Color(0xFF3B82F6)
                : Colors.transparent,
            foregroundColor: Colors.white,
            side: isPrimary
                ? null
                : const BorderSide(color: Colors.white, width: 2),
            padding: EdgeInsets.symmetric(
              horizontal: isCompact ? 24 : 32,
              vertical: isCompact ? 12 : 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: isPrimary ? 6 : 0,
            shadowColor: isPrimary
                ? const Color(0xFF3B82F6).withOpacity(0.3)
                : null,
            minimumSize: isFullWidth ? const Size(double.infinity, 48) : null,
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontSize: isCompact ? 14 : 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
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

  Widget _buildTrustIndicators(bool isMobile) {
    return Container(
      constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 500),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStat("15", "Projects", isMobile),
          _buildDivider(),
          _buildStat("1+", "Years", isMobile),
          _buildDivider(),
          _buildStat("24/7", "Support", isMobile),
        ],
      ),
    );
  }

  Widget _buildStat(String number, String label, bool isMobile) {
    return Flexible(
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
              color: const Color(0xFF60A5FA),
              fontSize: isMobile ? 18 : 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: isMobile ? 10 : 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 24,
      width: 1,
      color: Colors.white.withOpacity(0.3),
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}
