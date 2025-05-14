import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flashcards/core/theme/app_colors.dart';
import 'package:flashcards/features/categories/presentation/widgets/category_widget.dart';
import 'package:flashcards/features/tabs/presentation/screens/tabs_screen.dart';
import 'package:flashcards/shared/cubit/status_overview_cubit.dart';
import 'package:flashcards/shared/widgets/action_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final padM = context.paddingM;
    final padS = context.paddingS;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withAlpha((0.2 * 255).round()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => TabsScreen.of(context)?.switchTo(0),
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
                    CategoryWidget(
                      label: 'Learning',
                      count: state.learning,
                      caption: '- For reviewing every other day',
                      onTap: () {},
                    ),
                    CategoryWidget(
                      label: 'Reviewing',
                      count: state.reviewing,
                      caption: '- For once a week refresh',
                      onTap: () {},
                    ),
                    CategoryWidget(
                      label: 'Mastered',
                      count: state.mastered,
                      caption: '- For occasionally repeating to retain',
                      onTap: () {},
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
              onTap: () {},
              icon: Icons.add,
              color: AppColors.tertiary50,
            ),
          ),
        ],
      ),
    );
  }
}
