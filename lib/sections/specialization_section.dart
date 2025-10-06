import 'package:flutter/material.dart';
import '../widgets/section_wrapper.dart';

class SpecializationSection extends StatelessWidget {
  const SpecializationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionWrapper(
      title: "Our Niche Expertise",
      child: Text(
        "We also specialize in Sailpoint, helping enterprises with advanced identity security solutions.",
        style: TextStyle(fontSize: 18, height: 1.6),
        textAlign: TextAlign.center,
      ),
    );
  }
}
