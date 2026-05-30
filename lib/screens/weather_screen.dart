import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final String apiKey = "";

  bool isLoading = true;

  bool isDarkMode = false;

  String selectedLanguage = "English";

  String city = "";

  double temperature = 0;

  double feelsLike = 0;

  int humidity = 0;

  double windSpeed = 0;

  int rainChance = 0;

  String weatherMain = "";

  String weatherDescription = "";

  List forecastList = [];

  List hourlyForecast = [];

  // ================= TRANSLATIONS =================

  Map<String, Map<String, String>> text = {
    "English": {
      "title": "Weather",
      "hourly": "Hourly Forecast",
      "daily": "7 Days Forecast",
      "rain": "Rain",
      "humidity": "Humidity",
      "wind": "Wind",
      "uv": "UV",
      "message": "Farmer Advice",
      "feels": "Feels like",
    },
    "Kannada": {
      "title": "ಹವಾಮಾನ",
      "hourly": "ಗಂಟೆಗಳ ಹವಾಮಾನ",
      "daily": "7 ದಿನಗಳ ಹವಾಮಾನ",
      "rain": "ಮಳೆ",
      "humidity": "ಆರ್ದ್ರತೆ",
      "wind": "ಗಾಳಿ",
      "uv": "ಯುವಿ",
      "message": "ರೈತರ ಸಲಹೆ",
      "feels": "ಅನಿಸುತ್ತದೆ",
    },
    "Hindi": {
      "title": "मौसम",
      "hourly": "घंटेवार मौसम",
      "daily": "7 दिन मौसम",
      "rain": "बारिश",
      "humidity": "नमी",
      "wind": "हवा",
      "uv": "यूवी",
      "message": "किसानों के लिए सुझाव",
      "feels": "ऐसा लगता है",
    },
    "Telugu": {
      "title": "వాతావరణం",
      "hourly": "గంటల వాతావరణం",
      "daily": "7 రోజుల వాతావరణం",
      "rain": "వర్షం",
      "humidity": "తేమ",
      "wind": "గాలి",
      "uv": "యూవీ",
      "message": "రైతుల సూచన",
      "feels": "అనిపిస్తుంది",
    },
  };

  @override
  void initState() {
    super.initState();

    fetchWeather();
  }

  // ================= WEATHER EMOJI =================

  String getEmoji(String weather) {
    switch (weather.toLowerCase()) {
      case "rain":
        return "🌧️";

      case "clouds":
        return "☁️";

      case "clear":
        return "☀️";

      case "thunderstorm":
        return "⛈️";

      case "snow":
        return "❄️";

      default:
        return "🌤️";
    }
  }

  // ================= FARMER MESSAGE =================

  String farmingAlert() {
    if (weatherMain.toLowerCase() == "rain") {
      if (selectedLanguage == "Kannada") {
        return "🌧️ ಇಂದು ಮಳೆಯ ಸಾಧ್ಯತೆ ಇದೆ.\n\n✅ ಕೀಟನಾಶಕ ಸಿಂಪಡಿಸಬೇಡಿ\n✅ ಬೆಳೆ ನೀರು ಹರಿವು ಪರಿಶೀಲಿಸಿ\n✅ ಕೊಯ್ಲು ಮುಂದೂಡಿ";
      }

      if (selectedLanguage == "Hindi") {
        return "🌧️ आज बारिश की संभावना है।\n\n✅ कीटनाशक छिड़काव न करें\n✅ खेत की जल निकासी जांचें\n✅ कटाई टालें";
      }

      if (selectedLanguage == "Telugu") {
        return "🌧️ ఈరోజు వర్షం వచ్చే అవకాశం ఉంది.\n\n✅ పురుగుమందు పిచికారీ చేయవద్దు\n✅ నీటి పారుదల చూడండి\n✅ కోత వాయిదా వేయండి";
      }

      return "🌧️ Rain expected today.\n\n✅ Avoid pesticide spraying\n✅ Check field drainage\n✅ Postpone harvesting";
    }

    if (weatherMain.toLowerCase() == "clouds") {
      if (selectedLanguage == "Kannada") {
        return "☁️ ಇಂದು ಮೋಡ ಕವಿದ ವಾತಾವರಣ.\n\n✅ ಗೊಬ್ಬರ ಹಾಕಲು ಉತ್ತಮ ದಿನ\n✅ ಆರ್ದ್ರತೆ ಗಮನಿಸಿ\n✅ ಕೃಷಿ ಕಾರ್ಯಗಳಿಗೆ ಸೂಕ್ತ";
      }

      if (selectedLanguage == "Hindi") {
        return "☁️ आज बादल छाए रहेंगे।\n\n✅ उर्वरक डालने के लिए अच्छा दिन\n✅ नमी पर नजर रखें\n✅ खेती के लिए उपयुक्त मौसम";
      }

      if (selectedLanguage == "Telugu") {
        return "☁️ ఈరోజు మేఘావృత వాతావరణం.\n\n✅ ఎరువులు వేయడానికి అనుకూలం\n✅ తేమను గమనించండి\n✅ వ్యవసాయ పనులకు మంచిది";
      }

      return "☁️ Cloudy weather today.\n\n✅ Good day for fertilizer application\n✅ Monitor humidity levels\n✅ Ideal for most farming activities";
    }

    if (weatherMain.toLowerCase() == "thunderstorm") {
      if (selectedLanguage == "Kannada") {
        return "⛈️ ಗುಡುಗು ಸಹಿತ ಮಳೆಯ ಎಚ್ಚರಿಕೆ.\n\n✅ ಹೊಲದ ಕೆಲಸ ತಪ್ಪಿಸಿ\n✅ ಕೃಷಿ ಉಪಕರಣಗಳನ್ನು ರಕ್ಷಿಸಿ\n✅ ನೀರು ಹರಿವು ಪರಿಶೀಲಿಸಿ";
      }

      if (selectedLanguage == "Hindi") {
        return "⛈️ आंधी और तूफान की संभावना।\n\n✅ खेत में काम न करें\n✅ उपकरण सुरक्षित रखें\n✅ जल निकासी जांचें";
      }

      if (selectedLanguage == "Telugu") {
        return "⛈️ ఉరుములతో కూడిన వర్షం వచ్చే అవకాశం.\n\n✅ పొలంలో పని చేయవద్దు\n✅ పరికరాలను రక్షించండి\n✅ నీటి పారుదల చూడండి";
      }

      return "⛈️ Thunderstorm warning.\n\n✅ Avoid field work\n✅ Protect farm equipment\n✅ Ensure proper drainage";
    }

    if (weatherMain.toLowerCase() == "drizzle") {
      if (selectedLanguage == "Kannada") {
        return "🌦️ ತುಂತುರು ಮಳೆ ಸಾಧ್ಯತೆ.\n\n✅ ಕೀಟನಾಶಕ ಸಿಂಪಡಣೆ ಮುಂದೂಡಿ\n✅ ಮಣ್ಣಿನ ತೇವಾಂಶ ಗಮನಿಸಿ";
      }

      if (selectedLanguage == "Hindi") {
        return "🌦️ हल्की बारिश की संभावना।\n\n✅ छिड़काव टालें\n✅ मिट्टी की नमी पर नजर रखें";
      }

      if (selectedLanguage == "Telugu") {
        return "🌦️ తేలికపాటి వర్షం వచ్చే అవకాశం.\n\n✅ స్ప్రే చేయడం వాయిదా వేయండి\n✅ నేల తేమను గమనించండి";
      }

      return "🌦️ Light rain expected.\n\n✅ Delay pesticide spraying\n✅ Monitor crop moisture";
    }

    if (weatherMain.toLowerCase() == "mist") {
      if (selectedLanguage == "Kannada") {
        return "🌫️ ಮಂಜುಮಯ ವಾತಾವರಣ.\n\n✅ ಹುಳು ಮತ್ತು ಶಿಲೀಂಧ್ರ ರೋಗಗಳ ಮೇಲೆ ಗಮನವಿರಲಿ";
      }

      if (selectedLanguage == "Hindi") {
        return "🌫️ धुंधला मौसम।\n\n✅ फफूंदी रोगों पर नजर रखें";
      }

      if (selectedLanguage == "Telugu") {
        return "🌫️ పొగమంచు వాతావరణం.\n\n✅ శిలీంధ్ర వ్యాధులను గమనించండి";
      }
      if (temperature >= 35) {
        if (selectedLanguage == "Kannada") {
          return "🔥 ಹೆಚ್ಚಿನ ಉಷ್ಣಾಂಶ.\n\n✅ ಬೆಳಿಗ್ಗೆ ನೀರು ಹಾಕಿ\n✅ ಮಧ್ಯಾಹ್ನ ಹೊಲದ ಕೆಲಸ ತಪ್ಪಿಸಿ";
        }
      }

      if (selectedLanguage == "Hindi") {
        return "🔥 अधिक तापमान।\n\n✅ सुबह सिंचाई करें\n✅ दोपहर में खेत का काम कम करें";
      }

      if (selectedLanguage == "Telugu") {
        return "🔥 అధిక ఉష్ణోగ్రత.\n\n✅ ఉదయం నీరు పెట్టండి\n✅ మధ్యాహ్నం పనులు తగ్గించండి";
      }

      return "🔥 High temperature alert.\n\n✅ Irrigate crops early morning\n✅ Avoid afternoon field work";
    }

    if (humidity >= 80) {
      if (selectedLanguage == "Kannada") {
        return "💧 ಹೆಚ್ಚಿನ ಆರ್ದ್ರತೆ.\n\n✅ ಶಿಲೀಂಧ್ರ ರೋಗಗಳ ಮೇಲೆ ಗಮನವಿರಲಿ";
      }

      if (selectedLanguage == "Hindi") {
        return "💧 अधिक नमी।\n\n✅ फफूंदी रोगों पर नजर रखें";
      }

      if (selectedLanguage == "Telugu") {
        return "💧 అధిక తేమ.\n\n✅ శిలీంధ్ర వ్యాధులను గమనించండి";
      }

      return "💧 High humidity detected.\n\n✅ Watch for fungal infections";
    }

    if (windSpeed >= 15) {
      if (selectedLanguage == "Kannada") {
        return "🌬️ ಬಲವಾದ ಗಾಳಿ.\n\n✅ ಎತ್ತರದ ಬೆಳೆಗಳಿಗೆ ಬೆಂಬಲ ನೀಡಿ";
      }

      if (selectedLanguage == "Hindi") {
        return "🌬️ तेज हवाएं चल रही हैं।\n\n✅ ऊंची फसलों को सहारा दें";
      }

      if (selectedLanguage == "Telugu") {
        return "🌬️ బలమైన గాలులు వీయనున్నాయి.\n\n✅ ఎత్తైన పంటలకు మద్దతు ఇవ్వండి";
      }

      return "🌬️ Strong winds expected.\n\n✅ Support tall crops";
    }

    return "🌫️ Misty conditions.\n\n✅ Watch for fungal diseases";
  }
  // ================= FETCH WEATHER =================

  Future<void> fetchWeather() async {
    try {
      await Geolocator.requestPermission();

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      double lat = position.latitude;

      double lon = position.longitude;

      List<Placemark> placemarks = await placemarkFromCoordinates(
        lat,
        lon,
      );

      final currentUrl =
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

      final forecastUrl =
          "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

      final currentResponse = await http.get(
        Uri.parse(currentUrl),
      );

      final forecastResponse = await http.get(
        Uri.parse(forecastUrl),
      );

      final currentData = jsonDecode(currentResponse.body);

      final forecastData = jsonDecode(forecastResponse.body);

      setState(() {
        city = placemarks.first.subLocality ??
            placemarks.first.locality ??
            currentData["name"];

        temperature = currentData["main"]["temp"].toDouble();

        feelsLike = currentData["main"]["feels_like"].toDouble();

        humidity = currentData["main"]["humidity"];

        windSpeed = currentData["wind"]["speed"].toDouble();

        weatherMain = currentData["weather"][0]["main"];

        weatherDescription = currentData["weather"][0]["description"];

        rainChance = ((forecastData["list"][0]["pop"]) * 100).toInt();

        forecastList = forecastData["list"];

        hourlyForecast = forecastData["list"].take(6).toList();

        isLoading = false;
      });
    } catch (e) {
      print(e);

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF0F172A) : Colors.white,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ================= TOP =================

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.white.withOpacity(0.08)
                                : Colors.green.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Icon(
                            Icons.wb_sunny_rounded,
                            color: isDarkMode
                                ? Colors.white
                                : Colors.green.shade800,
                            size: 26,
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              text[selectedLanguage]!["title"]!,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                color:
                                    isDarkMode ? Colors.white : Colors.black87,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isDarkMode = !isDarkMode;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.white.withOpacity(0.08)
                                  : Colors.green.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Icon(
                              isDarkMode
                                  ? Icons.wb_sunny_rounded
                                  : Icons.nightlight_round,
                              color: isDarkMode
                                  ? Colors.white
                                  : Colors.green.shade800,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // ================= LOCATION =================

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: isDarkMode
                                  ? Colors.white70
                                  : Colors.green.shade800,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              city,
                              style: GoogleFonts.poppins(
                                color: isDarkMode
                                    ? Colors.white70
                                    : Colors.black87,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.white.withOpacity(0.08)
                                : Colors.green.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              dropdownColor: isDarkMode
                                  ? const Color(0xFF111827)
                                  : Colors.white,
                              value: selectedLanguage,
                              iconEnabledColor: isDarkMode
                                  ? Colors.white
                                  : Colors.green.shade800,
                              style: GoogleFonts.poppins(
                                color:
                                    isDarkMode ? Colors.white : Colors.black87,
                              ),
                              items: [
                                "English",
                                "Kannada",
                                "Hindi",
                                "Telugu",
                              ].map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedLanguage = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // ================= MAIN WEATHER =================

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(26),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isDarkMode
                              ? [
                                  Colors.white.withOpacity(0.10),
                                  Colors.white.withOpacity(0.04),
                                ]
                              : [
                                  Colors.white,
                                  const Color(0xFFF4FFF4),
                                ],
                        ),
                        borderRadius: BorderRadius.circular(34),
                        border: Border.all(
                          color: isDarkMode
                              ? Colors.white.withOpacity(0.08)
                              : Colors.green.withOpacity(0.08),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 30,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${temperature.toInt()}°",
                                  style: GoogleFonts.poppins(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black87,
                                    fontSize: 82,
                                    height: 1,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Row(
                                  children: [
                                    Text(
                                      getEmoji(weatherMain),
                                      style: const TextStyle(
                                        fontSize: 26,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        weatherDescription,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                          color: isDarkMode
                                              ? Colors.white70
                                              : Colors.black54,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "${text[selectedLanguage]!["feels"]!} ${feelsLike.toInt()}°C",
                                  style: GoogleFonts.poppins(
                                    color: isDarkMode
                                        ? Colors.white60
                                        : Colors.black54,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            getEmoji(weatherMain),
                            style: const TextStyle(
                              fontSize: 72,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 26),

                    // ================= WEATHER CARDS =================

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        weatherCard(
                          text[selectedLanguage]!["rain"]!,
                          "$rainChance%",
                          "🌧️",
                        ),
                        weatherCard(
                          text[selectedLanguage]!["humidity"]!,
                          "$humidity%",
                          "💧",
                        ),
                        weatherCard(
                          text[selectedLanguage]!["wind"]!,
                          "${windSpeed.toInt()} km/h",
                          "🌬️",
                        ),
                        weatherCard(
                          text[selectedLanguage]!["uv"]!,
                          "High",
                          "☀️",
                        ),
                      ],
                    ),

                    const SizedBox(height: 34),

                    // ================= HOURLY =================

                    Text(
                      text[selectedLanguage]!["hourly"]!,
                      style: GoogleFonts.poppins(
                        color: isDarkMode ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),

                    const SizedBox(height: 18),

                    SizedBox(
                      height: 140,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: hourlyForecast.length,
                        itemBuilder: (context, index) {
                          final item = hourlyForecast[index];

                          String condition = item["weather"][0]["main"];

                          return Container(
                            width: 100,
                            margin: const EdgeInsets.only(
                              right: 14,
                            ),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: isDarkMode
                                    ? [
                                        Colors.white.withOpacity(0.10),
                                        Colors.white.withOpacity(0.04),
                                      ]
                                    : [
                                        Colors.white,
                                        const Color(0xFFF3FFF3),
                                      ],
                              ),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "${DateTime.parse(item["dt_txt"]).hour}:00",
                                  style: GoogleFonts.poppins(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black87,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  getEmoji(condition),
                                  style: const TextStyle(
                                    fontSize: 34,
                                  ),
                                ),
                                Text(
                                  "${item["main"]["temp"].toInt()}°",
                                  style: GoogleFonts.poppins(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 34),

                    // ================= DAILY =================

                    Text(
                      text[selectedLanguage]!["daily"]!,
                      style: GoogleFonts.poppins(
                        color: isDarkMode ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),

                    const SizedBox(height: 18),

                    SizedBox(
                      height: 140,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: forecastList.length ~/ 8,
                        itemBuilder: (context, index) {
                          final item = forecastList[index * 8];

                          String condition = item["weather"][0]["main"];

                          return Container(
                            width: 100,
                            margin: const EdgeInsets.only(
                              right: 14,
                            ),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: isDarkMode
                                    ? [
                                        Colors.white.withOpacity(0.10),
                                        Colors.white.withOpacity(0.04),
                                      ]
                                    : [
                                        Colors.white,
                                        const Color(0xFFF3FFF3),
                                      ],
                              ),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  [
                                    "Mon",
                                    "Tue",
                                    "Wed",
                                    "Thu",
                                    "Fri",
                                    "Sat",
                                    "Sun"
                                  ][DateTime.parse(item["dt_txt"]).weekday - 1],
                                  style: GoogleFonts.poppins(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black87,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  getEmoji(condition),
                                  style: const TextStyle(
                                    fontSize: 34,
                                  ),
                                ),
                                Text(
                                  "${item["main"]["temp"].toInt()}°",
                                  style: GoogleFonts.poppins(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 34),

                    // ================= FARMER ADVICE =================

                    Text(
                      text[selectedLanguage]!["message"]!,
                      style: GoogleFonts.poppins(
                        color:
                            isDarkMode ? Colors.white : Colors.green.shade900,
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isDarkMode
                              ? [
                                  const Color(0xFF14532D),
                                  const Color(0xFF166534),
                                ]
                              : [
                                  const Color(0xFFD8F3DC),
                                  const Color(0xFFB7E4C7),
                                ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 25,
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "👨‍🌾",
                            style: TextStyle(
                              fontSize: 44,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              farmingAlert(),
                              style: GoogleFonts.poppins(
                                color: isDarkMode
                                    ? Colors.white
                                    : Colors.green.shade900,
                                fontSize: 15,
                                height: 1.9,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
    );
  }

  // ================= WEATHER CARD =================

  Widget weatherCard(
    String title,
    String value,
    String emoji,
  ) {
    return Container(
      width: 76,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode
              ? [
                  Colors.white.withOpacity(0.10),
                  Colors.white.withOpacity(0.04),
                ]
              : [
                  Colors.white,
                  const Color(0xFFF3FFF3),
                ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            emoji,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: isDarkMode ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: isDarkMode ? Colors.white70 : Colors.black54,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
