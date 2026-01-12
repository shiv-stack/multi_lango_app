import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:language_learning_app/core/di/service_locator.dart';
import 'package:language_learning_app/features/profile/bloc/profile_state.dart';

import 'package:language_learning_app/features/profile/presentation/pages/profile_page.dart';
import 'package:language_learning_app/features/progress/bloc/progress_bloc.dart';
import 'package:language_learning_app/features/progress/bloc/progress_event.dart';
import 'package:language_learning_app/features/progress/bloc/progress_state.dart';
import 'package:language_learning_app/features/progress/presentation/pages/friends_progress_page.dart';
import 'package:language_learning_app/shared/widgets/progress_circle.dart';
import '../../../../features/profile/bloc/profile_bloc.dart';
import '../../../../features/profile/bloc/profile_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const _HomeContent(),
      const SizedBox(),
      const FriendsProgressPage(),
      const ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          if (index == 1) context.go('lesson-category/Reading');
          if (index == 2) context.go('friends');
          if (index == 3) context.go('profile');
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Practice'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Friends'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ProgressBloc>()..add(LoadProgressEvent())),
        BlocProvider(create: (_) => sl<ProfileBloc>()..add(LoadProfileEvent())),
      ],
      child: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _GreetingSection(),
            SizedBox(height: 32),
            _ContinueButton(),
            SizedBox(height: 32),
            _CategoriesSection(),
          ],
        ),
      ),
    );
  }
}

class _GreetingSection extends StatelessWidget {
  const _GreetingSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const CircularProgressIndicator();
        }
        if (state is ProfileLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello ${state.user.username},',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Continue to French!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          );
        }
        return const Text('Welcome!');
      },
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.play_arrow, size: 28),
        label: const Text('Continue Learning', style: TextStyle(fontSize: 18)),
        onPressed: () => context.go('lesson-category/Reading'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}

class _CategoriesSection extends StatelessWidget {
  const _CategoriesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Practice Areas',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            TextButton(
              onPressed: () => context.go('lesson-category/Reading'),
              child: const Text('See All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        BlocBuilder<ProgressBloc, ProgressState>(
          builder: (context, state) {
            if (state is ProgressLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProgressLoaded) {
              return Column(
                children: [
                  for (int i = 0; i < state.progress.length; i += 2)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          Expanded(child: _CategoryCard(progress: state.progress[i])),
                          const SizedBox(width: 16),
                          Expanded(child: _CategoryCard(progress: state.progress[i + 1])),
                        ],
                      ),
                    ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final dynamic progress;

  const _CategoryCard({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ProgressCircle(progress: progress.percentage ?? 0),
            const SizedBox(height: 12),
            Text(
              progress.category ?? '',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
