import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  String _selectedService = 'General Inquiry';
  bool _isSubmitting = false;
  bool _showSuccess = false;

  // for testimonial pager & small "live" dots
  final _testimonialController = PageController(viewportFraction: 1);
  int _testimonialPage = 0;
  Timer? _testimonialTimer;

  final List<String> _services = [
    'General Inquiry',
    'Web Development',
    'Mobile Development',
    'Cloud Solutions',
    'Data Analytics',
    'Cybersecurity',
    'UI/UX Design',
    'Consultation',
  ];

  final List<Map<String, String>> _testimonials = [
    {
      "name": "Priya R.",
      "role": "Product Manager",
      "text": "Fast delivery and clear communication — highly recommended.",
    },
    {
      "name": "Michael B.",
      "role": "CTO",
      "text": "They built our MVP and the quality exceeded expectations.",
    },
    {
      "name": "Anika S.",
      "role": "Founder",
      "text": "Flexible team, great estimates, awesome results.",
    },
  ];

  @override
  void initState() {
    super.initState();
    // rotate testimonials automatically
    _testimonialTimer = Timer.periodic(const Duration(seconds: 4), (t) {
      if (_testimonials.isEmpty) return;
      _testimonialPage = (_testimonialPage + 1) % _testimonials.length;
      _testimonialController.animateToPage(
        _testimonialPage,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _testimonialTimer?.cancel();
    _testimonialController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);

    try {
      // Replace with your real API call
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
        _showSuccess = true;
      });

      // show ephemeral success overlay then hide
      await Future.delayed(const Duration(milliseconds: 1400));
      if (!mounted) return;
      setState(() => _showSuccess = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Message sent — we'll get back to you soon!"),
          backgroundColor: Color(0xFF10B981),
          behavior: SnackBarBehavior.floating,
        ),
      );

      // clear form
      _formKey.currentState!.reset();
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _subjectController.clear();
      _messageController.clear();
      setState(() => _selectedService = _services.first);
    } catch (e) {
      setState(() => _isSubmitting = false);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to send message: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;

    // responsive breakpoints
    final isDesktop = width >= 1100;
    final isTablet = width >= 768 && width < 1100;
    final isMobile = width < 768;

    return Stack(
      children: [
        // decorative subtle animated blobs
        Positioned(
              left: -80,
              top: -60,
              child: _animatedBlob(
                220,
                220,
                Colors.blue.shade300.withOpacity(0.08),
              ),
            )
            .animate(onPlay: (c) => c.repeat())
            .scaleXY(end: 1.05, duration: 1800.ms),
        Positioned(
              right: -120,
              bottom: -80,
              child: _animatedBlob(
                300,
                300,
                Colors.green.shade300.withOpacity(0.06),
              ),
            )
            .animate(onPlay: (c) => c.repeat())
            .scaleXY(end: 1.06, duration: 2000.ms),

        // main section
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : (isTablet ? 40 : 80),
            vertical: isMobile ? 48 : 92,
          ),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF07101A) : const Color(0xFFF8FAFC),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: isDesktop
                  ? _buildDesktopLayout(isDark, isTablet)
                  : (isTablet
                        ? _buildTabletLayout(isDark)
                        : _buildMobileLayout(isDark)),
            ),
          ),
        ),

        // full-screen submitting overlay
        if (_isSubmitting) _buildSubmittingOverlay(isDark),
        if (_showSuccess) _buildSuccessOverlay(),
      ],
    );
  }

  Widget _animatedBlob(double w, double h, Color color) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(w),
        gradient: RadialGradient(
          colors: [color, color.withOpacity(0.02)],
          radius: 0.8,
        ),
      ),
    );
  }

  // ---------- Layouts ----------

  Widget _buildMobileLayout(bool isDark) {
    return Column(
      children: [
        _buildHeader(true),
        const SizedBox(height: 28),
        _buildContactInfo(isDark, true),
        const SizedBox(height: 28),
        _buildContactForm(isDark, true),
        const SizedBox(height: 24),
        _buildUtilitiesCompact(isDark),
      ],
    );
  }

  Widget _buildTabletLayout(bool isDark) {
    return Column(
      children: [
        _buildHeader(false),
        const SizedBox(height: 28),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 1, child: _buildContactInfo(isDark, false)),
            const SizedBox(width: 20),
            Expanded(flex: 2, child: _buildContactForm(isDark, false)),
          ],
        ),
        const SizedBox(height: 20),
        _buildUtilitiesCompact(isDark),
      ],
    );
  }

  Widget _buildDesktopLayout(bool isDark, bool isTablet) {
    return Column(
      children: [
        _buildHeader(false),
        const SizedBox(height: 36),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // left column: info
            Expanded(flex: 1, child: _buildContactInfo(isDark, false)),
            const SizedBox(width: 36),
            // center: form
            Expanded(flex: 2, child: _buildContactForm(isDark, false)),
            const SizedBox(width: 36),
            // right: utilities (fills previous blank space)
            SizedBox(width: 320, child: _buildUtilitiesPanel(isDark)),
          ],
        ),
      ],
    );
  }

  // ---------- header ----------

  Widget _buildHeader(bool isMobile) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: const Color(0xFF3B82F6).withOpacity(0.25),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.contact_mail_rounded,
                  size: 18,
                  color: Color(0xFF3B82F6),
                ),
                SizedBox(width: 8),
                Text(
                  "CONTACT US",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3B82F6),
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 650.ms)
          ..slideY(begin: -0.06, end: 0, duration: 600.ms),
        const SizedBox(height: 18),
        Text(
              "Let's Start Your Project",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 28 : 44,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
                height: 1.15,
              ),
            )
            .animate()
            .fadeIn(duration: 800.ms)
            .slideY(begin: -0.04, end: 0, duration: 700.ms),
      ],
    );
  }

  // ---------- left info ----------

  Widget _buildContactInfo(bool isDark, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Get in Touch",
          style: TextStyle(
            fontSize: isMobile ? 20 : 28,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Reach out — we'll respond quickly.",
          style: TextStyle(
            fontSize: isMobile ? 13 : 15,
            color: isDark ? Colors.white70 : const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 20),

        // two location cards stacked
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _simpleCard(
              title: "India Office",
              subtitle: "UG 126, First Floor, Vikram Square\nIndore, MP 452009",
              leading: Icons.location_on_rounded,
              color: const Color(0xFFEF4444),
              isDark: isDark,
              width: isMobile ? double.infinity : 320,
            ),
            _simpleCard(
              title: "United States Office",
              subtitle: "2122 W Miners Dr\nDunlap, IL 61525",
              leading: Icons.location_on_rounded,
              color: const Color(0xFF10B981),
              isDark: isDark,
              width: isMobile ? double.infinity : 320,
            ),
          ],
        ),

        const SizedBox(height: 18),

        _simpleCard(
          title: "Email Us",
          subtitle: "hr@kallwik.com\ninfo@kallwik.com",
          leading: Icons.email_rounded,
          color: const Color(0xFF3B82F6),
          isDark: isDark,
          width: isMobile ? double.infinity : 320,
        ),

        const SizedBox(height: 12),

        _simpleCard(
          title: "Business Hours",
          subtitle:
              "Mon - Fri\n10:00 AM - 7:00 PM (IST)\n9:00 AM - 5:00 PM (CST)",
          leading: Icons.access_time_rounded,
          color: const Color(0xFFF59E0B),
          isDark: isDark,
          width: isMobile ? double.infinity : 320,
        ),

        const SizedBox(height: 16),

        // hint chips
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _hintChip("Typical reply: < 24 hours", isDark),
            _hintChip("Avg. response time: ~2 hrs", isDark),
            _hintChip("Free consultation", isDark),
          ],
        ),
      ],
    ).animate().fadeIn();
  }

  Widget _simpleCard({
    required String title,
    required String subtitle,
    required IconData leading,
    required Color color,
    required bool isDark,
    required double width,
  }) {
    return Container(
          width: width,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF07101A) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(leading, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white70
                            : const Color(0xFF64748B),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideX(begin: -0.04, end: 0, duration: 600.ms);
  }

  Widget _hintChip(String text, bool isDark) {
    return Chip(
          label: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white70 : const Color(0xFF0F172A),
            ),
          ),
          backgroundColor: isDark ? Colors.white10 : Colors.white,
          elevation: 0,
          side: BorderSide(color: isDark ? Colors.white12 : Colors.black12),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        )
        .animate()
        .scaleXY(begin: 0.98, end: 1.0, duration: 700.ms)
        .shimmer(duration: 1600.ms);
  }

  // ---------- center form ----------

  Widget _buildContactForm(bool isDark, bool isMobile) {
    return Container(
          padding: EdgeInsets.all(isMobile ? 14 : 20),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF061018) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.25 : 0.06),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Send us a message",
                  style: TextStyle(
                    fontSize: isMobile ? 18 : 22,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 12),

                // name + email (responsive)
                isMobile
                    ? Column(
                        children: [
                          _field(
                            _nameController,
                            "Full Name",
                            Icons.person_rounded,
                            isDark,
                            isMobile,
                            validator: (v) =>
                                v?.isEmpty == true ? "Name is required" : null,
                          ),
                          const SizedBox(height: 10),
                          _field(
                            _emailController,
                            "Email Address",
                            Icons.email_rounded,
                            isDark,
                            isMobile,
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) {
                              if (v?.isEmpty == true)
                                return "Email is required";
                              if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              ).hasMatch(v!))
                                return "Enter a valid email";
                              return null;
                            },
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: _field(
                              _nameController,
                              "Full Name",
                              Icons.person_rounded,
                              isDark,
                              isMobile,
                              validator: (v) => v?.isEmpty == true
                                  ? "Name is required"
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _field(
                              _emailController,
                              "Email Address",
                              Icons.email_rounded,
                              isDark,
                              isMobile,
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) {
                                if (v?.isEmpty == true)
                                  return "Email is required";
                                if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                ).hasMatch(v!))
                                  return "Enter a valid email";
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),

                const SizedBox(height: 12),

                // phone + subject
                isMobile
                    ? Column(
                        children: [
                          _field(
                            _phoneController,
                            "Phone Number (Optional)",
                            Icons.phone_rounded,
                            isDark,
                            isMobile,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 10),
                          _field(
                            _subjectController,
                            "Project Subject",
                            Icons.subject_rounded,
                            isDark,
                            isMobile,
                            validator: (v) => v?.isEmpty == true
                                ? "Subject is required"
                                : null,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: _field(
                              _phoneController,
                              "Phone Number (Optional)",
                              Icons.phone_rounded,
                              isDark,
                              isMobile,
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _field(
                              _subjectController,
                              "Project Subject",
                              Icons.subject_rounded,
                              isDark,
                              isMobile,
                              validator: (v) => v?.isEmpty == true
                                  ? "Subject is required"
                                  : null,
                            ),
                          ),
                        ],
                      ),

                const SizedBox(height: 12),

                _buildDropdownField(
                  label: "Service Interested In",
                  value: _selectedService,
                  items: _services,
                  icon: Icons.build_rounded,
                  isDark: isDark,
                  isMobile: isMobile,
                  onChanged: (v) =>
                      setState(() => _selectedService = v ?? _selectedService),
                ),

                const SizedBox(height: 12),

                _field(
                  _messageController,
                  "Project Details & Requirements",
                  Icons.message_rounded,
                  isDark,
                  isMobile,
                  maxLines: 5,
                  validator: (v) => v?.isEmpty == true
                      ? "Please describe your project"
                      : null,
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 52,
                        child: ElevatedButton.icon(
                          onPressed: _isSubmitting ? null : _submitForm,
                          icon: _isSubmitting
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.send_rounded),
                          label: Text(
                            _isSubmitting ? "Sending..." : "Send Message",
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3B82F6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideX(begin: 0.02, end: 0, duration: 600.ms);
  }

  Widget _field(
    TextEditingController controller,
    String label,
    IconData icon,
    bool isDark,
    bool isMobile, {
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(
        color: isDark ? Colors.white : const Color(0xFF0F172A),
        fontSize: isMobile ? 14 : 15,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: isDark ? Colors.white70 : const Color(0xFF64748B),
          fontSize: isMobile ? 13 : 14,
        ),
        prefixIcon: Icon(
          icon,
          color: isDark ? Colors.white70 : const Color(0xFF64748B),
          size: isMobile ? 20 : 22,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.white10 : Colors.black12,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
        ),
        filled: true,
        fillColor: isDark
            ? Colors.white.withOpacity(0.02)
            : const Color(0xFFF8FAFC),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required IconData icon,
    required bool isDark,
    required bool isMobile,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: isDark ? Colors.white70 : const Color(0xFF64748B),
          fontSize: isMobile ? 13 : 14,
        ),
        prefixIcon: Icon(
          icon,
          color: isDark ? Colors.white70 : const Color(0xFF64748B),
          size: isMobile ? 20 : 22,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.white10 : Colors.black12,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
        ),
        filled: true,
        fillColor: isDark
            ? Colors.white.withOpacity(0.02)
            : const Color(0xFFF8FAFC),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
      dropdownColor: isDark ? const Color(0xFF0E2433) : Colors.white,
      style: TextStyle(color: isDark ? Colors.white : const Color(0xFF0F172A)),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
  }

  // ---------- right utilities ----------

  Widget _buildUtilitiesPanel(bool isDark) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _mapCard(isDark),
            const SizedBox(height: 14),
            _scheduleCard(isDark),
            const SizedBox(height: 14),
            _testimonialCard(isDark),
            const SizedBox(height: 14),
            _logosRow(isDark),
          ],
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideX(begin: 0.03, end: 0, duration: 600.ms);
  }

  Widget _buildUtilitiesCompact(bool isDark) {
    return Column(
      children: [
        _scheduleCard(isDark),
        const SizedBox(height: 12),
        _testimonialCard(isDark),
      ],
    );
  }

  Widget _mapCard(bool isDark) {
    return InkWell(
      onTap: () => _showFullMap(),
      child: Container(
        height: 140,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF061018) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Office Map",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.08),
                ),
                child: const Center(
                  child: Icon(Icons.map_rounded, size: 40, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFullMap() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          width: 700,
          height: 480,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    const Expanded(child: Text("Map")),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    width: 500,
                    height: 360,
                    color: Colors.grey.withOpacity(0.08),
                    child: const Icon(Icons.map_rounded, size: 80),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _scheduleCard(bool isDark) {
    return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF061018) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.calendar_month_rounded,
                      color: Color(0xFF3B82F6),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      "Schedule a free 30-min call",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                "Book a quick call to discuss scope, budget and timeline.",
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // replace with actual calendar link
                    launchUrl(
                      Uri.parse("https://calendly.com/kallwik/30min"),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  icon: const Icon(Icons.schedule_rounded),
                  label: const Text("Book a Call"),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 700.ms)
        .slideX(begin: 0.02, end: 0, duration: 700.ms);
  }

  Widget _testimonialCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: 170,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF061018) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.thumb_up_rounded,
                  color: Color(0xFF10B981),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  "What clients say",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: PageView.builder(
              controller: _testimonialController,
              itemCount: _testimonials.length,
              itemBuilder: (context, index) {
                final t = _testimonials[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '“${t["text"]}”',
                      style: const TextStyle(fontSize: 13),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '- ${t["name"]}, ${t["role"]}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                );
              },
              onPageChanged: (idx) => setState(() => _testimonialPage = idx),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _testimonials.length,
              (i) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _testimonialPage == i ? 24 : 8,
                height: 6,
                decoration: BoxDecoration(
                  color: _testimonialPage == i
                      ? const Color(0xFF3B82F6)
                      : Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _logosRow(bool isDark) {
    // small horizontal scrolling placeholder logos to fill space
    final logos = List.generate(6, (i) => Icons.work_rounded);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF061018) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: logos
              .map(
                (ic) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(ic, size: 28),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  // ---------- overlays ----------

  Widget _buildSubmittingOverlay(bool isDark) {
    return Positioned.fill(
      child: Container(
        color: isDark
            ? Colors.black.withOpacity(0.55)
            : Colors.white.withOpacity(0.55),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF06121B) : Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 30,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(
                  width: 48,
                  height: 48,
                  child: CircularProgressIndicator(strokeWidth: 3),
                ),
                SizedBox(height: 12),
                Text("Sending your message..."),
                SizedBox(height: 6),
                Text("Please wait", style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.12),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 30,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: const Color(0xFF10B981),
                  size: 72,
                ),
                const SizedBox(height: 12),
                const Text(
                  "Sent!",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                ),
                const SizedBox(height: 6),
                const Text(
                  "We received your message and will respond soon",
                  textAlign: TextAlign.center,
                ),
              ],
            ).animate().fadeIn(duration: 220.ms),
          ),
        ),
      ),
    );
  }
}
