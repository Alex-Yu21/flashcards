import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flashcards/core/theme/app_colors.dart';
import 'package:flashcards/features/categories/presentation/widgets/category_widget.dart';
import 'package:flashcards/features/tabs/presentation/screens/tabs_screen.dart';
import 'package:flashcards/shared/widgets/action_button_widget.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    double padM = context.paddingM;
    double padS = context.paddingS;
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
          Padding(
            padding: EdgeInsets.all(padM),
            child: Column(
              spacing: padS,
              children: [
                CategoryWidget(
                  label: 'New words',
                  count: 10,
                  caption: '- Repeat',
                  onTap: () {},
                ),
                CategoryWidget(
                  label: 'Learning',
                  count: 10,
                  caption: '',
                  onTap: () {},
                ),
                CategoryWidget(
                  label: 'Reviewing',
                  count: 10,
                  caption: '',
                  onTap: () {},
                ),
                CategoryWidget(
                  label: 'Mastered',
                  count: 10,
                  caption: '',
                  onTap: () {},
                ),
              ],
            ),
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
