import 'club.dart';

class Klasemen {
  final Club club;
  int play;
  int win;
  int draw;
  int lose;
  int goalWin;
  int goalLose;
  int point;

  Klasemen({
    required this.club,
    this.play = 0,
    this.win = 0,
    this.draw = 0,
    this.lose = 0,
    this.goalWin = 0,
    this.goalLose = 0,
    this.point = 0,
  });
}
