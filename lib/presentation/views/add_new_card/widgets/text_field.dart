import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flashcards/presentation/cubit/add_card/add_card_cubit.dart';
import 'package:flashcards/presentation/cubit/add_card/add_cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Field extends StatelessWidget {
  const Field({
    super.key,
    required this.controller,
    required this.label,
    required this.fieldId,
    this.maxLines = 1,
    this.initialText,
  });

  final TextEditingController controller;
  final String label;
  final FieldId fieldId;
  final int maxLines;
  final String? initialText;

  @override
  Widget build(BuildContext context) {
    final bodyStyle = context.bodyStyle;
    final cS = Theme.of(context).colorScheme;

    return BlocBuilder<AddCardCubit, AddCardState>(
      buildWhen: (_, n) => n is AddCardEditing,
      builder: (context, state) {
        final err = (state is AddCardEditing) ? state.errors[fieldId] : null;

        return Padding(
          padding: EdgeInsets.only(bottom: context.paddingXS),
          child: TextFormField(
            controller: controller,
            maxLines: maxLines,
            style: bodyStyle,
            onChanged:
                (v) => context.read<AddCardCubit>().onChanged(fieldId, v),
            decoration: InputDecoration(
              labelText: label,
              errorText: err,
              labelStyle: bodyStyle,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: cS.outline.withAlpha((255 * 0.2).round()),
                  width: 1,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: cS.outlineVariant.withAlpha((255 * 0.6).round()),
                  width: 1.5,
                ),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: cS.error, width: 1.5),
              ),
            ),
          ),
        );
      },
    );
  }
}
