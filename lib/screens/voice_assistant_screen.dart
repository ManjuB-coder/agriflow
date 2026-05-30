import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'saved_conversation_screen.dart';

class VoiceAssistantScreen extends StatefulWidget {
  const VoiceAssistantScreen({super.key});

  @override
  State<VoiceAssistantScreen> createState() => _VoiceAssistantScreenState();
}

class _VoiceAssistantScreenState extends State<VoiceAssistantScreen> {
  late stt.SpeechToText speech;

  late FlutterTts flutterTts;

  bool isListening = false;

  bool isLoading = false;

  bool isSpeaking = false;

  bool isDarkMode = false;

  bool autoSpeak = false;

  String spokenText = "";

  String responseText = "Hello Farmer 👋\n\nAsk me anything about farming.";

  String selectedLanguage = "en-US";

  String currentChatTitle = "New Conversation";

  List<Map<String, String>> savedChats = [];

  final String groqApiKey = "";

  // ================= TRANSLATIONS =================

  Map<String, Map<String, String>> translations = {
    "en": {
      "title": "Voice Assistant",
      "hello": "Hello Farmer! 👋",
      "subtitle": "How can I help you?",
      "listening": "Listening...",
      "tap": "Tap mic and speak",
      "try": "Try saying",
    },
    "hi": {
      "title": "वॉयस असिस्टेंट",
      "hello": "नमस्ते किसान! 👋",
      "subtitle": "मैं आपकी कैसे मदद कर सकता हूँ?",
      "listening": "सुन रहा हूँ...",
      "tap": "माइक दबाकर बोलें",
      "try": "यह बोलकर देखें",
    },
    "te": {
      "title": "వాయిస్ అసిస్టెంట్",
      "hello": "హలో రైతు! 👋",
      "subtitle": "నేను మీకు ఎలా సహాయం చేయగలను?",
      "listening": "వింటున్నాను...",
      "tap": "మైక్ నొక్కి మాట్లాడండి",
      "try": "ఇలా అడగండి",
    },
    "kn": {
      "title": "ವಾಯ್ಸ್ ಅಸಿಸ್ಟೆಂಟ್",
      "hello": "ನಮಸ್ಕಾರ ರೈತರೆ! 👋",
      "subtitle": "ನಾನು ಹೇಗೆ ಸಹಾಯ ಮಾಡಲಿ?",
      "listening": "ಕೆಳಗೊಳ್ಳುತ್ತಿದೆ...",
      "tap": "ಮೈಕ್ ಒತ್ತಿ ಮಾತನಾಡಿ",
      "try": "ಹೀಗೆ ಕೇಳಿ",
    },
    "ta": {
      "title": "குரல் உதவியாளர்",
      "hello": "வணக்கம் விவசாயி! 👋",
      "subtitle": "நான் எப்படி உதவலாம்?",
      "listening": "கேட்டுக்கொண்டு இருக்கிறது...",
      "tap": "மைக் அழுத்தி பேசுங்கள்",
      "try": "இப்படி கேளுங்கள்",
    },
  };

  @override
  void initState() {
    super.initState();

    speech = stt.SpeechToText();

    flutterTts = FlutterTts();

    initTTS();
  }

  // ================= CURRENT LANGUAGE =================

  String get currentLang {
    if (selectedLanguage.startsWith("hi")) {
      return "hi";
    }

    if (selectedLanguage.startsWith("te")) {
      return "te";
    }

    if (selectedLanguage.startsWith("kn")) {
      return "kn";
    }

    if (selectedLanguage.startsWith("ta")) {
      return "ta";
    }

    return "en";
  }

  // ================= INIT TTS =================

  Future<void> initTTS() async {
    await flutterTts.setLanguage(
      selectedLanguage,
    );

    await flutterTts.setSpeechRate(0.42);

    await flutterTts.setPitch(1.0);

    await flutterTts.setVolume(1.0);
  }

  // ================= SPEAK =================

  Future<void> speak(String text) async {
    setState(() {
      isSpeaking = true;
    });

    await flutterTts.stop();

    await flutterTts.speak(text);

    flutterTts.setCompletionHandler(() {
      setState(() {
        isSpeaking = false;
      });
    });
  }

  // ================= STOP SPEAKING =================

  Future<void> stopSpeaking() async {
    await flutterTts.stop();

    setState(() {
      isSpeaking = false;
    });
  }

  // ================= START LISTENING =================

  Future<void> startListening() async {
    bool available = await speech.initialize(
      onStatus: (status) {
        print("STATUS: $status");

        if (status == "done") {
          setState(() {
            isListening = false;
          });
        }
      },
      onError: (error) {
        print("ERROR: $error");

        setState(() {
          isListening = false;
        });
      },
    );

    if (available) {
      setState(() {
        isListening = true;

        spokenText = "";
      });

      speech.listen(
        localeId: selectedLanguage,
        partialResults: true,
        cancelOnError: false,
        listenMode: stt.ListenMode.dictation,
        pauseFor: const Duration(seconds: 10),
        listenFor: const Duration(minutes: 2),
        onResult: (result) {
          setState(() {
            spokenText = result.recognizedWords;
          });

          print(
            "LIVE SPEECH: ${result.recognizedWords}",
          );

          if (result.finalResult && spokenText.trim().isNotEmpty) {
            stopListening();

            generateResponse(spokenText);
          }
        },
      );
    }
  }

  // ================= STOP LISTENING =================

  Future<void> stopListening() async {
    await speech.stop();

    setState(() {
      isListening = false;
    });
  }

  // ================= GENERATE RESPONSE =================

  Future<void> generateResponse(
    String query,
  ) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(
          'https://api.groq.com/openai/v1/chat/completions',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $groqApiKey',
        },
        body: jsonEncode({
          "model": "llama-3.1-8b-instant",
          "messages": [
            {
              "role": "system",
              "content": """
You are AgriFlow AI.

You are an agriculture expert assistant helping farmers.

Always reply in the SAME language as the user's question.

Give clear and practical farming solutions.

Explain:
1. Problem
2. Cause
3. Solution
4. Recommended pesticide/fertilizer
5. Prevention tips

Keep answers simple and farmer friendly.
"""
            },
            {
              "role": "user",
              "content": query,
            }
          ],
          "temperature": 0.7,
        }),
      );

      final data = jsonDecode(response.body);

      if (data['choices'] != null && data['choices'].length > 0) {
        responseText = data['choices'][0]['message']['content'];
      } else {
        responseText = "AI could not generate response.";
      }

      setState(() {
        isLoading = false;
      });

      if (autoSpeak) {
        speak(responseText);
      }
    } catch (e) {
      setState(() {
        isLoading = false;

        responseText = "ERROR: $e";
      });
    }
  }

  // ================= SAVE CHAT =================

  void saveCurrentChat() {
    if (spokenText.isNotEmpty && responseText.isNotEmpty) {
      savedChats.add({
        "question": spokenText,
        "answer": responseText,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Conversation Saved"),
        ),
      );
    }
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xFF121212) : const Color(0xFFEAF7E7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            child: Column(
              children: [
                // ================= TOP BAR =================

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: saveCurrentChat,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(
                            14,
                          ),
                        ),
                        child: const Icon(
                          Icons.save,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          currentChatTitle,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        Text(
                          translations[currentLang]!["title"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    PopupMenuButton(
                      color: isDarkMode ? Colors.black : Colors.white,
                      icon: Icon(
                        Icons.more_vert,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      itemBuilder: (_) => [
                        const PopupMenuItem(
                          value: "rename",
                          child: Text("Rename"),
                        ),
                        const PopupMenuItem(
                          value: "delete",
                          child: Text("Delete"),
                        ),
                        const PopupMenuItem(
                          value: "theme",
                          child: Text("Toggle Theme"),
                        ),
                      ],
                      onSelected: (value) {
                        if (value == "theme") {
                          setState(() {
                            isDarkMode = !isDarkMode;
                          });
                        }

                        if (value == "delete") {
                          setState(() {
                            spokenText = "";

                            responseText = "";
                          });
                        }

                        if (value == "rename") {
                          setState(() {
                            currentChatTitle = "Farm Chat";
                          });
                        }
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ================= LANGUAGE =================

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedLanguage,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.green,
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: "en-US",
                              child: Text("English"),
                            ),
                            DropdownMenuItem(
                              value: "hi-IN",
                              child: Text("Hindi"),
                            ),
                            DropdownMenuItem(
                              value: "te-IN",
                              child: Text("Telugu"),
                            ),
                            DropdownMenuItem(
                              value: "kn-IN",
                              child: Text("Kannada"),
                            ),
                            DropdownMenuItem(
                              value: "ta-IN",
                              child: Text("Tamil"),
                            ),
                          ],
                          onChanged: (value) async {
                            if (value != null) {
                              setState(() {
                                selectedLanguage = value;
                              });

                              await flutterTts.setLanguage(
                                value,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SavedConversationScreen(
                              chats: savedChats,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(
                            14,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.history,
                              color: Colors.white,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Saved",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                SwitchListTile(
                  value: autoSpeak,
                  activeThumbColor: Colors.green,
                  title: Text(
                    "Auto Speak AI Response",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      autoSpeak = value;
                    });
                  },
                ),

                const SizedBox(height: 10),

                Text(
                  translations[currentLang]!["hello"]!,
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    color: Colors.green.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  translations[currentLang]!["subtitle"]!,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                ),

                const SizedBox(height: 25),

                // ================= AI RESPONSE =================

                if (responseText.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(
                      20,
                    ),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? const Color(
                              0xFF1E1E1E,
                            )
                          : Colors.white,
                      borderRadius: BorderRadius.circular(
                        24,
                      ),
                    ),
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.green,
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Colors.green,
                                    child: Icon(
                                      Icons.smart_toy,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    "AgriFlow AI",
                                    style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                responseText,
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  height: 1.8,
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 18),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      speak(
                                        responseText,
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(
                                        10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade100,
                                        borderRadius: BorderRadius.circular(
                                          14,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.volume_up,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  GestureDetector(
                                    onTap: () {
                                      stopSpeaking();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(
                                        10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red.shade100,
                                        borderRadius: BorderRadius.circular(
                                          14,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.stop,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ),

                const SizedBox(height: 25),

                // ================= LIVE USER SPEECH =================

                if (spokenText.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(
                      18,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: Text(
                      spokenText,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        height: 1.7,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                const SizedBox(height: 30),

                // ================= MIC =================

                GestureDetector(
                  onTap: () {
                    if (isListening) {
                      stopListening();
                    } else {
                      startListening();
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 300,
                    ),
                    height: isListening ? 150 : 135,
                    width: isListening ? 150 : 135,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Colors.green.shade400,
                          Colors.green.shade700,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(
                            0.35,
                          ),
                          blurRadius: 30,
                          spreadRadius: 8,
                        ),
                      ],
                    ),
                    child: Icon(
                      isListening ? Icons.mic : Icons.mic_none,
                      color: Colors.white,
                      size: 65,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                Text(
                  isListening
                      ? translations[currentLang]!["listening"]!
                      : translations[currentLang]!["tap"]!,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
