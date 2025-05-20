import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flashcards/core/theme/app_colors.dart';
import 'package:flashcards/domain/entities/card_category.dart';
import 'package:flashcards/domain/entities/flashcard.dart';
import 'package:flashcards/presentation/cubit/flashcard/flashcard_cubit.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withAlpha((0.2 * 255).round()),
      ),
      body: Container(
        padding: EdgeInsets.all(context.paddingS),
        color: Colors.grey.withAlpha((0.2 * 255).round()),
        width: double.infinity,
        height: context.screenHeight,
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
                      Expanded(
                        child: ActionButtonWidget(
                          icon: Icons.add,
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: ActionButtonWidget(
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewCardWidget extends StatelessWidget {
  const NewCardWidget({
    super.key,
    required this.wordCtrl,
    required this.transcrCtrl,
    required this.translationCtrl,
    required this.descriptionCtrl,
    required this.exampleCtrl,
  });

  final TextEditingController wordCtrl;
  final TextEditingController transcrCtrl;
  final TextEditingController translationCtrl;
  final TextEditingController descriptionCtrl;
  final TextEditingController exampleCtrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(context.paddingS),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Text('FRONT SIDE', style: context.bodyStyle),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ],
              ),
            ),
            _Field(controller: wordCtrl, label: 'word'),
            _Field(controller: transcrCtrl, label: 'transcription'),
            _Field(controller: descriptionCtrl, label: 'description'),
            Text('BACK SIDE', style: context.bodyStyle),
            _Field(controller: translationCtrl, label: 'translation'),
            _Field(
              controller: exampleCtrl,
              label: 'Example sentence',
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.label,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String label;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        style: context.bodyStyle,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: context.bodyStyle,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withAlpha((0.2 * 255).round()),
              width: 1,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.5),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
