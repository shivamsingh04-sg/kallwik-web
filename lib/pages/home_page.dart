import 'package:flutter/material.dart';
import 'package:website_kallwik/sections/faq_section.dart';
import 'package:website_kallwik/sections/service_section.dart';

import '../widgets/nav_bar.dart';
import '../sections/hero_section.dart';
import '../sections/about_section.dart';
import '../sections/contact_section.dart';
import '../widgets/footer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDarkMode = false;

  // ScrollController for smooth navigation
  final ScrollController _scrollController = ScrollController();

  // Global keys for sections to enable navigation
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final GlobalKey _faqKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Smooth scroll to section method
  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      // Find position of the widget
      final box = context.findRenderObject() as RenderBox;
      final position = box.localToGlobal(
        Offset.zero,
        ancestor: context.findRenderObject(),
      );
      final yOffset =
          box.localToGlobal(Offset.zero).dy +
          _scrollController.offset; // relative to scroll

      _scrollController.animateTo(
        yOffset,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kallwik Technologies',
      theme: _buildTheme(false),
      darkTheme: _buildTheme(true),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: NavBar(
          isDarkMode: isDarkMode,
          onToggleTheme: () {
            setState(() => isDarkMode = !isDarkMode);
          },
          // Navigation callbacks
          onHomeTap: () => _scrollToSection(_heroKey),
          onAboutTap: () => _scrollToSection(_aboutKey),
          onServicesTap: () => _scrollToSection(_servicesKey),
          onContactTap: () => _scrollToSection(_contactKey),
          onFaqTap: () => _scrollToSection(_faqKey),
        ),
        endDrawer: NavDrawer(
          isDarkMode: isDarkMode,
          onToggleTheme: () {
            setState(() => isDarkMode = !isDarkMode);
          },
          // Navigation callbacks for drawer
          onHomeTap: () => _scrollToSection(_heroKey),
          onAboutTap: () => _scrollToSection(_aboutKey),
          onServicesTap: () => _scrollToSection(_servicesKey),
          onContactTap: () => _scrollToSection(_contactKey),
          onFaqTap: () => _scrollToSection(_faqKey),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,

          child: Ink.image(
            image: const AssetImage("assets/images/kalllwik.jpg"),
            fit: BoxFit.fill,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // Hero Section
                  Container(key: _heroKey, child: const HeroSection()),

                  // About Section
                  Container(key: _aboutKey, child: const AboutSection()),

                  // Services Section
                  Container(key: _servicesKey, child: const ServicesSection()),

                  // Contact Section
                  Container(key: _contactKey, child: const ContactSection()),

                  // FAQ Section
                  Container(key: _faqKey, child: const FAQSection()),

                  // Footer
                  const Footer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Enhanced theme configuration
  ThemeData _buildTheme(bool isDark) {
    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF3B82F6),
        brightness: isDark ? Brightness.dark : Brightness.light,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          color: isDark ? Colors.white : const Color(0xFF0F172A),
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: isDark ? Colors.white70 : const Color(0xFF64748B),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3B82F6),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
