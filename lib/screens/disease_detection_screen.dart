import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class DiseaseDetectionScreen extends StatefulWidget {
  const DiseaseDetectionScreen({super.key});

  @override
  State<DiseaseDetectionScreen> createState() => _DiseaseDetectionScreenState();
}

class _DiseaseDetectionScreenState extends State<DiseaseDetectionScreen> {
  File? selectedImage;

  final ImagePicker picker = ImagePicker();

  Interpreter? interpreter;

  List<String> labels = [];

  bool isModelLoaded = false;

  bool isPredicting = false;

  String prediction = "No Prediction";

  double confidence = 0.0;

  // ================= AI DETAILS =================

  String scientificName = "";

  String severity = "";

  String symptoms = "";

  String cause = "";

  String treatment = "";

  String pesticide = "";

  String dosage = "";

  String sprayTime = "";

  String organicSolution = "";

  String fertilizer = "";

  String fertilizerDose = "";

  String irrigation = "";

  String prevention = "";

  String recovery = "";

  String weatherWarning = "";

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  // ================= LOAD MODEL =================

  Future<void> loadModel() async {
    try {
      interpreter = await Interpreter.fromAsset(
        'assets/models/model.tflite',
      );

      final labelData = await rootBundle.loadString(
        'assets/models/labels.txt',
      );

      labels = labelData
          .split('\n')
          .where((label) => label.trim().isNotEmpty)
          .toList();

      if (!mounted) return;

      setState(() {
        isModelLoaded = true;
      });
    } catch (e) {
      print("MODEL ERROR : $e");
    }
  }

  // ================= CAMERA =================

  Future<void> pickFromCamera() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (image != null) {
      selectedImage = File(image.path);

      setState(() {});

      runModelOnImage(selectedImage!);
    }
  }

  // ================= GALLERY =================

  Future<void> pickFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      selectedImage = File(
        result.files.single.path!,
      );

      setState(() {});

      runModelOnImage(selectedImage!);
    }
  }

  // ================= RUN MODEL =================

  Future<void> runModelOnImage(
    File imageFile,
  ) async {
    if (interpreter == null) return;

    setState(() {
      isPredicting = true;
    });

    try {
      final bytes = await imageFile.readAsBytes();

      img.Image? image = img.decodeImage(bytes);

      if (image == null) {
        setState(() {
          isPredicting = false;
        });

        return;
      }

      img.Image resizedImage = img.copyResize(
        image,
        width: 224,
        height: 224,
      );

      var input = List.generate(
        1,
        (_) => List.generate(
          224,
          (y) => List.generate(
            224,
            (x) {
              final pixel = resizedImage.getPixel(x, y);

              return [
                pixel.r / 255.0,
                pixel.g / 255.0,
                pixel.b / 255.0,
              ];
            },
          ),
        ),
      );

      var output = List.generate(
        1,
        (_) => List.filled(
          labels.length,
          0.0,
        ),
      );

      interpreter!.run(input, output);

      double maxScore = 0.0;

      int maxIndex = 0;

      for (int i = 0; i < output[0].length; i++) {
        if (output[0][i] > maxScore) {
          maxScore = output[0][i];

          maxIndex = i;
        }
      }

      prediction = labels[maxIndex];

      confidence = maxScore * 100;

      generateTreatment(
        prediction.toLowerCase(),
      );
    } catch (e) {
      print("PREDICTION ERROR : $e");
    }

    if (!mounted) return;

    setState(() {
      isPredicting = false;
    });
  }

  // ================= AI ADVISORY =================

  void generateTreatment(String disease) {
    if (disease.contains('healthy')) {
      scientificName = "Healthy Crop";

      severity = "No Risk";

      symptoms = "Leaves appear healthy, green, and disease free.";

      cause =
          "Plant is receiving proper nutrients and environmental conditions.";

      treatment =
          "Continue maintaining proper watering and balanced nutrients.";

      pesticide = "No pesticide required.";

      dosage = "Not Required";

      sprayTime = "Not Required";

      organicSolution = "Apply compost every 15 days.";

      fertilizer = "Balanced NPK Fertilizer";

      fertilizerDose = "1kg per acre";

      irrigation = "Provide regular watering.";

      prevention = "Continue monitoring crop regularly.";

      recovery = "Crop is healthy.";

      weatherWarning = "Heavy rainfall may increase fungal disease risk.";
    } else if (disease.contains('early')) {
      scientificName = "Alternaria solani";

      severity = "Moderate Risk";

      symptoms = "Brown spots with yellow leaf edges.";

      cause = "Fungal infection caused by humid climate.";

      treatment = "Remove infected leaves immediately.";

      pesticide = "Mancozeb 75% WP";

      dosage = "2.5g per liter water";

      sprayTime = "Morning or evening";

      organicSolution = "Neem oil spray every 5 days.";

      fertilizer = "Potassium Nitrate";

      fertilizerDose = "1.5kg per acre";

      irrigation = "Avoid water on leaves.";

      prevention = "Maintain spacing between plants.";

      recovery = "10-15 days";

      weatherWarning = "Humidity increases disease spread.";
    } else if (disease.contains('late')) {
      scientificName = "Phytophthora infestans";

      severity = "High Risk";

      symptoms = "Dark wet patches and rapid leaf drying.";

      cause = "Cool humid conditions.";

      treatment = "Remove infected areas immediately.";

      pesticide = "Copper Oxychloride";

      dosage = "3g per liter water";

      sprayTime = "Evening spray";

      organicSolution = "Baking soda spray.";

      fertilizer = "Calcium Nitrate";

      fertilizerDose = "2kg per acre";

      irrigation = "Reduce overhead watering.";

      prevention = "Avoid overcrowding.";

      recovery = "2-3 weeks";

      weatherWarning = "Rainfall may rapidly spread infection.";
    } else {
      scientificName = "Unknown Disease";

      severity = "Medium Risk";

      symptoms = "Symptoms could not be fully identified.";

      cause = "Disease may require manual inspection.";

      treatment = "Consult agricultural expert.";

      pesticide = "General fungicide spray.";

      dosage = "As recommended";

      sprayTime = "Morning";

      organicSolution = "Neem oil spray.";

      fertilizer = "Balanced fertilizer";

      fertilizerDose = "1kg per acre";

      irrigation = "Avoid excess watering.";

      prevention = "Monitor crop regularly.";

      recovery = "Depends on infection.";

      weatherWarning = "Monitor weather changes.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F1),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= HEADER =================

              Text(
                "AI Disease Scanner",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "Scan crop leaf for instant diagnosis",
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 28),

              // ================= SCANNER =================

              Container(
                height: 430,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: selectedImage != null
                          ? Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            )
                          : Container(
                              color: Colors.black87,
                              child: const Center(
                                child: Icon(
                                  Icons.document_scanner,
                                  color: Colors.white54,
                                  size: 90,
                                ),
                              ),
                            ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Container(
                          width: 260,
                          height: 260,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 24,
                      left: 24,
                      child: Text(
                        "Align leaf inside frame",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (isPredicting)
                      const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ================= BUTTONS =================

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  scannerButton(
                    icon: Icons.photo_library_outlined,
                    label: "Gallery",
                    onTap: pickFromGallery,
                  ),
                  GestureDetector(
                    onTap: pickFromCamera,
                    child: Container(
                      height: 95,
                      width: 95,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 38,
                      ),
                    ),
                  ),
                  scannerButton(
                    icon: Icons.flash_on_outlined,
                    label: "Flash",
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 34),

              // ================= RESULT =================

              if (prediction != "No Prediction")
                Column(
                  children: [
                    // HEADER CARD

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: prediction.toLowerCase().contains("healthy")
                              ? [
                                  const Color(0xFFB7F5C5),
                                  const Color(0xFF7BE495),
                                ]
                              : [
                                  const Color(0xFFFFD6D6),
                                  const Color(0xFFFFA8A8),
                                ],
                        ),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.white,
                            child: Icon(
                              prediction.toLowerCase().contains("healthy")
                                  ? Icons.check_circle
                                  : Icons.coronavirus,
                              color:
                                  prediction.toLowerCase().contains("healthy")
                                      ? Colors.green
                                      : Colors.red,
                              size: 55,
                            ),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            prediction,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            scientificName,
                            style: GoogleFonts.poppins(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 20),
                          LinearProgressIndicator(
                            minHeight: 10,
                            value: confidence / 100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            "${confidence.toStringAsFixed(1)}% Confidence",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              "Severity : $severity",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    infoCard(
                      "Symptoms",
                      Icons.warning_amber_rounded,
                      Colors.orange,
                      symptoms,
                    ),

                    const SizedBox(height: 18),

                    infoCard(
                      "Cause",
                      Icons.coronavirus,
                      Colors.red,
                      cause,
                    ),

                    const SizedBox(height: 18),

                    infoCard(
                      "Treatment",
                      Icons.healing,
                      Colors.blue,
                      treatment,
                    ),

                    const SizedBox(height: 18),

                    infoCard(
                      "Pesticide",
                      Icons.science,
                      Colors.green,
                      "$pesticide\n\nDosage : $dosage\n\nBest Time : $sprayTime",
                    ),

                    const SizedBox(height: 18),

                    infoCard(
                      "Organic Solution",
                      Icons.eco,
                      Colors.teal,
                      organicSolution,
                    ),

                    const SizedBox(height: 18),

                    infoCard(
                      "Fertilizer",
                      Icons.grass,
                      Colors.deepPurple,
                      "$fertilizer\n\nDose : $fertilizerDose",
                    ),

                    const SizedBox(height: 18),

                    infoCard(
                      "Irrigation Advice",
                      Icons.water_drop,
                      Colors.blue,
                      irrigation,
                    ),

                    const SizedBox(height: 18),

                    infoCard(
                      "Prevention Tips",
                      Icons.shield,
                      Colors.green,
                      prevention,
                    ),

                    const SizedBox(height: 18),

                    infoCard(
                      "Recovery Duration",
                      Icons.timer,
                      Colors.orange,
                      recovery,
                    ),

                    const SizedBox(height: 18),

                    infoCard(
                      "Weather Alert",
                      Icons.cloud,
                      Colors.red,
                      weatherWarning,
                    ),
                  ],
                ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ================= BUTTON =================

  Widget scannerButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 95,
        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Icon(icon),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.poppins(),
            ),
          ],
        ),
      ),
    );
  }

  // ================= INFO CARD =================

  Widget infoCard(
    String title,
    IconData icon,
    Color color,
    String content,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
              const SizedBox(width: 14),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            content,
            style: GoogleFonts.poppins(
              height: 1.8,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
