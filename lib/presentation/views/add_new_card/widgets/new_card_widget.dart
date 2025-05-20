import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flashcards/presentation/views/add_new_card/widgets/text_field.dart';
import 'package:flutter/material.dart';

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
            Field(controller: wordCtrl, label: 'word'),
            Field(controller: transcrCtrl, label: 'transcription'),
            Field(controller: descriptionCtrl, label: 'description'),
            Text('BACK SIDE', style: context.bodyStyle),
            Field(controller: translationCtrl, label: 'translation'),
            Field(
              controller: exampleCtrl,
              label: 'example sentence',
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
