import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FAQSection extends StatefulWidget {
  const FAQSection({super.key});

  @override
  State<FAQSection> createState() => _FAQSectionState();
}

class _FAQSectionState extends State<FAQSection> {
  int? expandedIndex;
  String searchQuery = '';
  String selectedCategory = 'All';

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 768;

    final faqs = _getFAQsData();
    final categories = _getCategories();
    final filteredFAQs = _getFilteredFAQs(faqs);

    return Container(
      key: const Key("faq_section"),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: isMobile ? 20 : 80,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
        // Subtle pattern overlay
        image: DecorationImage(
          image: const NetworkImage(
            "https://images.unsplash.com/photo-1557804506-669a67965ba0", // Tech pattern
          ),
          fit: BoxFit.cover,
          opacity: isDark ? 0.02 : 0.01,
        ),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Section Header
            _buildSectionHeader(isDark, isMobile),

            SizedBox(height: isMobile ? 40 : 60),

            // Search and Filter Section
            _buildSearchAndFilter(isDark, isMobile, categories),

            const SizedBox(height: 40),

            // FAQ List
            _buildFAQList(filteredFAQs, isDark, isMobile),

            const SizedBox(height: 60),

            // Still Have Questions Section
            _buildStillHaveQuestions(isDark, isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(bool isDark, bool isMobile) {
    return Column(
      children: [
        // Section badge
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.help_outline_rounded,
                    size: 18,
                    color: const Color(0xFF3B82F6),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "FAQ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF3B82F6),
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            )
            .animate()
            .fadeIn(duration: 800.ms, delay: 200.ms)
            .slideY(begin: -0.3, curve: Curves.easeOutCubic),

        const SizedBox(height: 20),

        // Main heading
        Text(
              "Frequently Asked Questions",
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
            .fadeIn(duration: 1000.ms, delay: 400.ms)
            .slideY(begin: 0.3, curve: Curves.easeOutCubic),

        const SizedBox(height: 16),

        // Subtitle
        Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                "Find answers to common questions about our services, processes, and expertise. Can't find what you're looking for? We're here to help.",
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
            .fadeIn(duration: 1000.ms, delay: 600.ms)
            .slideY(begin: 0.2, curve: Curves.easeOutCubic),
      ],
    );
  }

  Widget _buildSearchAndFilter(
    bool isDark,
    bool isMobile,
    List<String> categories,
  ) {
    return Column(
      children: [
        // Search Bar
        Container(
              constraints: const BoxConstraints(maxWidth: 500),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search FAQ...",
                  hintStyle: TextStyle(
                    color: isDark
                        ? Colors.white.withOpacity(0.5)
                        : const Color(0xFF94A3B8),
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: isDark
                        ? Colors.white.withOpacity(0.5)
                        : const Color(0xFF94A3B8),
                  ),
                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              searchQuery = '';
                            });
                          },
                          icon: Icon(
                            Icons.clear_rounded,
                            color: isDark
                                ? Colors.white.withOpacity(0.5)
                                : const Color(0xFF94A3B8),
                          ),
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
                style: TextStyle(
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
            )
            .animate()
            .fadeIn(duration: 800.ms, delay: 800.ms)
            .slideY(begin: 0.2, curve: Curves.easeOutCubic),

        const SizedBox(height: 20),

        // Category Filter
        SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category;

                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: FilterChip(
                      label: Text(
                        category,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : (isDark
                                    ? Colors.white.withOpacity(0.8)
                                    : const Color(0xFF64748B)),
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      backgroundColor: isDark
                          ? const Color(0xFF1E293B)
                          : Colors.white,
                      selectedColor: const Color(0xFF3B82F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected
                              ? const Color(0xFF3B82F6)
                              : (isDark
                                    ? Colors.white.withOpacity(0.2)
                                    : Colors.black.withOpacity(0.1)),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
            .animate()
            .fadeIn(duration: 800.ms, delay: 1000.ms)
            .slideX(begin: -0.2, curve: Curves.easeOutCubic),
      ],
    );
  }

  Widget _buildFAQList(
    List<Map<String, dynamic>> faqs,
    bool isDark,
    bool isMobile,
  ) {
    if (faqs.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 64,
              color: isDark
                  ? Colors.white.withOpacity(0.3)
                  : const Color(0xFF94A3B8),
            ),
            const SizedBox(height: 16),
            Text(
              "No FAQs found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? Colors.white.withOpacity(0.7)
                    : const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Try adjusting your search or filter criteria",
              style: TextStyle(
                fontSize: 14,
                color: isDark
                    ? Colors.white.withOpacity(0.5)
                    : const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: faqs.asMap().entries.map((entry) {
        final index = entry.key;
        final faq = entry.value;
        final isExpanded = expandedIndex == index;

        return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isExpanded
                      ? const Color(0xFF3B82F6).withOpacity(0.3)
                      : (isDark
                            ? Colors.white.withOpacity(0.1)
                            : Colors.black.withOpacity(0.1)),
                  width: isExpanded ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                    blurRadius: isExpanded ? 12 : 8,
                    offset: Offset(0, isExpanded ? 6 : 3),
                  ),
                ],
              ),
              child: Theme(
                data: Theme.of(
                  context,
                ).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  key: Key('faq_$index'),
                  initiallyExpanded: isExpanded,
                  onExpansionChanged: (expanded) {
                    setState(() {
                      expandedIndex = expanded ? index : null;
                    });
                  },
                  tilePadding: const EdgeInsets.all(20),
                  childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      faq["icon"] as IconData,
                      size: 20,
                      color: const Color(0xFF3B82F6),
                    ),
                  ),
                  title: Text(
                    faq["q"] as String,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                      height: 1.4,
                    ),
                  ),
                  trailing: AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: isExpanded ? 0.5 : 0,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isExpanded
                            ? const Color(0xFF3B82F6).withOpacity(0.1)
                            : (isDark
                                  ? Colors.white.withOpacity(0.1)
                                  : Colors.black.withOpacity(0.05)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: isExpanded
                            ? const Color(0xFF3B82F6)
                            : (isDark
                                  ? Colors.white.withOpacity(0.7)
                                  : const Color(0xFF64748B)),
                      ),
                    ),
                  ),
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withOpacity(0.02)
                            : const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        faq["a"] as String,
                        style: TextStyle(
                          fontSize: 15,
                          color: isDark
                              ? Colors.white.withOpacity(0.8)
                              : const Color(0xFF64748B),
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .animate()
            .fadeIn(
              duration: 600.ms,
              delay: Duration(milliseconds: 200 + (index * 100)),
            )
            .slideY(begin: 0.2, curve: Curves.easeOutCubic);
      }).toList(),
    );
  }

  Widget _buildStillHaveQuestions(bool isDark, bool isMobile) {
    return Container(
          padding: EdgeInsets.all(isMobile ? 30 : 40),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3B82F6).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(
                Icons.contact_support_rounded,
                size: 48,
                color: Colors.white.withOpacity(0.9),
              ),
              const SizedBox(height: 16),
              Text(
                "Still have questions?",
                style: TextStyle(
                  fontSize: isMobile ? 24 : 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "We're here to help! Get in touch with our team for personalized assistance.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.9),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  _buildContactButton(
                    "Contact Us",
                    Icons.mail_rounded,
                    Colors.white,
                    const Color(0xFF3B82F6),
                  ),
                  _buildContactButton(
                    "Schedule Call",
                    Icons.videocam_rounded,
                    Colors.transparent,
                    Colors.white,
                    outlined: true,
                  ),
                ],
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 1000.ms, delay: 1200.ms)
        .slideY(begin: 0.3, curve: Curves.easeOutCubic);
  }

  Widget _buildContactButton(
    String text,
    IconData icon,
    Color bgColor,
    Color textColor, {
    bool outlined = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: outlined ? Border.all(color: Colors.white, width: 2) : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            debugPrint("$text button pressed");
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 18, color: textColor),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFAQsData() {
    return [
      {
        "q": "Who are we?",
        "a":
            "Kallwik Technologies is a software consulting company specializing in Software Development, Web Development, Cloud Applications, Application Migration, Testing, and Quality Assurance. We also provide niche services like SailPoint implementation.",
        "category": "Company",
        "icon": Icons.business_rounded,
      },
      {
        "q": "What services do you provide?",
        "a":
            "We provide end-to-end software development including Web & Mobile Apps, Backend Development, Cloud Migration, Identity Management (SailPoint), QA & Testing, and Application Modernization.",
        "category": "Services",
        "icon": Icons.build_rounded,
      },
      {
        "q": "Do you provide support after project delivery?",
        "a":
            "Yes, we provide comprehensive ongoing support, maintenance, and monitoring services after project delivery to ensure smooth operations and continuous improvement.",
        "category": "Support",
        "icon": Icons.support_agent_rounded,
      },
      {
        "q": "What industries do you work with?",
        "a":
            "We work with clients across industries such as IT, Finance, Healthcare, Manufacturing, and Retail—helping them modernize their digital platforms and achieve digital transformation goals.",
        "category": "Industries",
        "icon": Icons.domain_rounded,
      },
      {
        "q": "Do you work with international clients?",
        "a":
            "Yes, we serve clients globally and have expertise in managing offshore and remote development teams with effective communication and collaboration across different time zones.",
        "category": "Global",
        "icon": Icons.public_rounded,
      },
      {
        "q": "How do you ensure security and compliance?",
        "a":
            "We follow best practices in application security, role-based access, data encryption, and compliance with standards like GDPR, HIPAA, and ISO. Our security-first approach ensures your data and applications remain protected.",
        "category": "Security",
        "icon": Icons.security_rounded,
      },
      {
        "q": "What is your development process?",
        "a":
            "We follow Agile methodologies with regular sprints, continuous integration, and frequent client feedback. Our process includes requirement analysis, design, development, testing, deployment, and ongoing maintenance.",
        "category": "Process",
        "icon": Icons.timeline_rounded,
      },
      {
        "q": "How long does a typical project take?",
        "a":
            "Project timelines vary based on complexity and requirements. Simple websites take 2-4 weeks, mobile apps 2-4 months, and enterprise solutions 3-12 months. We provide detailed timelines after initial consultation.",
        "category": "Timeline",
        "icon": Icons.schedule_rounded,
      },
      {
        "q": "Do you provide free consultations?",
        "a":
            "Yes, we offer free initial consultations to understand your requirements, discuss potential solutions, and provide project estimates. This helps us align our services with your business goals.",
        "category": "Consultation",
        "icon": Icons.chat_rounded,
      },
      {
        "q": "How can I contact Kallwik Technologies?",
        "a":
            "You can reach us via email at hr@kallwik.com, call us, or visit our office in Indore, Madhya Pradesh, India. We're also available for online meetings and consultations.",
        "category": "Contact",
        "icon": Icons.contact_mail_rounded,
      },
    ];
  }

  List<String> _getCategories() {
    final faqs = _getFAQsData();
    final categories = faqs
        .map((faq) => faq["category"] as String)
        .toSet()
        .toList();
    categories.sort();
    return ['All', ...categories];
  }

  List<Map<String, dynamic>> _getFilteredFAQs(List<Map<String, dynamic>> faqs) {
    return faqs.where((faq) {
      final matchesSearch =
          searchQuery.isEmpty ||
          (faq["q"] as String).toLowerCase().contains(searchQuery) ||
          (faq["a"] as String).toLowerCase().contains(searchQuery);

      final matchesCategory =
          selectedCategory == 'All' || faq["category"] == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }
}
