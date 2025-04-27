import 'package:flashcards/presentation/extensions/context_extensions.dart';
import 'package:flashcards/presentation/screens/home_screen/widgets/start_learning_card_swiper.dart';
import 'package:flashcards/presentation/screens/home_screen/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Scaffold(
      bottomNavigationBar: const _BottomNavigation(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              _header(height: h, context: context),
              const SizedBox(height: 24),
              SizedBox(height: h * 0.2, child: ProgressBar()),
              const SizedBox(height: 24),
              SizedBox(
                height: h * 0.3,
                width: w * 0.9,
                child: StartLearningCardSwiper(w: w),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header({required double height, required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Todays\nflashcards', style: context.headerStyle),
        CircleAvatar(radius: height * 0.028, backgroundImage: NetworkImage('')),
      ],
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Theme.of(context).colorScheme.primaryFixed,
      unselectedItemColor: Theme.of(context).colorScheme.outlineVariant,
      currentIndex: 0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
      ],
    );
  }
}
