import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CropDetailScreen extends StatefulWidget {
  final Map crop;

  const CropDetailScreen({
    super.key,
    required this.crop,
  });

  @override
  State<CropDetailScreen> createState() => _CropDetailScreenState();
}

class _CropDetailScreenState extends State<CropDetailScreen> {
  int selectedTab = 0;

  final List<String> tabs = [
    "Overview",
    "Cultivation",
    "Varieties",
    "Diseases",
    "Market",
  ];

  @override
  Widget build(BuildContext context) {
    final crop = widget.crop;

    return Scaffold(
      backgroundColor: const Color(0xFFF4FAF2),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= HEADER =================

            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        crop["image"] ?? "",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.15),
                        Colors.black.withOpacity(0.85),
                      ],
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 135),
                        Text(
                          crop["name"] ?? "",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          crop["scientific"] ?? "",
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            crop["season"] ?? "",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // ================= BODY =================

            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ================= QUICK INFO =================

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      topCard(
                        "⏱️",
                        "Duration",
                        crop["duration"] ?? "",
                      ),
                      topCard(
                        "💧",
                        "Water",
                        crop["water"] ?? "",
                      ),
                      topCard(
                        "🌡️",
                        "Climate",
                        crop["climate"] ?? "",
                      ),
                      topCard(
                        "🌱",
                        "Soil",
                        crop["soil"] ?? "",
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // ================= TABS =================

                  SizedBox(
                    height: 52,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: tabs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTab = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 300,
                            ),
                            margin: const EdgeInsets.only(
                              right: 12,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                            ),
                            decoration: BoxDecoration(
                              color: selectedTab == index
                                  ? Colors.green
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              tabs[index],
                              style: GoogleFonts.poppins(
                                color: selectedTab == index
                                    ? Colors.white
                                    : Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ================= TAB CONTENT =================

                  if (selectedTab == 0) overviewSection(crop),

                  if (selectedTab == 1) cultivationSection(crop),

                  if (selectedTab == 2) varietiesSection(crop),

                  if (selectedTab == 3) diseaseSection(crop),

                  if (selectedTab == 4) marketSection(crop),

                  const SizedBox(height: 35),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= OVERVIEW =================

  Widget overviewSection(Map crop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle("About the Crop"),
        const SizedBox(height: 16),
        Text(
          crop["overview"] ??
              "This crop is one of the most widely cultivated and economically important agricultural crops. Farmers prefer cultivating this crop because of its stable market demand, profitable returns and adaptability to different climatic conditions. Proper land preparation, balanced fertilizer application, timely irrigation and effective pest management are essential for achieving higher productivity.",
          style: GoogleFonts.poppins(
            fontSize: 15,
            height: 2,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 26),
        detailCard(
          "Climate Requirement",
          "This crop grows best under moderate climatic conditions with temperatures ranging between 18°C and 32°C. It requires annual rainfall between 600 mm and 1200 mm depending on the growth stage. Proper sunlight exposure and moderate humidity help improve crop quality and productivity.",
        ),
        detailCard(
          "Soil Requirement",
          "Well-drained loamy soil rich in organic matter is considered ideal for cultivation. Soil pH between 6.0 and 7.5 supports better nutrient absorption and root development.",
        ),
        detailCard(
          "Water Management",
          "Timely irrigation is essential during germination, flowering and grain formation stages. Drip irrigation and sprinkler systems help conserve water and improve irrigation efficiency.",
        ),
        const SizedBox(height: 30),
        sectionTitle("Key Information"),
        const SizedBox(height: 18),
        infoTile(
          Icons.calendar_month,
          "Sowing Time",
          crop["sowing"] ?? "",
        ),
        infoTile(
          Icons.agriculture,
          "Harvesting",
          crop["harvest"] ?? "",
        ),
        infoTile(
          Icons.bar_chart,
          "Expected Yield",
          crop["yield"] ?? "",
        ),
        const SizedBox(height: 30),
        sectionTitle("Best Practices"),
        const SizedBox(height: 18),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              practiceTile(
                "Use certified hybrid seeds for better productivity.",
              ),
              practiceTile(
                "Maintain proper irrigation schedule according to crop growth stages.",
              ),
              practiceTile(
                "Apply organic compost and micronutrients regularly.",
              ),
              practiceTile(
                "Monitor pest and disease attacks frequently.",
              ),
              practiceTile(
                "Use drip irrigation to improve water efficiency.",
              ),
              practiceTile(
                "Harvest crops at correct maturity stage for better profit.",
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ================= CULTIVATION =================

  Widget cultivationSection(Map crop) {
    return Column(
      children: [
        cultivationStep(
          "1",
          "Land Preparation",
          "Prepare the land through deep ploughing and add organic manure for improved soil fertility.",
        ),
        cultivationStep(
          "2",
          "Seed Selection",
          "Use high-quality certified seeds resistant to diseases and pests.",
        ),
        cultivationStep(
          "3",
          "Sowing",
          "Sow seeds at proper spacing and depth to ensure healthy crop growth.",
        ),
        cultivationStep(
          "4",
          "Irrigation",
          "Use drip or sprinkler irrigation methods for efficient water usage.",
        ),
        cultivationStep(
          "5",
          "Fertilizer Management",
          "Apply balanced fertilizers including nitrogen, phosphorus and potassium.",
        ),
        cultivationStep(
          "6",
          "Pest Monitoring",
          "Inspect plants regularly for pest attacks and use integrated pest management methods.",
        ),
        cultivationStep(
          "7",
          "Harvesting",
          "Harvest the crop at proper maturity stage for maximum quality and market value.",
        ),
      ],
    );
  }

  // ================= VARIETIES =================

  Widget varietiesSection(Map crop) {
    return Column(
      children: [
        varietyCard(
          "Premium Hybrid Variety",
          "High Yield",
          "Provides higher productivity, better disease resistance and excellent market demand.",
        ),
        varietyCard(
          "Traditional Variety",
          "Low Maintenance",
          "Suitable for local climatic conditions with lower cultivation cost.",
        ),
        varietyCard(
          "Export Quality Variety",
          "Best Market Price",
          "Preferred for export due to better appearance and long shelf life.",
        ),
      ],
    );
  }

  // ================= DISEASES =================

  Widget diseaseSection(Map crop) {
    return Column(
      children: [
        diseaseCard(
          "Leaf Rust",
          "Symptoms include yellow-orange spots on leaves, reduced growth and lower productivity. Use fungicides, resistant varieties and proper field sanitation to control disease spread.",
        ),
        diseaseCard(
          "Blight Disease",
          "Causes leaf burning and drying. Maintain proper drainage and use recommended pesticides for control.",
        ),
        diseaseCard(
          "Root Rot",
          "Occurs mainly due to excess irrigation and poor drainage conditions. Improve drainage and avoid overwatering.",
        ),
      ],
    );
  }

  // ================= MARKET =================

  Widget marketSection(Map crop) {
    return Column(
      children: [
        marketCard(
          "Current Market Demand",
          "High demand across Karnataka, Maharashtra, Telangana and Andhra Pradesh markets.",
        ),
        marketCard(
          "Expected Market Price",
          "Approximate market price ranges between ₹1800 and ₹4500 per quintal depending on quality and demand.",
        ),
        marketCard(
          "Storage Advice",
          "Store produce in cool dry ventilated warehouses to improve shelf life and reduce losses.",
        ),
      ],
    );
  }

  // ================= SECTION TITLE =================

  Widget sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // ================= TOP CARD =================

  Widget topCard(
    String emoji,
    String title,
    String value,
  ) {
    return Container(
      width: 78,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  // ================= INFO TILE =================

  Widget infoTile(
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.green,
            size: 30,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ================= PRACTICE =================

  Widget practiceTile(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 28,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 15,
                height: 1.8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= DETAIL CARD =================

  Widget detailCard(
    String title,
    String description,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
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
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 15,
              height: 1.9,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // ================= CULTIVATION STEP =================

  Widget cultivationStep(
    String number,
    String title,
    String description,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.green,
            child: Text(
              number,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    height: 1.8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= VARIETY CARD =================

  Widget varietyCard(
    String title,
    String tag,
    String description,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  tag,
                  style: GoogleFonts.poppins(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 15,
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }

  // ================= DISEASE CARD =================

  Widget diseaseCard(
    String title,
    String description,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 15,
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }

  // ================= MARKET CARD =================

  Widget marketCard(
    String title,
    String description,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 15,
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }
}
