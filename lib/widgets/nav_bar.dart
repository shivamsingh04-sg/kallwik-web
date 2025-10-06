import 'package:flutter/material.dart';

class NavBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onAboutTap;
  final VoidCallback onServicesTap;
  final VoidCallback onContactTap;
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const NavBar({
    super.key,
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onServicesTap,
    required this.onContactTap,
    required this.isDarkMode,
    required this.onToggleTheme,
    required void Function() onFaqTap,
  });

  @override
  State<NavBar> createState() => _NavBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _NavBarState extends State<NavBar> {
  String _hoveredItem = '';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final preferredSize = const Size.fromHeight(80);
    return Container(
      height: preferredSize.height,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: widget.isDarkMode
            ? const Color(0xFF0F172A).withOpacity(0.95)
            : Colors.white.withOpacity(0.95),
        border: Border(
          bottom: BorderSide(
            color: widget.isDarkMode
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.1),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Company Logo and Brand
          _buildLogo(),

          // Navigation Menu
          LayoutBuilder(
            builder: (context, constraints) {
              if (screenWidth > 900) {
                return _buildDesktopMenu();
              } else {
                return _buildMobileMenuButton();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        // Company Logo
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF3B82F6), // Blue
                Color(0xFF1E40AF), // Darker blue
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3B82F6).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              "KW",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        // Company Name
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "KALLWIK",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: widget.isDarkMode
                    ? Colors.white
                    : const Color(0xFF0F172A),
                letterSpacing: 1.5,
                height: 1.0,
              ),
            ),
            Text(
              "TECHNOLOGIES",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: widget.isDarkMode
                    ? Colors.white.withOpacity(0.7)
                    : const Color(0xFF64748B),
                letterSpacing: 2.0,
                height: 1.0,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopMenu() {
    return Row(
      children: [
        _buildNavItem("Home", widget.onHomeTap),
        _buildNavItem("About", widget.onAboutTap),
        _buildNavItem("Services", widget.onServicesTap),
        _buildNavItem("Contact", widget.onContactTap),

        const SizedBox(width: 24),

        // Theme Toggle Button
        _buildThemeToggle(),

        const SizedBox(width: 16),

        // CTA Button
        _buildCTAButton(),
      ],
    );
  }

  Widget _buildMobileMenuButton() {
    return Row(
      children: [
        _buildThemeToggle(),
        const SizedBox(width: 8),
        Builder(
          builder: (context) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: widget.isDarkMode
                    ? Colors.white.withOpacity(0.2)
                    : Colors.black.withOpacity(0.2),
              ),
            ),
            child: IconButton(
              icon: Icon(
                Icons.menu_rounded,
                color: widget.isDarkMode
                    ? Colors.white
                    : const Color(0xFF0F172A),
                size: 24,
              ),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              padding: const EdgeInsets.all(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(String label, VoidCallback onTap) {
    final isHovered = _hoveredItem == label;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hoveredItem = label),
        onExit: (_) => setState(() => _hoveredItem = ''),
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isHovered
                  ? (widget.isDarkMode
                        ? Colors.white.withOpacity(0.1)
                        : Colors.black.withOpacity(0.05))
                  : Colors.transparent,
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isHovered
                    ? const Color(0xFF3B82F6)
                    : (widget.isDarkMode
                          ? Colors.white
                          : const Color(0xFF0F172A)),
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: widget.isDarkMode
              ? Colors.white.withOpacity(0.2)
              : Colors.black.withOpacity(0.2),
        ),
      ),
      child: IconButton(
        onPressed: widget.onToggleTheme,
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Icon(
            widget.isDarkMode
                ? Icons.light_mode_rounded
                : Icons.dark_mode_rounded,
            key: ValueKey(widget.isDarkMode),
            color: widget.isDarkMode ? Colors.amber : const Color(0xFF3B82F6),
            size: 20,
          ),
        ),
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
      ),
    );
  }

  Widget _buildCTAButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navigate to contact or consultation page
            widget.onContactTap();
          },
          borderRadius: BorderRadius.circular(8),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Contact Us",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Enhanced Professional Drawer
class NavDrawer extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onAboutTap;
  final VoidCallback onServicesTap;
  final VoidCallback onContactTap;
  final VoidCallback onFaqTap;
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const NavDrawer({
    super.key,
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onServicesTap,
    required this.onContactTap,
    required this.onFaqTap,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
      elevation: 16,
      width: 280,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Check if screen height is small
          final isSmallScreen = constraints.maxHeight < 600;
          final headerHeight = isSmallScreen ? 140.0 : 200.0;

          return Column(
            children: [
              // Enhanced Header - Responsive height
              Container(
                height: headerHeight,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF3B82F6),
                      Color(0xFF1D4ED8),
                      Color(0xFF1E40AF),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(isSmallScreen ? 12 : 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo - Smaller on small screens
                        Container(
                          width: isSmallScreen ? 45 : 60,
                          height: isSmallScreen ? 45 : 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              isSmallScreen ? 10 : 12,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "KW",
                              style: TextStyle(
                                color: const Color(0xFF3B82F6),
                                fontSize: isSmallScreen ? 18 : 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: isSmallScreen ? 8 : 16),

                        // Company name - Smaller on small screens
                        Text(
                          "KALLWIK",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isSmallScreen ? 20 : 24,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Text(
                          "TECHNOLOGIES",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: isSmallScreen ? 10 : 12,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Navigation Items - Scrollable content
              Expanded(
                child: isSmallScreen
                    ? _buildScrollableContent(context, isDarkMode)
                    : _buildNormalContent(context, isDarkMode),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildScrollableContent(BuildContext context, bool isDarkMode) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          // Navigation Items
          _buildDrawerItem(context, "Home", Icons.home_rounded, onHomeTap),
          _buildDrawerItem(context, "About Us", Icons.info_rounded, onAboutTap),
          _buildDrawerItem(
            context,
            "Our Services",
            Icons.build_rounded,
            onServicesTap,
          ),
          _buildDrawerItem(
            context,
            "Contact Us",
            Icons.mail_rounded,
            onContactTap,
          ),

          const SizedBox(height: 20),

          // Theme Toggle - Compact version for small screens
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.05)
                  : Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(
                  isDarkMode
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_rounded,
                  size: 20,
                  color: isDarkMode ? Colors.white70 : const Color(0xFF64748B),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    isDarkMode ? "Dark Mode" : "Light Mode",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode
                          ? Colors.white
                          : const Color(0xFF0F172A),
                    ),
                  ),
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: isDarkMode,
                    activeColor: const Color(0xFF3B82F6),
                    onChanged: (_) => onToggleTheme(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Footer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "© 2024 Kallwik Technologies",
              style: TextStyle(
                fontSize: 11,
                color: isDarkMode ? Colors.white54 : const Color(0xFF64748B),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  // Normal content for larger screens
  Widget _buildNormalContent(BuildContext context, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          _buildDrawerItem(context, "Home", Icons.home_rounded, onHomeTap!),
          _buildDrawerItem(
            context,
            "About Us",
            Icons.info_rounded,
            onAboutTap!,
          ),
          _buildDrawerItem(
            context,
            "Our Services",
            Icons.build_rounded,
            onServicesTap!,
          ),
          _buildDrawerItem(
            context,
            "Contact Us",
            Icons.mail_rounded,
            onContactTap!,
          ),

          const Spacer(),

          // Theme Toggle
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.05)
                  : Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  isDarkMode
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_rounded,
                  color: isDarkMode ? Colors.white70 : const Color(0xFF64748B),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    isDarkMode ? "Dark Mode" : "Light Mode",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode
                          ? Colors.white
                          : const Color(0xFF0F172A),
                    ),
                  ),
                ),
                Switch(
                  value: isDarkMode,
                  activeColor: const Color(0xFF3B82F6),
                  onChanged: (_) => onToggleTheme(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Text(
            "© 2024 Kallwik Technologies",
            style: TextStyle(
              fontSize: 12,
              color: isDarkMode ? Colors.white54 : const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDarkMode ? Colors.white70 : const Color(0xFF64748B),
        size: 22,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isDarkMode ? Colors.white : const Color(0xFF0F172A),
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
