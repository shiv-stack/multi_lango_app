import 'package:flutter/material.dart';
import 'package:language_learning_app/shared/widgets/progress_circle.dart';

const List<Map<String, dynamic>> _dummyFriends = [
  {
    'name': 'Priya Sharma',
    'avatar': '👩',
    'progress': 85.0,
  },
  {
    'name': 'Rahul Patel',
    'avatar': '👨',
    'progress': 72.0,
  },
  {
    'name': 'Anita Gupta',
    'avatar': '👩',
    'progress': 95.0,
  },
  {
    'name': 'Vikram Singh',
    'avatar': '👨',
    'progress': 68.0,
  },
];

class FriendsProgressPage extends StatelessWidget {
  const FriendsProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Friends')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search friends',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Friend added! 👥')),
                    );
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: _dummyFriends.length,
              itemBuilder: (context, index) {
                final friend = _dummyFriends[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(friend['avatar']),
                    ),
                    title: Text(friend['name']),
                    trailing: ProgressCircle(
                      progress: friend['progress'],
                      progressColor: Colors.green,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
