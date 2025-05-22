import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flashcards/domain/entities/card_category.dart';
import 'package:flashcards/domain/entities/flashcard.dart';
import 'package:flashcards/presentation/cubit/flashcard/flashcard_cubit.dart';
import 'package:flashcards/presentation/cubit/flashcard/flashcard_state.dart';
import 'package:flashcards/presentation/cubit/statistics/statistics_cubit.dart';
import 'package:flashcards/presentation/cubit/statistics/statistics_state.dart';
import 'package:flashcards/presentation/cubit/status_overview_cubit.dart';
import 'package:flashcards/presentation/views/home/widgets/progress_bar_widget.dart';
import 'package:flashcards/presentation/views/home/widgets/start_learning_card_swiper_widget.dart';
import 'package:flashcards/presentation/views/home/widgets/status_overview_widget.dart';
import 'package:flashcards/presentation/views/learning/learning_view.dart';
import 'package:flashcards/presentation/widgets/bottom_up_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    final cs = Theme.of(context).colorScheme;
    final pXS = context.paddingXS;
    final pS = context.paddingS;
    final pM = context.paddingM;
    final pL = context.paddingL;
    const url = '';

    // TODO url

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 18,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: pM, vertical: pXS),
                child: _header(context, h, url),
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
                context: context,
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

  Widget _header(BuildContext context, double h, String? url) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Today’s\ndashboard', style: context.headerStyle),
        CircleAvatar(
          radius: h * 0.028,
          backgroundImage:
              (url != null && url.isNotEmpty) ? NetworkImage(url) : null,
          child: (url == null || url.isEmpty) ? const Icon(Icons.person) : null,
        ),
      ],
    );
  }

  Widget _bottomSheet({
    required BuildContext context,
    required double h,
    required double w,
    required double pS,
    required double pM,
    required VoidCallback learningTap,
  }) {
    final state = context.read<FlashcardCubit>().state;
    final List<Flashcard> cards =
        state is FlashcardsLoaded ? state.flashcards : const <Flashcard>[];

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
            child: BlocListener<StatisticsCubit, StatisticsState>(
              listenWhen: (prev, curr) => prev != curr,
              listener: (context, state) {
                int val(CardCategory c) => state.currentCounts[c] ?? 0;

                context.read<StatusOverviewCubit>().update(
                  newWords: val(CardCategory.newWords),
                  learning: val(CardCategory.learning),
                  reviewing: val(CardCategory.reviewing),
                  mastered: val(CardCategory.mastered),
                );
              },
              child: const StatusOverviewWidget(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: pM),
            child: SizedBox(
              height: h * 0.30,
              width: w * 0.90,
              child: StartLearningCardSwiperWidget(
                w: w,
                onTap: learningTap,
                cards: cards,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openLearningScreen(BuildContext context) async {
    final statsCubit = context.read<StatisticsCubit>();

    await Navigator.of(context).push(bottomUpRoute(const LearningView()));
    statsCubit.refresh();
  }
}
