import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 768;
    final isTablet = screenSize.width >= 768 && screenSize.width < 1200;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : (isTablet ? 40 : 80),
        vertical: isMobile ? 60 : 100,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
        image: DecorationImage(
          image: const NetworkImage(
            "https://images.unsplash.com/photo-1557804506-669a67965ba0",
          ),
          fit: BoxFit.cover,
          opacity: isDark ? 0.02 : 0.01,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: isMobile
              ? _buildMobileLayout(isDark)
              : _buildDesktopLayout(isDark, isTablet),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(bool isDark) {
    return Column(
      children: [
        _buildSectionHeader(isDark, true),
        const SizedBox(height: 40),
        _buildContactInfo(isDark, true),
        const SizedBox(height: 40),
        _buildContactForm(isDark, true),
      ],
    );
  }

  Widget _buildDesktopLayout(bool isDark, bool isTablet) {
    return Column(
      children: [
        _buildSectionHeader(isDark, false),
        const SizedBox(height: 60),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: isTablet ? 1 : 2,
              child: _buildContactInfo(isDark, false),
            ),
            const SizedBox(width: 60),
            Expanded(
              flex: isTablet ? 2 : 3,
              child: _buildContactForm(isDark, false),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionHeader(bool isDark, bool isMobile) {
    return Column(
      children: [
        Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: const Color(0xFF3B82F6).withOpacity(0.3),
                  width: 1,
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
            )
            .animate()
            .fadeIn(duration: 800.ms)
            .slideY(begin: -0.3, curve: Curves.easeOutCubic),
        const SizedBox(height: 20),
        Text(
              "Let's Start Your Project",
              style: TextStyle(
                fontSize: isMobile ? 32 : 48,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
                height: 1.2,
                letterSpacing: -0.5,
              ),
              textAlign: TextAlign.center,
            )
            .animate()
            .fadeIn(duration: 1000.ms)
            .slideY(begin: 0.3, curve: Curves.easeOutCubic),
        const SizedBox(height: 16),
        Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                "Ready to transform your ideas into reality? Get in touch with our team for a free consultation and project estimate.",
                style: TextStyle(
                  fontSize: 18,
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
            .fadeIn(duration: 1000.ms)
            .slideY(begin: 0.2, curve: Curves.easeOutCubic),
      ],
    );
  }

  Widget _buildContactInfo(bool isDark, bool isMobile) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Get in Touch",
              style: TextStyle(
                fontSize: isMobile ? 24 : 32,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "We're here to help bring your vision to life. Reach out through any of these channels:",
              style: TextStyle(
                fontSize: 16,
                color: isDark
                    ? Colors.white.withOpacity(0.8)
                    : const Color(0xFF64748B),
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),
            _buildContactItem(
              Icons.location_on_rounded,
              "Visit Us",
              "Indore, Madhya Pradesh\nIndia",
              const Color(0xFFEF4444),
              isDark,
            ),
            const SizedBox(height: 24),
            _buildContactItem(
              Icons.email_rounded,
              "Email Us",
              "hr@kallwik.com\ninfo@kallwik.com",
              const Color(0xFF3B82F6),
              isDark,
            ),
            const SizedBox(height: 24),
            _buildContactItem(
              Icons.phone_rounded,
              "Call Us",
              "+91 XXX-XXX-XXXX\nMon-Fri, 9AM-6PM IST",
              const Color(0xFF10B981),
              isDark,
            ),
          ],
        )
        .animate()
        .fadeIn(duration: 1000.ms)
        .slideX(begin: -0.2, curve: Curves.easeOutCubic);
  }

  Widget _buildContactItem(
    IconData icon,
    String title,
    String subtitle,
    Color color,
    bool isDark,
  ) {
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark
                      ? Colors.white.withOpacity(0.7)
                      : const Color(0xFF64748B),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactForm(bool isDark, bool isMobile) {
    return Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF0F172A) : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.black.withOpacity(0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
                blurRadius: 30,
                offset: const Offset(0, 15),
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
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 24),
                // Name and Email
                isMobile
                    ? Column(
                        children: [
                          _buildTextField(
                            controller: _nameController,
                            label: "Full Name",
                            icon: Icons.person_rounded,
                            isDark: isDark,
                            validator: (value) => value?.isEmpty == true
                                ? "Name is required"
                                : null,
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            controller: _emailController,
                            label: "Email Address",
                            icon: Icons.email_rounded,
                            isDark: isDark,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value?.isEmpty == true) {
                                return "Email is required";
                              }
                              if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              ).hasMatch(value!)) {
                                return "Enter a valid email";
                              }
                              return null;
                            },
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: _nameController,
                              label: "Full Name",
                              icon: Icons.person_rounded,
                              isDark: isDark,
                              validator: (value) => value?.isEmpty == true
                                  ? "Name is required"
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              controller: _emailController,
                              label: "Email Address",
                              icon: Icons.email_rounded,
                              isDark: isDark,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value?.isEmpty == true) {
                                  return "Email is required";
                                }
                                if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                ).hasMatch(value!)) {
                                  return "Enter a valid email";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 20),
                // Phone and Subject
                isMobile
                    ? Column(
                        children: [
                          _buildTextField(
                            controller: _phoneController,
                            label: "Phone Number (Optional)",
                            icon: Icons.phone_rounded,
                            isDark: isDark,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            controller: _subjectController,
                            label: "Project Subject",
                            icon: Icons.subject_rounded,
                            isDark: isDark,
                            validator: (value) => value?.isEmpty == true
                                ? "Subject is required"
                                : null,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: _phoneController,
                              label: "Phone Number (Optional)",
                              icon: Icons.phone_rounded,
                              isDark: isDark,
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              controller: _subjectController,
                              label: "Project Subject",
                              icon: Icons.subject_rounded,
                              isDark: isDark,
                              validator: (value) => value?.isEmpty == true
                                  ? "Subject is required"
                                  : null,
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 20),
                // Service dropdown
                _buildDropdownField(
                  label: "Service Interested In",
                  value: _selectedService,
                  items: _services,
                  icon: Icons.build_rounded,
                  isDark: isDark,
                  onChanged: (value) =>
                      setState(() => _selectedService = value!),
                ),
                const SizedBox(height: 20),
                // Message
                _buildTextField(
                  controller: _messageController,
                  label: "Project Details & Requirements",
                  icon: Icons.message_rounded,
                  isDark: isDark,
                  maxLines: 5,
                  validator: (value) => value?.isEmpty == true
                      ? "Please describe your project"
                      : null,
                ),
                const SizedBox(height: 32),
                // Submit Button (Display only)
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Form validation for visual feedback
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              'Form is ready for integration with your backend service',
                            ),
                            backgroundColor: const Color(0xFF10B981),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.send_rounded, size: 20),
                        SizedBox(width: 8),
                        Text(
                          "Send Message",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 1000.ms)
        .slideX(begin: 0.2, curve: Curves.easeOutCubic);
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isDark,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(color: isDark ? Colors.white : const Color(0xFF0F172A)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: isDark ? Colors.white70 : const Color(0xFF64748B),
        ),
        prefixIcon: Icon(
          icon,
          color: isDark ? Colors.white70 : const Color(0xFF64748B),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark
                ? Colors.white.withOpacity(0.2)
                : Colors.black.withOpacity(0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEF4444), width: 2),
        ),
        filled: true,
        fillColor: isDark
            ? Colors.white.withOpacity(0.05)
            : const Color(0xFFF8FAFC),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required IconData icon,
    required bool isDark,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: isDark ? Colors.white70 : const Color(0xFF64748B),
        ),
        prefixIcon: Icon(
          icon,
          color: isDark ? Colors.white70 : const Color(0xFF64748B),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark
                ? Colors.white.withOpacity(0.2)
                : Colors.black.withOpacity(0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
        ),
        filled: true,
        fillColor: isDark
            ? Colors.white.withOpacity(0.05)
            : const Color(0xFFF8FAFC),
      ),
      dropdownColor: isDark ? const Color(0xFF1E293B) : Colors.white,
      style: TextStyle(
        color: isDark ? Colors.white : const Color(0xFF0F172A),
        fontSize: 16,
      ),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
