import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flashcards/core/theme/app_colors.dart';
import 'package:flashcards/domain/entities/card_category.dart';
import 'package:flashcards/domain/entities/flashcard.dart';
import 'package:flashcards/presentation/cubit/flashcard/flashcard_cubit.dart';
import 'package:flashcards/presentation/views/add_new_card/widgets/new_card_widget.dart';
import 'package:flashcards/presentation/widgets/action_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewCardView extends StatefulWidget {
  const AddNewCardView({super.key});

  @override
  State<AddNewCardView> createState() => _AddNewCardViewState();
}

class _AddNewCardViewState extends State<AddNewCardView> {
  final _wordCtrl = TextEditingController();
  final _transcrCtrl = TextEditingController();
  final _translationCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  final _exampleCtrl = TextEditingController();

  @override
  void dispose() {
    _wordCtrl.dispose();
    _transcrCtrl.dispose();
    _translationCtrl.dispose();
    _descriptionCtrl.dispose();
    _exampleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color kBgColor = Colors.grey.withAlpha((0.2 * 255).round());
    return Scaffold(
      appBar: AppBar(backgroundColor: kBgColor),
      body: Container(
        color: kBgColor,
        width: double.infinity,
        height: context.screenHeight,
        child: Padding(
          padding: EdgeInsets.all(context.paddingS),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    NewCardWidget(
                      wordCtrl: _wordCtrl,
                      transcrCtrl: _transcrCtrl,
                      translationCtrl: _translationCtrl,
                      descriptionCtrl: _descriptionCtrl,
                      exampleCtrl: _exampleCtrl,
                    ),
                    SizedBox(height: context.paddingS),
                    Row(
                      children: [
                        SizedBox(width: context.paddingXS),
                        ActionButtonWidget(icon: Icons.add, onTap: () {}),
                        const Spacer(),
                        ActionButtonWidget(
                          icon: Icons.done,
                          color: AppColors.yes2,
                          onTap: () {
                            context.read<FlashcardCubit>().addFlashcard(
                              Flashcard(
                                id:
                                    DateTime.now().millisecondsSinceEpoch
                                        .toString(),
                                title: _wordCtrl.text.trim(),
                                transcription: _transcrCtrl.text.trim(),
                                translation: _translationCtrl.text.trim(),
                                description: _descriptionCtrl.text.trim(),
                                example: _exampleCtrl.text.trim(),
                                category: CardCategory.newWords,
                              ),
                            );
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(width: context.paddingXS),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
