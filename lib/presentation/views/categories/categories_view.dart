import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flashcards/core/theme/app_colors.dart';
import 'package:flashcards/presentation/cubit/status_overview_cubit.dart';
import 'package:flashcards/presentation/cubit/unlock_category_cubit.dart';
import 'package:flashcards/presentation/views/add_new_card/add_new_card_view.dart';
import 'package:flashcards/presentation/views/categories/widgets/category_widget.dart';
import 'package:flashcards/presentation/views/tabs/tabs_view.dart';
import 'package:flashcards/presentation/widgets/action_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final padM = context.paddingM;
    final padS = context.paddingS;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withAlpha((0.2 * 255).round()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => TabView.of(context)?.switchTo(0),
        ),
        title: const Text('Categories'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          BlocBuilder<StatusOverviewCubit, StatusOverviewState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.all(padM),
                child: Column(
                  spacing: padS,
                  children: [
                    CategoryWidget(
                      label: 'New words',
                      count: state.newWords,
                      caption: '- For every day practice',
                      onTap: () {},
                    ),
                    BlocProvider(
                      create:
                          (_) => CategoryUnlockCubit(
                            initiallyUnlocked: state.learning.to > 0,
                          ),
                      child: CategoryWidget(
                        label: 'Learning',
                        count: state.learning,
                        caption: '- For reviewing every other day',
                        onTap: () {},
                      ),
                    ),
                    BlocProvider(
                      create:
                          (_) => CategoryUnlockCubit(
                            initiallyUnlocked: state.reviewing.to > 0,
                          ),
                      child: CategoryWidget(
                        label: 'Reviewing',
                        count: state.reviewing,
                        caption: '- For once a week refresh',
                        onTap: () {},
                      ),
                    ),
                    BlocProvider(
                      create:
                          (_) => CategoryUnlockCubit(
                            initiallyUnlocked: state.mastered.to > 0,
                          ),
                      child: CategoryWidget(
                        label: 'Mastered',
                        count: state.mastered,
                        caption: '- For occasionally repeating to retain',
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + padM,
            left: 0,
            right: 0,
            child: ActionButtonWidget(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddNewCardView(),
                  ),
                );
              },
              icon: Icons.add,
              color: AppColors.tertiary50,
            ),
          ),
        ],
      ),
    );
  }
}

// FIXME unblock aanimation starts before screen is open again
