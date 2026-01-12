import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:language_learning_app/features/lessons/bloc/lesson_bloc.dart';
import 'package:language_learning_app/features/lessons/bloc/lesson_event.dart';
import 'package:language_learning_app/features/lessons/bloc/lesson_state.dart';
import '../../../../shared/widgets/lesson_card.dart';

class LessonCategoryPage extends StatefulWidget {
  final String category;

  const LessonCategoryPage({super.key, required this.category});

  @override
  State<LessonCategoryPage> createState() => _LessonCategoryPageState();
}

class _LessonCategoryPageState extends State<LessonCategoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<LessonBloc>().add(LoadLessonsEvent(widget.category));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ],
      ),
      body: BlocBuilder<LessonBloc, LessonState>(
        builder: (context, state) {
          if (state is LessonLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is LessonsLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: state.lessons.length,
              itemBuilder: (context, index) {
                final lesson = state.lessons[index];
                return LessonCard(
                  lesson: lesson,
                  onTap: () => context.push(
                    'lesson/${widget.category}/${lesson.id}',
                  ),
                );
              },
            );
          }
          return const Center(child: Text('No lessons available'));
        },
      ),
    );
  }
}
