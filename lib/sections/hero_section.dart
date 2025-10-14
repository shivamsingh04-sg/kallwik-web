import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentIndex = 0;

  final List<Map<String, String>> _slides = [
    {
      'title': 'Kallwik Technologies',
      'subtitle': 'Empowering Digital Transformation',
      'image': 'https://images.unsplash.com/photo-1451187580459-43490279c0fa',
    },
    {
      'title': 'Smart Software Solutions',
      'subtitle': 'Delivering scalable products for the digital age',
      'image': 'https://images.unsplash.com/photo-1525182008055-f88b95ff7980',
    },
    {
      'title': 'Innovate. Build. Grow.',
      'subtitle': 'Turning ideas into world-class digital products',
      'image': 'https://images.unsplash.com/photo-1519389950473-47ba0277781c',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width >= 768 && screenSize.width < 1024;
    final isMobile = screenSize.width < 768;
    final isVerySmallScreen = screenSize.height < 600;

    return Stack(
      children: [
        // 🖼 Background Carousel
        CarouselSlider.builder(
          itemCount: _slides.length,
          carouselController: _carouselController,
          options: CarouselOptions(
            height: _getResponsiveHeight(screenSize),
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 6),
            autoPlayAnimationDuration: const Duration(milliseconds: 1500),
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
          itemBuilder: (context, index, realIndex) {
            final slide = _slides[index];
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(slide['image']!),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
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
              ),
            );
          },
        ),

        // 🖋 Content Overlay
        Positioned.fill(
          child: SafeArea(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : (isTablet ? 32 : 48),
                vertical: isVerySmallScreen ? 16 : (isMobile ? 24 : 32),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                        _slides[_currentIndex]['title']!,
                        textAlign: TextAlign.center,
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
                      )
                      .animate()
                      .fadeIn(duration: 800.ms, delay: 200.ms)
                      .slideY(begin: -0.3, curve: Curves.easeOutCubic),

                  SizedBox(height: isVerySmallScreen ? 12 : 20),

                  Text(
                        _slides[_currentIndex]['subtitle']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF60A5FA),
                          fontSize: _getResponsiveFontSize(
                            screenSize,
                            mobile: isVerySmallScreen ? 14 : 16,
                            tablet: 18,
                            desktop: 24,
                          ),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 800.ms, delay: 400.ms)
                      .slideY(begin: 0.2, curve: Curves.easeOutCubic),

                  SizedBox(height: isVerySmallScreen ? 12 : 16),

                  Text(
                        "Building scalable software solutions, modern web apps, and robust cloud infrastructure for the digital age",
                        textAlign: TextAlign.center,
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
                      )
                      .animate()
                      .fadeIn(duration: 800.ms, delay: 600.ms)
                      .slideY(begin: 0.2, curve: Curves.easeOutCubic),

                  const SizedBox(height: 32),

                  _buildCTASection(isMobile, isVerySmallScreen),

                  const SizedBox(height: 40),

                  _buildAnimatedFeatures(isMobile, isVerySmallScreen)
                      .animate()
                      .fadeIn(duration: 1000.ms, delay: 1200.ms)
                      .slideY(begin: 0.3, curve: Curves.easeOutCubic),

                  const SizedBox(height: 24),

                  // 🟦 Carousel Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _slides.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () =>
                            _carouselController.animateToPage(entry.key),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: _currentIndex == entry.key ? 24 : 8,
                          decoration: BoxDecoration(
                            color: _currentIndex == entry.key
                                ? Colors.white
                                : Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  double _getResponsiveHeight(Size screenSize) {
    if (screenSize.width < 768) return screenSize.height < 600 ? 500 : 600;
    if (screenSize.width < 1024) return 550;
    return 650;
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

  // 🟩 CTA Section (same as your version)
  Widget _buildCTASection(bool isMobile, bool isVerySmallScreen) {
    if (isMobile) {
      return Column(
        children: [
          _buildCTAButton(
            text: "Explore Services",
            isPrimary: true,
            onPressed: () => debugPrint("Navigate to services"),
            delay: 800,
            isFullWidth: true,
            isCompact: isVerySmallScreen,
          ),
          const SizedBox(height: 12),
          _buildCTAButton(
            text: "Get Consultation",
            isPrimary: false,
            onPressed: () => debugPrint("Navigate to consultation"),
            delay: 1000,
            isFullWidth: true,
            isCompact: isVerySmallScreen,
          ),
        ],
      );
    } else {
      return Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: [
          _buildCTAButton(
            text: "Explore Services",
            isPrimary: true,
            onPressed: () => debugPrint("Navigate to services"),
            delay: 800,
            isFullWidth: false,
            isCompact: false,
          ),
          _buildCTAButton(
            text: "Get Consultation",
            isPrimary: false,
            onPressed: () => debugPrint("Navigate to consultation"),
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

  // 💡 Feature chips (unchanged)
  Widget _buildAnimatedFeatures(bool isMobile, bool isVerySmallScreen) {
    final features = [
      {
        'icon': Icons.speed_rounded,
        'label': 'Lightning Fast',
        'color': const Color(0xFF60A5FA),
      },
      {
        'icon': Icons.security_rounded,
        'label': 'Secure',
        'color': const Color(0xFF34D399),
      },
      {
        'icon': Icons.auto_awesome_rounded,
        'label': 'Innovative',
        'color': const Color(0xFFFBBF24),
      },
      {
        'icon': Icons.trending_up_rounded,
        'label': 'Scalable',
        'color': const Color(0xFFF472B6),
      },
    ];

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: isMobile ? 12 : 20,
      runSpacing: isMobile ? 12 : 16,
      children: features.asMap().entries.map((entry) {
        final index = entry.key;
        final feature = entry.value;

        return _buildFeatureChip(
          icon: feature['icon'] as IconData,
          label: feature['label'] as String,
          color: feature['color'] as Color,
          delay: 1400 + (index * 150),
          isMobile: isMobile,
          isVerySmallScreen: isVerySmallScreen,
        );
      }).toList(),
    );
  }

  Widget _buildFeatureChip({
    required IconData icon,
    required String label,
    required Color color,
    required int delay,
    required bool isMobile,
    required bool isVerySmallScreen,
  }) {
    return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.15), color.withOpacity(0.05)],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isVerySmallScreen ? 12 : (isMobile ? 16 : 20),
            vertical: isVerySmallScreen ? 8 : (isMobile ? 10 : 12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: color,
                size: isVerySmallScreen ? 16 : (isMobile ? 18 : 20),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isVerySmallScreen ? 12 : (isMobile ? 13 : 14),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(
          duration: 800.ms,
          delay: Duration(milliseconds: delay),
        )
        .scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutBack);
  }
}
