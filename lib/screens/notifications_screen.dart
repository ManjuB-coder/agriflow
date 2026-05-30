import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Notifications"),
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.cloud, color: Colors.white),
            ),
            title: Text("Weather Alert"),
            subtitle: Text(
              "Rain expected tomorrow. Consider delaying irrigation.",
            ),
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Icon(Icons.bug_report, color: Colors.white),
            ),
            title: Text("Disease Alert"),
            subtitle: Text(
              "High humidity detected. Monitor crops for fungal infections.",
            ),
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.currency_rupee, color: Colors.white),
            ),
            title: Text("Market Alert"),
            subtitle: Text(
              "Tomato prices increased by 12% today.",
            ),
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.purple,
              child: Icon(Icons.account_balance, color: Colors.white),
            ),
            title: Text("Scheme Alert"),
            subtitle: Text(
              "PM-KISAN registration deadline approaching.",
            ),
          ),
        ],
      ),
    );
  }
}
