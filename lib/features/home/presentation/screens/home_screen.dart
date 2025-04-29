import 'package:flashcards/core/theme/app_colors.dart';
import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flashcards/features/home/presentation/widgets/start_learning_card_swiper_widget.dart';
import 'package:flashcards/features/home/presentation/widgets/progress_bar_widget.dart';
import 'package:flashcards/features/home/presentation/widgets/status_overview_widget.dart';
import 'package:flashcards/features/learning/presentation/screens/learning_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    final colors = Theme.of(context).colorScheme;
    final padXS = context.paddingXS;
    final padS = context.paddingS;
    final padM = context.paddingM;
    final padL = context.paddingL;

    return Scaffold(
      backgroundColor: colors.surface,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colors.onSurfaceVariant,
        selectedItemColor: AppColors.tertiary40,
        unselectedItemColor: colors.outlineVariant,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 18,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: padM,
                  vertical: padXS,
                ),
                child: _header(height: h, context: context),
              ),
            ),

            SizedBox(height: padL),

            Flexible(
              flex: 24,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const ProgressBarWidget(),
              ),
            ),

            SizedBox(height: padL),

            Flexible(
              flex: 64,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha((0.2 * 255).round()),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: padS,
                        vertical: padM,
                      ),
                      child: StatusOverviewWidget(
                        learning: 3,
                        reviewing: 2,
                        mastered: 10,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(right: padM),
                      child: SizedBox(
                        height: h * 0.30,
                        width: w * 0.90,
                        child: StartLearningCardSwiperWidget(
                          w: w,
                          onTap: () {
                            _openLearningScreen(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header({required double height, required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Todays\ndashboard', style: context.headerStyle),
        CircleAvatar(
          radius: height * 0.028,
          backgroundImage: const NetworkImage(''),
        ),
      ],
    );
  }

  PageRouteBuilder _bottomUpRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOutCubic));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  void _openLearningScreen(BuildContext context) {
    Navigator.of(context).push(_bottomUpRoute(const LearningScreen()));
  }
}
