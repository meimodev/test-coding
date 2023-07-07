import 'package:test_coding/models/club.dart';

class MatchApp {
  Club? homeClub;
  Club? awayClub;
  int? homeScore;
  int? awayScore;

  MatchApp({
     this.homeClub,
     this.awayClub,
    this.homeScore = 0,
    this.awayScore = 0,
  });

  MatchApp.empty({
    this.homeClub,
    this.awayClub,
    this.homeScore,
    this.awayScore,
  });

  @override
  String toString() {
    return 'MatchApp{homeClub: $homeClub, awayClub: $awayClub, homeScore: $homeScore, awayScore: $awayScore}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchApp &&
          runtimeType == other.runtimeType &&
          homeClub == other.homeClub &&
          awayClub == other.awayClub &&
          homeScore == other.homeScore &&
          awayScore == other.awayScore;

  @override
  int get hashCode =>
      homeClub.hashCode ^
      awayClub.hashCode ^
      homeScore.hashCode ^
      awayScore.hashCode;
}
