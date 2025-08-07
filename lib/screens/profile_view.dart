import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userStreamProvider = StreamProvider.autoDispose<DocumentSnapshot>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return const Stream.empty();
  return FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots();
});

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final userData = ref.watch(userStreamProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'), backgroundColor: theme.colorScheme.surface,
        actions: [IconButton(icon: const Icon(Icons.logout), onPressed: () => FirebaseAuth.instance.signOut())],
      ),
      body: userData.when(
        data: (doc) {
          if (!doc.exists) return const Center(child: Text('User data not found.'));
          final data = doc.data() as Map<String, dynamic>;
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Center(
                child: Column(
                  children: [
                    const Icon(Icons.account_circle, size: 100, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(data['username'] ?? 'No Username', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(data['email'] ?? 'No Email', style: const TextStyle(fontSize: 16, color: Colors.grey)),
                  ],
                ),
              ),
              const SizedBox(height: 32), const Divider(), const SizedBox(height: 16),
              const Text('Achievements', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16, runSpacing: 16,
                children: [
                  _buildBadge(context, 'First Memory', Icons.star, Colors.amber),
                  _buildBadge(context, 'Explorer', Icons.explore, Colors.grey, locked: true),
                  _buildBadge(context, 'Social Butterfly', Icons.group, Colors.grey, locked: true),
                ],
              )
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildBadge(BuildContext context, String name, IconData icon, Color color, {bool locked = false}) {
    return Opacity(
      opacity: locked ? 0.4 : 1.0,
      child: Column(
        children: [
          CircleAvatar(radius: 35, backgroundColor: color, child: Icon(locked ? Icons.lock : icon, size: 30, color: Colors.white)),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
} 