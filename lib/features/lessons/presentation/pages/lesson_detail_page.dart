import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:language_learning_app/core/di/service_locator.dart';
import 'package:language_learning_app/features/lessons/bloc/lesson_bloc.dart';
import 'package:language_learning_app/features/lessons/bloc/lesson_event.dart';
import 'package:language_learning_app/shared/widgets/custom_button.dart';


class LessonDetailPage extends StatelessWidget {
  final String category;
  final String lessonId;

  const LessonDetailPage({
    super.key,
    required this.category,
    required this.lessonId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LessonBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Lesson Detail')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Mock lesson content based on category
              _LessonContent(category: category),
              const Spacer(),
              CustomButton(
                text: 'Complete Lesson',
                onPressed: () {
                  context.read<LessonBloc>().add(CompleteLessonEvent(category, lessonId));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Lesson completed! 🎉')),
                  );
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LessonContent extends StatelessWidget {
  final String category;

  const _LessonContent({required this.category});

  @override
  Widget build(BuildContext context) {
    switch (category) {
      case 'Reading':
        return _ReadingContent();
      case 'Listening':
        return _ListeningContent();
      case 'Speaking':
        return _SpeakingContent();
      case 'Grammar':
        return _GrammarContent();
      default:
        return const Text('Lesson content');
    }
  }
}

class _ReadingContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Reading Exercise', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Bonjour! Comment allez-vous? Read and understand the French greeting.',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        SizedBox(height: 20),
        Text('Question: What does "Bonjour" mean?', style: TextStyle(fontSize: 16)),
        SizedBox(height: 10),
        Card(child: Padding(padding: EdgeInsets.all(12), child: Text('Hello!'))),
      ],
    );
  }
}

class _ListeningContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Listening Exercise', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Icon(Icons.volume_up, size: 64, color: Colors.blue),
                SizedBox(height: 16),
                Text('Listen to the audio and repeat', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('Audio: "Bonjour, comment ça va?"', style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SpeakingContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Speaking Practice', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Icon(Icons.mic, size: 64, color: Colors.green),
                SizedBox(height: 16),
                Text('Practice saying:', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('"Je m\'appelle [Your Name]"', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Text('Tap and speak for 5 seconds', style: TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _GrammarContent extends StatefulWidget {
  @override
  State<_GrammarContent> createState() => _GrammarContentState();
}

class _GrammarContentState extends State<_GrammarContent> {
  int _selectedAnswer = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Grammar Quiz', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text('Choose the correct article:', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('___ maison (house)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        ...List.generate(4, (index) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Card(
            color: _selectedAnswer == index 
                ? (_selectedAnswer == 0 ? Colors.green : Colors.red)
                : null,
            child: ListTile(
              title: Text(['la', 'le', 'un', 'une'][index]),
              onTap: () => setState(() => _selectedAnswer = index),
            ),
          ),
        )),
      ],
    );
  }
}
