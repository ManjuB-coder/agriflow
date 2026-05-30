import 'package:flutter/material.dart';
import '../models/scheme_model.dart';
import 'official_apply_screen.dart';

class SchemeDetailScreen extends StatelessWidget {
  final SchemeModel scheme;

  const SchemeDetailScreen({
    super.key,
    required this.scheme,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FAF4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5FAF4),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          scheme.name,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SCHEME IMAGE

            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                scheme.image,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            // CATEGORY CHIP

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                scheme.category,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            Text(
              scheme.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            buildSectionCard(
              title: "About Scheme",
              content: scheme.description,
              icon: Icons.info_outline,
            ),

            buildSectionCard(
              title: "Benefits",
              content: scheme.benefits,
              icon: Icons.card_giftcard,
            ),

            buildSectionCard(
              title: "Eligibility",
              content: scheme.eligibility,
              icon: Icons.verified_user,
            ),

            buildSectionCard(
              title: "Required Documents",
              content: scheme.documents,
              icon: Icons.description,
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OfficialApplyScreen(
                        schemeName: scheme.name,
                        url: scheme.applyUrl,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.open_in_new,
                  color: Colors.white,
                ),
                label: const Text(
                  "Apply Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildSectionCard({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.green,
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
