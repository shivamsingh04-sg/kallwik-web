import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection>
    with TickerProviderStateMixin {
  late AnimationController _staggerController;

  @override
  void initState() {
    super.initState();
    _staggerController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _staggerController.forward();
  }

  @override
  void dispose() {
    _staggerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenSize = MediaQuery.of(context).size;
    final isSmallMobile = screenSize.width < 480;
    final isMobile = screenSize.width < 768;
    final isTablet = screenSize.width >= 768 && screenSize.width < 1024;
    final isDesktop = screenSize.width >= 1024;

    // Responsive padding
    final horizontalPadding = isSmallMobile
        ? 16.0
        : isMobile
        ? 24.0
        : isTablet
        ? 40.0
        : 80.0;

    final verticalPadding = isSmallMobile
        ? 40.0
        : isMobile
        ? 60.0
        : 100.0;

    final services = [
      {
        "icon": Icons.web_rounded,
        "title": "Web Development",
        "subtitle": "Modern & Responsive",
        "desc":
            "Production-grade websites that bring your ideas to life with cutting-edge technology.",
        "details":
            "We build SEO-friendly, scalable, and high-performance websites using the latest technologies like React, Vue.js, and Node.js. Whether you need a company portfolio, e-commerce platform, or complex web application, we deliver solutions that drive business growth with optimal performance and user experience.",
        "features": [
          "Responsive Design",
          "SEO Optimized",
          "Fast Loading",
          "Secure & Scalable",
        ],
        "color": const Color(0xFF3B82F6),
        "bgGradient": [const Color(0xFF3B82F6), const Color(0xFF1D4ED8)],
      },
      {
        "icon": Icons.phone_android_rounded,
        "title": "Mobile Development",
        "subtitle": "Cross-Platform Excellence",
        "desc":
            "Native-quality apps that work seamlessly across iOS and Android platforms.",
        "details":
            "We specialize in Flutter and React Native development to craft mobile applications that deliver exceptional performance and user experience. Our apps feature native-like performance, offline capabilities, and seamless integration with device features while maintaining a single codebase for cost efficiency.",
        "features": [
          "Cross-Platform",
          "Native Performance",
          "Offline Support",
          "App Store Ready",
        ],
        "color": const Color(0xFF10B981),
        "bgGradient": [const Color(0xFF10B981), const Color(0xFF059669)],
      },
      {
        "icon": Icons.cloud_rounded,
        "title": "Cloud Solutions",
        "subtitle": "Scalable Infrastructure",
        "desc":
            "Enterprise-grade cloud architecture for seamless digital transformation.",
        "details":
            "We provide comprehensive cloud services including architecture design, migration, and DevOps solutions on AWS, Azure, and Google Cloud. Our solutions ensure automatic scaling, high availability, disaster recovery, and cost optimization while maintaining enterprise-level security standards.",
        "features": [
          "Auto Scaling",
          "High Availability",
          "Cost Optimized",
          "Secure & Compliant",
        ],
        "color": const Color(0xFFF59E0B),
        "bgGradient": [const Color(0xFFF59E0B), const Color(0xFFD97706)],
      },
      {
        "icon": Icons.analytics_rounded,
        "title": "Data Analytics",
        "subtitle": "Intelligent Insights",
        "desc":
            "Transform raw data into actionable business intelligence and growth strategies.",
        "details":
            "Our data analytics services include building robust data pipelines, creating interactive visualization dashboards, and implementing machine learning models. We help businesses make data-driven decisions through real-time analytics, predictive modeling, and automated reporting systems.",
        "features": [
          "Real-time Analytics",
          "Predictive Modeling",
          "Custom Dashboards",
          "ML Integration",
        ],
        "color": const Color(0xFF8B5CF6),
        "bgGradient": [const Color(0xFF8B5CF6), const Color(0xFF7C3AED)],
      },
      {
        "icon": Icons.security_rounded,
        "title": "Cybersecurity",
        "subtitle": "Advanced Protection",
        "desc":
            "Comprehensive security solutions to protect your digital assets and data.",
        "details":
            "We implement multi-layered security strategies including vulnerability assessments, penetration testing, compliance auditing, and incident response planning. Our security solutions cover network security, application security, data encryption, and employee training to ensure complete protection.",
        "features": [
          "Threat Assessment",
          "Compliance Audit",
          "24/7 Monitoring",
          "Incident Response",
        ],
        "color": const Color(0xFFEF4444),
        "bgGradient": [const Color(0xFFEF4444), const Color(0xFFDC2626)],
      },
      {
        "icon": Icons.design_services_rounded,
        "title": "UI/UX Design",
        "subtitle": "User-Centered Design",
        "desc":
            "Beautiful, intuitive interfaces that enhance user experience and drive engagement.",
        "details":
            "Our design team creates user-centered experiences through comprehensive research, wireframing, prototyping, and testing. We focus on accessibility, usability, and visual appeal to ensure your digital products not only look great but also provide exceptional user experiences that convert visitors into customers.",
        "features": [
          "User Research",
          "Interactive Prototypes",
          "Accessibility Focus",
          "Brand Alignment",
        ],
        "color": const Color(0xFFEC4899),
        "bgGradient": [const Color(0xFFEC4899), const Color(0xFFDB2777)],
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
        // Subtle tech pattern with better opacity control
        image: DecorationImage(
          image: const NetworkImage(
            "https://images.unsplash.com/photo-1518709268805-4e9042af2176",
          ),
          fit: BoxFit.cover,
          opacity: isDark ? 0.03 : 0.015,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Section Header
              _buildSectionHeader(isDark, isMobile, isSmallMobile),

              SizedBox(
                height: isMobile
                    ? 32
                    : isTablet
                    ? 48
                    : 64,
              ),

              // Services Grid
              _buildServicesGrid(
                context,
                services,
                isDark,
                isSmallMobile,
                isMobile,
                isTablet,
                isDesktop,
              ),

              SizedBox(
                height: isMobile
                    ? 32
                    : isTablet
                    ? 48
                    : 64,
              ),

              // CTA Section
              _buildCTASection(context, isDark, isSmallMobile, isMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(bool isDark, bool isMobile, bool isSmallMobile) {
    return Column(
      children: [
        // Section badge with enhanced animation
        Container(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallMobile ? 16 : 20,
                vertical: isSmallMobile ? 8 : 10,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: const Color(0xFF3B82F6).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                "OUR SERVICES",
                style: TextStyle(
                  fontSize: isSmallMobile ? 12 : 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF3B82F6),
                  letterSpacing: isSmallMobile ? 1.5 : 2.0,
                ),
              ),
            )
            .animate()
            .fadeIn(duration: 800.ms, delay: 200.ms)
            .slideY(begin: -0.3, curve: Curves.easeOutCubic)
            .shimmer(
              duration: 2000.ms,
              delay: 1000.ms,
              color: const Color(0xFF3B82F6).withOpacity(0.3),
            ),

        SizedBox(height: isSmallMobile ? 16 : 20),

        // Main heading with responsive typography
        Text(
              "Comprehensive Digital Solutions",
              style: TextStyle(
                fontSize: isSmallMobile
                    ? 28
                    : isMobile
                    ? 36
                    : 48,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
                height: 1.1,
                letterSpacing: isSmallMobile ? -0.5 : -1.0,
              ),
              textAlign: TextAlign.center,
            )
            .animate()
            .fadeIn(duration: 1000.ms, delay: 400.ms)
            .slideY(begin: 0.3, curve: Curves.easeOutCubic)
            .then()
            .shimmer(duration: 1500.ms, delay: 800.ms),

        SizedBox(height: isSmallMobile ? 12 : 16),

        // Subtitle with better responsive constraints
        Container(
              constraints: BoxConstraints(
                maxWidth: isSmallMobile
                    ? 300
                    : isMobile
                    ? 450
                    : 600,
              ),
              child: Text(
                "Empowering businesses with cutting-edge technology solutions that drive growth, efficiency, and innovation in the digital age.",
                style: TextStyle(
                  fontSize: isSmallMobile
                      ? 16
                      : isMobile
                      ? 17
                      : 18,
                  color: isDark
                      ? Colors.white.withOpacity(0.8)
                      : const Color(0xFF64748B),
                  height: 1.6,
                  letterSpacing: 0.2,
                ),
                textAlign: TextAlign.center,
              ),
            )
            .animate()
            .fadeIn(duration: 1000.ms, delay: 600.ms)
            .slideY(begin: 0.2, curve: Curves.easeOutCubic),
      ],
    );
  }

  Widget _buildServicesGrid(
    BuildContext context,
    List<Map<String, dynamic>> services,
    bool isDark,
    bool isSmallMobile,
    bool isMobile,
    bool isTablet,
    bool isDesktop,
  ) {
    // Enhanced responsive grid logic
    int columns = isSmallMobile
        ? 1
        : isMobile
        ? 1
        : isTablet
        ? 2
        : 3;

    double childAspectRatio = isSmallMobile
        ? 0.85
        : isMobile
        ? 0.9
        : isTablet
        ? 0.85
        : 0.9;

    double crossAxisSpacing = isSmallMobile
        ? 12
        : isMobile
        ? 16
        : 24;
    double mainAxisSpacing = isSmallMobile
        ? 12
        : isMobile
        ? 16
        : 24;

    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: services.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            childAspectRatio: childAspectRatio,
          ),
          itemBuilder: (context, index) {
            return _buildServiceCard(
              context,
              services[index],
              index,
              isDark,
              isSmallMobile,
              isMobile,
            );
          },
        );
      },
    );
  }

  Widget _buildServiceCard(
    BuildContext context,
    Map<String, dynamic> service,
    int index,
    bool isDark,
    bool isSmallMobile,
    bool isMobile,
  ) {
    return TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 300),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.easeOutCubic,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => setState(() {}),
                onExit: (_) => setState(() {}),
                child: GestureDetector(
                  onTap: () => _showServiceDialog(context, service, isDark),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        isSmallMobile ? 16 : 20,
                      ),
                      color: isDark ? const Color(0xFF0F172A) : Colors.white,
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withOpacity(0.1)
                            : Colors.black.withOpacity(0.08),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                          spreadRadius: 0,
                        ),
                        // Additional subtle inner shadow
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.1 : 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                          spreadRadius: -2,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Enhanced gradient overlay
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                isSmallMobile ? 16 : 20,
                              ),
                              gradient: LinearGradient(
                                colors: [
                                  (service["color"] as Color).withOpacity(0.05),
                                  (service["color"] as Color).withOpacity(0.02),
                                  Colors.transparent,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: const [0.0, 0.5, 1.0],
                              ),
                            ),
                          ),
                        ),

                        // Content with responsive padding
                        Padding(
                          padding: EdgeInsets.all(
                            isSmallMobile
                                ? 20
                                : isMobile
                                ? 24
                                : 30,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Icon with enhanced design
                              Container(
                                width: isSmallMobile ? 60 : 70,
                                height: isSmallMobile ? 60 : 70,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors:
                                        service["bgGradient"] as List<Color>,
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    isSmallMobile ? 12 : 16,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: (service["color"] as Color)
                                          .withOpacity(0.4),
                                      blurRadius: 15,
                                      offset: const Offset(0, 6),
                                    ),
                                    // Inner glow effect
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.2),
                                      blurRadius: 8,
                                      offset: const Offset(-2, -2),
                                      spreadRadius: -4,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  service["icon"] as IconData,
                                  size: isSmallMobile ? 28 : 32,
                                  color: Colors.white,
                                ),
                              ),

                              SizedBox(height: isSmallMobile ? 20 : 24),

                              // Title with responsive font size
                              Text(
                                service["title"] as String,
                                style: TextStyle(
                                  fontSize: isSmallMobile ? 20 : 22,
                                  fontWeight: FontWeight.w700,
                                  color: isDark
                                      ? Colors.white
                                      : const Color(0xFF0F172A),
                                  height: 1.2,
                                ),
                              ),

                              const SizedBox(height: 8),

                              // Subtitle
                              Text(
                                service["subtitle"] as String,
                                style: TextStyle(
                                  fontSize: isSmallMobile ? 13 : 14,
                                  fontWeight: FontWeight.w500,
                                  color: service["color"] as Color,
                                  letterSpacing: 0.5,
                                ),
                              ),

                              SizedBox(height: isSmallMobile ? 12 : 16),

                              // Description with flexible sizing
                              Flexible(
                                child: Text(
                                  service["desc"] as String,
                                  style: TextStyle(
                                    fontSize: isSmallMobile ? 14 : 15,
                                    color: isDark
                                        ? Colors.white.withOpacity(0.8)
                                        : const Color(0xFF64748B),
                                    height: 1.5,
                                  ),
                                  maxLines: isSmallMobile ? 3 : 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              // Spacer to push button to bottom
                              const Spacer(),

                              SizedBox(height: isSmallMobile ? 12 : 16),

                              // Enhanced Learn More Button with constrained height
                              SizedBox(
                                width: double.infinity,
                                height: isSmallMobile ? 40 : 44,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      isSmallMobile ? 8 : 10,
                                    ),
                                    border: Border.all(
                                      color: (service["color"] as Color)
                                          .withOpacity(0.3),
                                      width: 1.5,
                                    ),
                                    gradient: LinearGradient(
                                      colors: [
                                        (service["color"] as Color).withOpacity(
                                          0.05,
                                        ),
                                        Colors.transparent,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () => _showServiceDialog(
                                        context,
                                        service,
                                        isDark,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        isSmallMobile ? 8 : 10,
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Learn More",
                                              style: TextStyle(
                                                fontSize: isSmallMobile
                                                    ? 14
                                                    : 15,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    service["color"] as Color,
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Icon(
                                              Icons.arrow_forward_rounded,
                                              size: isSmallMobile ? 14 : 16,
                                              color: service["color"] as Color,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        )
        .animate()
        .fadeIn(
          duration: 800.ms,
          delay: Duration(milliseconds: 300 + (index * 100)),
        )
        .slideY(begin: 0.3, curve: Curves.easeOutCubic)
        .then()
        .shimmer(
          duration: 1500.ms,
          delay: Duration(milliseconds: 800 + (index * 200)),
        );
  }

  Widget _buildCTASection(
    BuildContext context,
    bool isDark,
    bool isSmallMobile,
    bool isMobile,
  ) {
    return Container(
          padding: EdgeInsets.all(
            isSmallMobile
                ? 24
                : isMobile
                ? 30
                : 50,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8), Color(0xFF1E40AF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(isSmallMobile ? 20 : 24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3B82F6).withOpacity(0.4),
                blurRadius: 30,
                offset: const Offset(0, 12),
                spreadRadius: -4,
              ),
              // Additional glow effect
              BoxShadow(
                color: const Color(0xFF3B82F6).withOpacity(0.2),
                blurRadius: 60,
                offset: const Offset(0, 20),
                spreadRadius: -8,
              ),
            ],
          ),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCTAContent(isSmallMobile, isMobile),
                    const SizedBox(height: 20),
                    Center(child: _buildCTAButton(isSmallMobile, isMobile)),
                  ],
                )
              : Row(
                  children: [
                    Expanded(child: _buildCTAContent(isSmallMobile, isMobile)),
                    const SizedBox(width: 30),
                    _buildCTAButton(isSmallMobile, isMobile),
                  ],
                ),
        )
        .animate()
        .fadeIn(duration: 1000.ms, delay: 1200.ms)
        .slideY(begin: 0.3, curve: Curves.easeOutCubic)
        .then()
        .shimmer(duration: 2000.ms, delay: 1000.ms);
  }

  Widget _buildCTAContent(bool isSmallMobile, bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          "Ready to Transform Your Business?",
          style: TextStyle(
            fontSize: isSmallMobile
                ? 20
                : isMobile
                ? 24
                : 32,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.2,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 12),
        Text(
          "Let's discuss your project and create something amazing together.",
          style: TextStyle(
            fontSize: isSmallMobile ? 15 : 16,
            color: Colors.white.withOpacity(0.9),
            height: 1.5,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
      ],
    );
  }

  Widget _buildCTAButton(bool isSmallMobile, bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isSmallMobile ? 10 : 12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          // Inner glow
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            blurRadius: 8,
            offset: const Offset(0, -1),
            spreadRadius: -4,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            debugPrint("Get Started button pressed");
          },
          borderRadius: BorderRadius.circular(isSmallMobile ? 10 : 12),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallMobile
                  ? 24
                  : isMobile
                  ? 28
                  : 30,
              vertical: isSmallMobile ? 14 : 16,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: isSmallMobile ? 15 : 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF3B82F6),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.rocket_launch_rounded,
                  size: isSmallMobile ? 18 : 20,
                  color: const Color(0xFF3B82F6),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showServiceDialog(
    BuildContext context,
    Map<String, dynamic> service,
    bool isDark,
  ) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallMobile = screenSize.width < 480;
    final isMobile = screenSize.width < 768;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.all(isSmallMobile ? 12 : 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isMobile ? double.infinity : 700,
                  maxHeight: screenSize.height * 0.9,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E293B) : Colors.white,
                    borderRadius: BorderRadius.circular(
                      isSmallMobile ? 20 : 24,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 40,
                        offset: const Offset(0, 20),
                        spreadRadius: -8,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Enhanced header
                      Container(
                        height: isSmallMobile ? 120 : 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              ...(service["bgGradient"] as List<Color>),
                              (service["bgGradient"] as List<Color>)[1]
                                  .withOpacity(0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(isSmallMobile ? 20 : 24),
                          ),
                        ),
                        child: Stack(
                          children: [
                            // Decorative elements
                            Positioned(
                              top: -20,
                              right: -20,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.1),
                                ),
                              ),
                            ),

                            // Close button
                            Positioned(
                              top: 16,
                              right: 16,
                              child: IconButton(
                                onPressed: () => Navigator.pop(ctx),
                                icon: const Icon(
                                  Icons.close_rounded,
                                  color: Colors.white,
                                ),
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(
                                    0.2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),

                            // Icon and title
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Icon(
                                      service["icon"] as IconData,
                                      size: isSmallMobile ? 40 : 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    service["title"] as String,
                                    style: TextStyle(
                                      fontSize: isSmallMobile ? 20 : 24,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Content
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.all(isSmallMobile ? 20 : 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                service["details"] as String,
                                style: TextStyle(
                                  fontSize: isSmallMobile ? 15 : 16,
                                  color: isDark
                                      ? Colors.white.withOpacity(0.9)
                                      : const Color(0xFF374151),
                                  height: 1.6,
                                ),
                              ),
                              SizedBox(height: isSmallMobile ? 24 : 30),

                              Text(
                                "Key Features",
                                style: TextStyle(
                                  fontSize: isSmallMobile ? 18 : 20,
                                  fontWeight: FontWeight.w700,
                                  color: isDark
                                      ? Colors.white
                                      : const Color(0xFF0F172A),
                                ),
                              ),
                              SizedBox(height: isSmallMobile ? 12 : 16),

                              // Enhanced features list
                              ...(service["features"] as List<String>)
                                  .asMap()
                                  .entries
                                  .map(
                                    (entry) => Padding(
                                      padding: EdgeInsets.only(
                                        bottom: isSmallMobile ? 10 : 12,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: isSmallMobile ? 20 : 24,
                                            height: isSmallMobile ? 20 : 24,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  service["color"] as Color,
                                                  (service["color"] as Color)
                                                      .withOpacity(0.7),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                      (service["color"]
                                                              as Color)
                                                          .withOpacity(0.3),
                                                  blurRadius: 6,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Icon(
                                              Icons.check_rounded,
                                              size: isSmallMobile ? 14 : 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: isSmallMobile ? 10 : 12,
                                          ),
                                          Expanded(
                                            child: Text(
                                              entry.value,
                                              style: TextStyle(
                                                fontSize: isSmallMobile
                                                    ? 15
                                                    : 16,
                                                color: isDark
                                                    ? Colors.white.withOpacity(
                                                        0.8,
                                                      )
                                                    : const Color(0xFF374151),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ],
                          ),
                        ),
                      ),

                      // Enhanced footer
                      Container(
                        padding: EdgeInsets.all(isSmallMobile ? 20 : 30),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF0F172A).withOpacity(0.5)
                              : const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(isSmallMobile ? 20 : 24),
                          ),
                        ),
                        child: isMobile
                            ? Column(
                                children: [
                                  _buildDialogButton(
                                    "Close",
                                    false,
                                    service,
                                    () => Navigator.pop(ctx),
                                    isSmallMobile,
                                  ),
                                  const SizedBox(height: 12),
                                  _buildDialogButton(
                                    "Contact us",
                                    true,
                                    service,
                                    () {
                                      Navigator.pop(ctx);
                                      debugPrint(
                                        "Get Quote for ${service["title"]}",
                                      );
                                    },
                                    isSmallMobile,
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: _buildDialogButton(
                                      "Close",
                                      false,
                                      service,
                                      () => Navigator.pop(ctx),
                                      isSmallMobile,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildDialogButton(
                                      "Contact us",
                                      true,
                                      service,
                                      () {
                                        Navigator.pop(ctx);
                                        debugPrint(
                                          "Get Quote for ${service["title"]}",
                                        );
                                      },
                                      isSmallMobile,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .animate()
            .fadeIn(duration: 300.ms)
            .scale(begin: const Offset(0.9, 0.9), curve: Curves.easeOutBack);
      },
    );
  }

  Widget _buildDialogButton(
    String text,
    bool isPrimary,
    Map<String, dynamic> service,
    VoidCallback onPressed,
    bool isSmallMobile,
  ) {
    if (isPrimary) {
      return Container(
        width: double.infinity,
        height: isSmallMobile ? 48 : 52,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: service["bgGradient"] as List<Color>,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: (service["color"] as Color).withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(12),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: isSmallMobile ? 15 : 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.send_rounded, size: 18, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        height: isSmallMobile ? 48 : 52,
        decoration: BoxDecoration(
          border: Border.all(
            color: (service["color"] as Color).withOpacity(0.3),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          color: Colors.transparent,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(12),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: isSmallMobile ? 15 : 16,
                  fontWeight: FontWeight.w600,
                  color: service["color"] as Color,
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
