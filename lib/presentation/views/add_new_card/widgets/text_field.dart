import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class Field extends StatefulWidget {
  const Field({
    super.key,
    required this.controller,
    required this.label,
    this.maxLines = 1,
    this.initialText,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final int maxLines;
  final String? initialText;
  final String? Function(String?)? validator;

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  @override
  void initState() {
    super.initState();
    if (widget.initialText != null && widget.controller.text.isEmpty) {
      widget.controller.text = widget.initialText!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bodyStyle = context.bodyStyle;
    final ColorScheme cS = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(bottom: context.paddingXS),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        style: bodyStyle,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          labelText: widget.label,
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
  }
}
