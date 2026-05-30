import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SavedConversationScreen extends StatelessWidget {
  final List<Map<String, String>> chats;

  const SavedConversationScreen({
    super.key,
    required this.chats,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF7E7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Saved Conversations",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: chats.isEmpty
          ? Center(
              child: Text(
                "No Saved Conversations",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];

                return Container(
                  margin: const EdgeInsets.only(
                    bottom: 18,
                  ),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                          0.04,
                        ),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ================= QUESTION =================

                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Farmer Question",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      Text(
                        chat["question"] ?? "",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          height: 1.7,
                        ),
                      ),

                      const SizedBox(height: 28),

                      // ================= ANSWER =================

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
                            "AgriFlow AI Answer",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      Text(
                        chat["answer"] ?? "",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          height: 1.8,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
