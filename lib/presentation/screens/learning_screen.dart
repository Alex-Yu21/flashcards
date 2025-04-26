import 'package:flashcards/data/dummy_data.dart';
import 'package:flashcards/presentation/widgets/flashcard_widget.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'name c test',
          style: TextStyle(
            color: Color(0xFF2E2E2E),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // TODO progress bar
          SizedBox(height: 150),
          SizedBox(
            height: 300,
            width: double.infinity,
            child:
            // CardSwiper(
            //   cardsCount: dummyFlashcards.length,
            //   cardBuilder:
            //       (context, index, percentThresholdX, percentThresholdY) =>
            FlashcardWidget(flashcard: dummyFlashcards.first),
            //   // TODO  isLoop: false, и окно со статистикой сколько помнит сколько нужно повторить с кнопкой ок и переходом на предыдущий экран
            //   padding: EdgeInsets.zero,
            // ),
          ),
          SizedBox(height: 50),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 200,
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(Icons.close, size: 50),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(),
                  child: Icon(Icons.done, size: 50),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
