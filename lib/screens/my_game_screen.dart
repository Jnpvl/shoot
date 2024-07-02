import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:shoot/controller/score_controller.dart';
import '../game/my_game.dart';
import 'package:provider/provider.dart';

class MyGameScreen extends StatelessWidget {
  const MyGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scoreController = ScoreController();
    final myGame = MyGame(scoreController);

    myGame.setBuildContext(context);

    return ChangeNotifierProvider(
      create: (_) => scoreController,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Consumer<ScoreController>(
            builder: (context, score, child) {
              return Text(
                  'Score: ${score.currentScore}   High Score: ${score.highScore}');
            },
          ),
          centerTitle: true,
        ),
        body: GameWidget(
          game: myGame,
        ),
      ),
    );
  }
}
