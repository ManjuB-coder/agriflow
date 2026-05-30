import 'package:flutter/material.dart';
import 'crop_market_list_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class CropPriceHomeScreen extends StatefulWidget {
  const CropPriceHomeScreen({super.key});

  @override
  State<CropPriceHomeScreen> createState() => _CropPriceHomeScreenState();
}

class _CropPriceHomeScreenState extends State<CropPriceHomeScreen> {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, String>> crops = [
    {
      "name": "Paddy",
      "image": "assets/crops/paddy.jpg",
    },
    {
      "name": "Wheat",
      "image": "assets/crops/wheat.jpg",
    },
    {
      "name": "Maize",
      "image": "assets/crops/maize.jpg",
    },
    {
      "name": "Cotton",
      "image": "assets/crops/cotton.jpg",
    },
    {
      "name": "Groundnut",
      "image": "assets/crops/groundnut.jpg",
    },
    {
      "name": "Soybean",
      "image": "assets/crops/soybean.jpg",
    },
    {
      "name": "Sunflower",
      "image": "assets/crops/sunflower.jpg",
    },
    {
      "name": "Onion",
      "image": "assets/crops/onion.webp",
    },
    {
      "name": "Tomato",
      "image": "assets/crops/tomato.jpg",
    },
  ];

  final List<String> categories = [
    "Cereals",
    "Pulses",
    "Oilseeds",
    "Vegetables",
    "Fruits",
    "Cash Crops",
  ];
  String selectedCategory = "Cereals";
  List<Map<String, String>> filteredCrops = [];

  final Map<String, List<Map<String, String>>> categoryCrops = {
    "Cereals": [
      {"name": "Paddy", "image": "assets/crops/paddy.jpg"},
      {"name": "Wheat", "image": "assets/crops/wheat.jpg"},
      {"name": "Maize", "image": "assets/crops/maize.jpg"},
      {"name": "Barley", "image": "assets/crops/barley.jpg"},
      {"name": "Ragi", "image": "assets/crops/ragi.jpg"},
    ],
    "Vegetables": [
      {"name": "Tomato", "image": "assets/crops/tomato.jpg"},
      {"name": "Potato", "image": "assets/crops/potato.jpg"},
      {"name": "Onion", "image": "assets/crops/onion.webp"},
      {"name": "Brinjal", "image": "assets/crops/brinjal.webp"},
      {"name": "Cabbage", "image": "assets/crops/cabbage.webp"},
    ],
    "Fruits": [
      {"name": "Mango", "image": "assets/crops/mango.jpg"},
      {"name": "Banana", "image": "assets/crops/banana.jpg"},
      {"name": "Apple", "image": "assets/crops/apple.jpg"},
      {"name": "Orange", "image": "assets/crops/orange.webp"},
      {"name": "Papaya", "image": "assets/crops/papaya.jpg"},
    ],
    "Oilseeds": [
      {"name": "Groundnut", "image": "assets/crops/groundnut.jpg"},
      {"name": "Sunflower", "image": "assets/crops/sunflower.jpg"},
      {"name": "Mustard", "image": "assets/crops/mustard.jpg"},
      {"name": "Sesame", "image": "assets/crops/sesame.jpg"},
      {"name": "Coconut", "image": "assets/crops/coconut.jpg"},
    ],
    "Pulses": [
      {"name": "Green Gram", "image": "assets/crops/green_gram.jpg"},
      {"name": "Black Gram", "image": "assets/crops/black_gram.webp"},
      {"name": "Red Gram", "image": "assets/crops/red_gram.webp"},
      {"name": "peas", "image": "assets/crops/peas.jpg"},
      {"name": "Cowpea", "image": "assets/crops/cowpe.webp"},
    ],
    "Cash Crops": [
      {"name": "Cotton", "image": "assets/crops/cotton.jpg"},
      {"name": "Sugarcane", "image": "assets/crops/sugarcane.jpg"},
      {"name": "Coffee", "image": "assets/crops/coffee.jpg"},
      {"name": "Tea", "image": "assets/crops/tea.webp"},
      {"name": "Rubber", "image": "assets/crops/rubber.jpg"},
    ],
  };
  void searchCrop(String value) {
    setState(() {
      filteredCrops = categoryCrops[selectedCategory]!
          .where(
            (crop) => crop["name"]!.toLowerCase().contains(
                  value.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  String locationText = "Fetching Location...";
  bool isDarkMode = false;
  String selectedLanguage = "English";

  @override
  void initState() {
    super.initState();
    filteredCrops = categoryCrops[selectedCategory]!;
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      final place = placemarks.first;

      setState(() {
        locationText = "${place.locality}, ${place.administrativeArea}";
      });
    } catch (e) {
      setState(() {
        locationText = "Karnataka, India";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FAF4),
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : const Color(0xFFF5FAF4),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Live Crop Prices",
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.translate),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: const Text("English"),
                        onTap: () {
                          setState(() {
                            selectedLanguage = "English";
                          });
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text("Kannada"),
                        onTap: () {
                          setState(() {
                            selectedLanguage = "Kannada";
                          });
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text("Hindi"),
                        onTap: () {
                          setState(() {
                            selectedLanguage = "Hindi";
                          });
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text("Telugu"),
                        onTap: () {
                          setState(() {
                            selectedLanguage = "Telugu";
                          });
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text("Tamil"),
                        onTap: () {
                          setState(() {
                            selectedLanguage = "Tamil";
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LOCATION CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "My Location",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          locationText,
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // SEARCH

            TextField(
              controller: searchController,
              onChanged: searchCrop,
              decoration: InputDecoration(
                hintText: "Search Crop...",
                prefixIcon: const Icon(
                  Icons.search,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Popular Crops",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: GridView.builder(
                itemCount: filteredCrops.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.82,
                ),
                itemBuilder: (context, index) {
                  final crop = filteredCrops[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CropMarketListScreen(
                            cropName: crop["name"]!,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                crop["image"]!,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              crop["name"]!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Categories",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 45,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = categories[index];

                        filteredCrops = categoryCrops[selectedCategory]!;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                      ),
                      decoration: BoxDecoration(
                        color: selectedCategory == categories[index]
                            ? Colors.green
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: selectedCategory == categories[index]
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
