import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flashcards/presentation/cubit/add_card/add_card_cubit.dart';
import 'package:flashcards/presentation/cubit/add_card/add_cart_state.dart';
import 'package:flashcards/presentation/views/add_new_card/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewCardWidget extends StatelessWidget {
  const NewCardWidget({super.key, required this.data, required this.index});

  final AddCardEditing data;
  final int index;

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
                      onPressed:
                          () =>
                              context.read<AddCardCubit>().removeForm(data.id),
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ],
              ),
            ),
            Field(
              initial: data.word,
              label: 'word*',
              fieldId: FieldId.word,
              index: index,
            ),
            Field(
              initial: data.transcription,
              label: 'transcription',
              fieldId: FieldId.transcription,
              index: index,
            ),
            Field(
              initial: data.description,
              label: 'description',
              fieldId: FieldId.description,
              index: index,
            ),
            Text('BACK SIDE', style: context.bodyStyle),
            Field(
              initial: data.translation,
              label: 'translation*',
              fieldId: FieldId.translation,
              index: index,
            ),
            Field(
              initial: data.example,
              label: 'example sentence',
              maxLines: 2,
              fieldId: FieldId.example,
              index: index,
            ),
          ],
        ),
      ),
    );
  }
}
