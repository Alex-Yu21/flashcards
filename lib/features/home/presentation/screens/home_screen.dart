import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flashcards/core/theme/app_colors.dart';
import 'package:flashcards/features/home/cubit/statistics_cubit.dart';
import 'package:flashcards/features/home/cubit/statistics_state.dart';
import 'package:flashcards/features/home/presentation/widgets/progress_bar_widget.dart';
import 'package:flashcards/features/home/presentation/widgets/start_learning_card_swiper_widget.dart';
import 'package:flashcards/features/home/presentation/widgets/status_overview_widget.dart';
import 'package:flashcards/features/learning/presentation/screens/learning_screen.dart';
import 'package:flashcards/shared/domain/entities/card_category.dart';
import 'package:flashcards/shared/domain/repositories/flashcard_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenRoute extends StatelessWidget {
  const HomeScreenRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.read<FlashcardRepository>();

    return BlocProvider(
      create: (_) => StatisticsCubit(repo)..init(),
      child: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    final cs = Theme.of(context).colorScheme;
    final pXS = context.paddingXS;
    final pS = context.paddingS;
    final pM = context.paddingM;
    final pL = context.paddingL;

    return Scaffold(
      backgroundColor: cs.surface,
      bottomNavigationBar: _bottomBar(cs),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 18,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: pM, vertical: pXS),
                child: _header(context, h),
              ),
            ),

            SizedBox(height: pL),

            const Flexible(
              flex: 24,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: ProgressBarWidget(),
              ),
            ),

            SizedBox(height: pL),

            Flexible(
              flex: 64,
              child: _bottomSheet(
                h: h,
                w: w,
                pS: pS,
                pM: pM,
                learningTap: () => _openLearningScreen(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomBar(ColorScheme cs) => BottomNavigationBar(
    backgroundColor: cs.onSurfaceVariant,
    selectedItemColor: AppColors.tertiary40,
    unselectedItemColor: cs.outlineVariant,
    currentIndex: 0,
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
      BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: ''),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
    ],
  );

  Widget _header(BuildContext context, double h) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Todays\ndashboard', style: context.headerStyle),
      CircleAvatar(radius: h * 0.028, backgroundImage: const NetworkImage('')),
    ],
  );

  Widget _bottomSheet({
    required double h,
    required double w,
    required double pS,
    required double pM,
    required VoidCallback learningTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha((0.2 * 255).round()),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: pS, vertical: pM),
            child: BlocBuilder<StatisticsCubit, StatisticsState>(
              builder: (_, state) {
                int val(CardCategory c) => state.currentCounts[c] ?? 0;
                int delta(CardCategory c) =>
                    val(c) - (state.initialCounts[c] ?? 0);

                return StatusOverviewWidget(
                  newWords: val(CardCategory.newWords),
                  learning: val(CardCategory.learning),
                  reviewing: val(CardCategory.reviewing),
                  mastered: val(CardCategory.mastered),
                  newWordsDelta: delta(CardCategory.newWords),
                  learningDelta: delta(CardCategory.learning),
                  reviewingDelta: delta(CardCategory.reviewing),
                  masteredDelta: delta(CardCategory.mastered),
                );
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.only(right: pM),
            child: SizedBox(
              height: h * 0.30,
              width: w * 0.90,
              child: StartLearningCardSwiperWidget(w: w, onTap: learningTap),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openLearningScreen(BuildContext context) async {
    final statsCubit = context.read<StatisticsCubit>();

    await Navigator.of(context).push(
      _bottomUpRoute(
        RepositoryProvider.value(
          value: context.read<FlashcardRepository>(),
          child: const LearningScreen(),
        ),
      ),
    );
    statsCubit.refresh();
  }

  PageRouteBuilder<bool> _bottomUpRoute(Widget page) {
    return PageRouteBuilder<bool>(
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        final tween = Tween(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOutCubic));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}
