import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animations/animations.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _floatingController;
  late AnimationController _pulseController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _floatingAnimation;
  late Animation<double> _pulseAnimation;

  final TextEditingController _emailController = TextEditingController();
  bool _isEmailValid = false;
  bool _isSubscribing = false;

  // Hover states for different elements
  bool _logoHovered = false;
  bool _newsletterHovered = false;
  final Map<String, bool> _linkHoverStates = {};
  final Map<String, bool> _socialHoverStates = {};
  final Map<String, bool> _contactHoverStates = {};

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _emailController.addListener(_validateEmail);
  }

  void _initializeAnimations() {
    // Main entrance animation
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Floating animation for subtle movement
    _floatingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    // Pulse animation for interactive elements
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _mainController,
            curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
          ),
        );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.4, 1.0, curve: Curves.elasticOut),
      ),
    );

    _floatingAnimation = Tween<double>(begin: -8.0, end: 8.0).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Start animations
    _mainController.forward();
    _floatingController.repeat(reverse: true);
    _pulseController.repeat(reverse: true);
  }

  void _validateEmail() {
    final email = _emailController.text;
    final isValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
    if (isValid != _isEmailValid) {
      setState(() => _isEmailValid = isValid);
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    _floatingController.dispose();
    _pulseController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final isTablet = size.width >= 768 && size.width < 1024;

    return AnimatedBuilder(
      animation: Listenable.merge([_mainController, _floatingController]),
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                  ),
                ),
                child: Column(
                  children: [
                    Transform.translate(
                      offset: Offset(0, _floatingAnimation.value * 0.3),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 16 : (isTablet ? 40 : 80),
                          vertical: isMobile ? 40 : 60,
                        ),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: _buildLayout(isMobile, isTablet),
                        ),
                      ),
                    ),
                    _buildBottomBar(isMobile),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLayout(bool isMobile, bool isTablet) {
    if (isMobile) {
      return Column(
        children: [
          _buildAnimatedSection(_buildCompanySection(isMobile), 0),
          const SizedBox(height: 40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildAnimatedSection(_buildQuickLinksSection(), 1),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: _buildAnimatedSection(_buildContactSection(isMobile), 2),
              ),
            ],
          ),
          const SizedBox(height: 40),
          _buildAnimatedSection(_buildNewsletterSection(isMobile), 3),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _buildAnimatedSection(_buildCompanySection(isMobile), 0),
        ),
        const SizedBox(width: 48),
        Expanded(child: _buildAnimatedSection(_buildQuickLinksSection(), 1)),
        const SizedBox(width: 48),
        Expanded(
          child: _buildAnimatedSection(_buildContactSection(isMobile), 2),
        ),
        const SizedBox(width: 48),
        Expanded(
          flex: 2,
          child: _buildAnimatedSection(_buildNewsletterSection(isMobile), 3),
        ),
      ],
    );
  }

  Widget _buildAnimatedSection(Widget child, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 800 + (index * 200)),
      curve: Curves.easeOutCubic,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, _) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 30),
          child: Opacity(opacity: value, child: child),
        );
      },
    );
  }

  Widget _buildCompanySection(bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        // Animated Logo and Company Name
        _buildAnimatedLogo(isMobile),
        const SizedBox(height: 24),

        // Animated Description
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 1500),
          curve: Curves.easeOut,
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, (1 - value) * 20),
                child: Text(
                  "Empowering businesses with cutting-edge technology solutions. We build scalable, secure, and innovative digital products.",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                    height: 1.6,
                  ),
                  textAlign: isMobile ? TextAlign.center : TextAlign.left,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 32),

        // Animated Social Media
        _buildAnimatedSocialSection(isMobile),
      ],
    );
  }

  Widget _buildAnimatedLogo(bool isMobile) {
    return MouseRegion(
      onEnter: (_) => setState(() => _logoHovered = true),
      onExit: (_) => setState(() => _logoHovered = false),
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            transform: Matrix4.identity()
              ..scale(_logoHovered ? 1.05 : 1.0)
              ..scale(_pulseAnimation.value),
            child: Row(
              mainAxisAlignment: isMobile
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: _logoHovered
                          ? [const Color(0xFF60A5FA), const Color(0xFF3B82F6)]
                          : [const Color(0xFF3B82F6), const Color(0xFF1D4ED8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(
                          0xFF3B82F6,
                        ).withOpacity(_logoHovered ? 0.5 : 0.3),
                        blurRadius: _logoHovered ? 25 : 20,
                        offset: const Offset(0, 8),
                        spreadRadius: _logoHovered ? 2 : 0,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "KW",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        color: _logoHovered
                            ? const Color(0xFF60A5FA)
                            : Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                      child: const Text("KALLWIK"),
                    ),
                    Text(
                      "TECHNOLOGIES",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedSocialSection(bool isMobile) {
    final socialButtons = [
      {
        "icon": Icons.facebook,
        "color": const Color(0xFF1877F2),
        "url": "https://facebook.com/kallwik-technologies-104510001",
        "key": "facebook",
      },
      {
        "icon": Icons.business,
        "color": const Color(0xFF0A66C2),
        "url": "https://www.linkedin.com/company/kallwik-technologies/",
        "key": "linkedin",
      },
      {
        "icon": Icons.alternate_email,
        "color": const Color(0xFF1DA1F2),
        "url": "https://twitter.com/kallwik-technologies",
        "key": "twitter",
      },
      {
        "icon": Icons.code,
        "color": const Color(0xFF6e5494),
        "url": "https://github.com/kallwik-technologies",
        "key": "github",
      },
    ];

    return Wrap(
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      spacing: 16,
      children: socialButtons.asMap().entries.map((entry) {
        final index = entry.key;
        final social = entry.value;
        return _buildAnimatedSocialButton(
          social["icon"] as IconData,
          social["color"] as Color,
          social["url"] as String,
          social["key"] as String,
          index,
        );
      }).toList(),
    );
  }

  Widget _buildAnimatedSocialButton(
    IconData icon,
    Color color,
    String url,
    String key,
    int index,
  ) {
    final isHovered = _socialHoverStates[key] ?? false;

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + (index * 100)),
      curve: Curves.elasticOut,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => _socialHoverStates[key] = true),
            onExit: (_) => setState(() => _socialHoverStates[key] = false),
            child: GestureDetector(
              onTap: () => _launchURL(url),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                width: 48,
                height: 48,
                transform: Matrix4.identity()
                  ..translate(0.0, isHovered ? -4.0 : 0.0)
                  ..scale(isHovered ? 1.1 : 1.0),
                decoration: BoxDecoration(
                  color: isHovered
                      ? color.withOpacity(0.2)
                      : color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isHovered
                        ? color.withOpacity(0.6)
                        : color.withOpacity(0.3),
                    width: isHovered ? 2 : 1,
                  ),
                  boxShadow: isHovered
                      ? [
                          BoxShadow(
                            color: color.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  icon,
                  color: isHovered ? color : color.withOpacity(0.8),
                  size: isHovered ? 26 : 24,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickLinksSection() {
    final links = [
      {"title": "Home", "url": "/"},
      {"title": "About", "url": "/about"},
      {"title": "Services", "url": "/services"},
      {"title": "Portfolio", "url": "/portfolio"},
      {"title": "Contact", "url": "/contact"},
      {"title": "Blog", "url": "/blog"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Quick Links",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        ...links.asMap().entries.map((entry) {
          final index = entry.key;
          final link = entry.value;
          return _buildAnimatedLink(
            link["title"]!,
            link["url"]!,
            "link_${index}",
            index,
          );
        }),
      ],
    );
  }

  Widget _buildAnimatedLink(String title, String url, String key, int index) {
    final isHovered = _linkHoverStates[key] ?? false;

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + (index * 80)),
      curve: Curves.easeOutCubic,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset((1 - value) * -30, 0),
          child: Opacity(
            opacity: value,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => setState(() => _linkHoverStates[key] = true),
                onExit: (_) => setState(() => _linkHoverStates[key] = false),
                child: GestureDetector(
                  onTap: () => _launchURL(url),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    transform: Matrix4.identity()
                      ..translate(isHovered ? 8.0 : 0.0, 0.0),
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        color: isHovered
                            ? const Color(0xFF60A5FA)
                            : Colors.white.withOpacity(0.8),
                        fontSize: 14,
                        fontWeight: isHovered
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: isHovered ? 6 : 0,
                            height: 2,
                            decoration: BoxDecoration(
                              color: const Color(0xFF60A5FA),
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                          if (isHovered) const SizedBox(width: 8),
                          Text(title),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContactSection(bool isMobile) {
    final contacts = [
      {
        "icon": Icons.location_on,
        "text": "Indore, MP, India",
        "url":
            "https://www.google.co.in/maps/@22.694761,75.8291332,648m/data=!3m1!1e3?entry=ttu&g_ep=EgoyMDI1MTAwMS4wIKXMDSoASAFQAw%3D%3D",
        "key": "location",
      },
      {
        "icon": Icons.email,
        "text": "hr@kallwik.com",
        "url": "mailto:hr@kallwik.com",
        "key": "email",
      },
      {
        "icon": Icons.phone,
        "text": "+91 9827338178",
        "url": "tel:+919827338178",
        "key": "phone",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Contact Info",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        ...contacts.asMap().entries.map((entry) {
          final index = entry.key;
          final contact = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildAnimatedContactItem(
              contact["icon"] as IconData,
              contact["text"] as String,
              contact["url"] as String,
              contact["key"] as String,
              index,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildAnimatedContactItem(
    IconData icon,
    String text,
    String url,
    String key,
    int index,
  ) {
    final isHovered = _contactHoverStates[key] ?? false;

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 500 + (index * 100)),
      curve: Curves.easeOutCubic,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset((1 - value) * 40, 0),
          child: Opacity(
            opacity: value,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => _contactHoverStates[key] = true),
              onExit: (_) => setState(() => _contactHoverStates[key] = false),
              child: GestureDetector(
                onTap: () => _launchURL(url),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,
                  transform: Matrix4.identity()
                    ..translate(isHovered ? 8.0 : 0.0, 0.0),
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isHovered
                              ? const Color(0xFF3B82F6).withOpacity(0.2)
                              : const Color(0xFF3B82F6).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: isHovered
                              ? [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF3B82F6,
                                    ).withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : null,
                        ),
                        child: AnimatedRotation(
                          duration: const Duration(milliseconds: 200),
                          turns: isHovered ? 0.05 : 0.0,
                          child: Icon(
                            icon,
                            color: isHovered
                                ? const Color(0xFF60A5FA)
                                : const Color(0xFF3B82F6),
                            size: isHovered ? 20 : 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: TextStyle(
                            color: isHovered
                                ? Colors.white
                                : Colors.white.withOpacity(0.9),
                            fontSize: 14,
                            fontWeight: isHovered
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                          child: Text(text),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNewsletterSection(bool isMobile) {
    return MouseRegion(
      onEnter: (_) => setState(() => _newsletterHovered = true),
      onExit: (_) => setState(() => _newsletterHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()
          ..translate(0.0, _newsletterHovered ? -4.0 : 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                color: _newsletterHovered
                    ? const Color(0xFF60A5FA)
                    : Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              child: const Text("Newsletter"),
            ),
            const SizedBox(height: 12),
            Text(
              "Subscribe for tech insights and updates.",
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            _buildAnimatedNewsletterField(isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedNewsletterField(bool isMobile) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      curve: Curves.elasticOut,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: _newsletterHovered
                  ? Colors.white.withOpacity(0.15)
                  : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _newsletterHovered
                    ? Colors.white.withOpacity(0.3)
                    : Colors.white.withOpacity(0.2),
                width: _newsletterHovered ? 2 : 1,
              ),
              boxShadow: _newsletterHovered
                  ? [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : null,
            ),
            child: isMobile
                ? _buildMobileNewsletterField()
                : _buildDesktopNewsletterField(),
          ),
        );
      },
    );
  }

  Widget _buildDesktopNewsletterField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _emailController,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              hintText: "Enter your email",
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              prefixIcon: Icon(
                Icons.email_outlined,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: ElevatedButton(
              onPressed: _isEmailValid && !_isSubscribing
                  ? _handleSubscribe
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isEmailValid
                    ? const Color(0xFF3B82F6)
                    : Colors.grey,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                elevation: _isEmailValid ? 4 : 0,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _isSubscribing
                    ? const SizedBox(
                        key: ValueKey('loading'),
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        "Subscribe",
                        key: ValueKey('text'),
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileNewsletterField() {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: "Enter your email",
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(16),
            prefixIcon: Icon(
              Icons.email_outlined,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: SizedBox(
            width: double.infinity,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: ElevatedButton(
                onPressed: _isEmailValid && !_isSubscribing
                    ? _handleSubscribe
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isEmailValid
                      ? const Color(0xFF3B82F6)
                      : Colors.grey,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  elevation: _isEmailValid ? 4 : 0,
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _isSubscribing
                      ? const SizedBox(
                          key: ValueKey('loading'),
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "Subscribe",
                          key: ValueKey('text'),
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(bool isMobile) {
    final legalLinks = [
      {"title": "Privacy Policy", "url": "/privacy"},
      {"title": "Terms", "url": "/terms"},
    ];

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOut,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 30),
          child: Opacity(
            opacity: value,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 40,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: isMobile
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "© ${DateTime.now().year} Kallwik Technologies. All rights reserved.",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 12,
                        ),
                        textAlign: isMobile ? TextAlign.center : TextAlign.left,
                      ),
                      if (!isMobile) ...[
                        Row(
                          children: legalLinks.map((link) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: GestureDetector(
                                onTap: () => _launchURL(link["url"]!),
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Text(
                                    link["title"]!,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 12,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                  if (isMobile) ...[
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: legalLinks.map((link) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: GestureDetector(
                            onTap: () => _launchURL(link["url"]!),
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Text(
                                link["title"]!,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _handleSubscribe() async {
    setState(() => _isSubscribing = true);
    await Future.delayed(const Duration(seconds: 2)); // simulate API call
    setState(() => _isSubscribing = false);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Subscribed successfully!"),
        backgroundColor: Colors.green,
      ),
    );
    _emailController.clear();
  }
}
