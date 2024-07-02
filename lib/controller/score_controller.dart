import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreController extends ChangeNotifier {
  int _currentScore = 0;
  int _highScore = 0;

  int get currentScore => _currentScore;
  int get highScore => _highScore;

  ScoreController() {
    _loadHighScore();
  }

  void _loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    _highScore = prefs.getInt('high_score') ?? 0;
    notifyListeners();
  }

  void _saveHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('high_score', _highScore);
  }

  void increaseScore() {
    _currentScore++;
    if (_currentScore > _highScore) {
      _highScore = _currentScore;
      _saveHighScore();
    }
    notifyListeners();
  }

  void resetScore() {
    _currentScore = 0;
    notifyListeners();
  }
}
