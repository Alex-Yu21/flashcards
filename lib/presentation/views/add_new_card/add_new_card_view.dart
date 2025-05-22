import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flashcards/core/theme/app_colors.dart';
import 'package:flashcards/domain/repositories/flashcard_repository.dart';
import 'package:flashcards/presentation/cubit/add_card/add_card_cubit.dart';
import 'package:flashcards/presentation/cubit/add_card/add_cart_state.dart';
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
    return BlocProvider(
      create:
          (ctx) => AddCardCubit(
            ctx.read<FlashcardRepository>(),
            ctx.read<FlashcardCubit>(),
          ),
      child: BlocListener<AddCardCubit, AddCardState>(
        listenWhen:
            (prev, curr) => prev is! AddCardInitial && curr is AddCardInitial,
        listener: (_, __) => Navigator.of(context).pop(),
        child: Scaffold(
          appBar: AppBar(backgroundColor: kBgColor),
          body: Container(
            color: kBgColor,
            width: double.infinity,
            height: context.screenHeight,
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
                          BlocBuilder<AddCardCubit, AddCardState>(
                            builder: (context, state) {
                              return ActionButtonWidget(
                                icon: Icons.done,
                                color: AppColors.yes2,
                                onTap:
                                    () => context.read<AddCardCubit>().save(),
                              );
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
      ),
    );
  }
}
