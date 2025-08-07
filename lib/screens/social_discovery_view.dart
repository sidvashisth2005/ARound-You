import 'package:flutter/material.dart';

class SocialDiscoveryView extends StatelessWidget {
  const SocialDiscoveryView({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Around You'),
        backgroundColor: theme.colorScheme.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.radar, size: 80, color: Colors.grey.shade600),
              const SizedBox(height: 24),
              const Text('Social Discovery Placeholder', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              const Text('This screen will scan for and display other active users within a 100m radius.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 16)),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {}, icon: const Icon(Icons.search), label: const Text('Scan for Nearby Users'),
                style: ElevatedButton.styleFrom(backgroundColor: theme.colorScheme.secondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 