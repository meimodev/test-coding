import 'package:flutter/material.dart';
import 'package:test_coding/models/club.dart';
import 'package:test_coding/models/klasemen.dart';
import 'package:test_coding/models/match_app.dart';
import 'package:test_coding/screens/add_club_screen.dart';
import 'package:test_coding/screens/add_score_screen.dart';

import '../widgets/card_item_klasemen.dart';
import '../widgets/screen_wrapper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var listKlasemen = <Klasemen>[];
  final clubList = <Club>[];
  final matches = <MatchApp>[];

  @override
  void initState() {
    super.initState();
    clubList.add(Club(name: "PERSIB", city: "Bandung"));
    clubList.add(Club(name: "PERSIJA", city: "Jakarta"));
    _calculateKlasemen();
  }

  void _handleOnClickAddData(BuildContext context) async {
    final res = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddClubScreen(clubList: clubList),
      ),
    );
    if (res != null) {
      clubList.add(res as Club);
      _calculateKlasemen();
    }
  }

  void _handleOnClickAddScore(BuildContext context) async {
    final res = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddScoreScreen(clubList: clubList),
      ),
    );
    if (res != null) {
      for (MatchApp match in (res as List<MatchApp>)) {
        matches.add(match);
      }
      _calculateKlasemen();
    }
  }

  void _calculateKlasemen() {
    final tempListKlasemen = <Klasemen>[];
    for (Club club in clubList) {
      tempListKlasemen.add(Klasemen(club: club));
    }

    for (int i = 0; i < matches.length; i++) {
      final match = matches[i];

      final homeClubKlasemen = tempListKlasemen[tempListKlasemen
          .indexWhere((element) => element.club == match.homeClub)];
      final awayClubKlasemen = tempListKlasemen[tempListKlasemen
          .indexWhere((element) => element.club == match.awayClub)];

      homeClubKlasemen.play++;
      awayClubKlasemen.play++;

      if (match.homeScore == match.awayScore) {
        homeClubKlasemen.draw++;
        homeClubKlasemen.point++;
        homeClubKlasemen.goalWin += match.homeScore!;
        homeClubKlasemen.goalLose += match.awayScore!;

        awayClubKlasemen.draw++;
        awayClubKlasemen.point++;
        awayClubKlasemen.goalWin += match.awayScore!;
        awayClubKlasemen.goalLose += match.homeScore!;
      } else if (match.homeScore! > match.awayScore!) {
        //home win

        homeClubKlasemen.win++;
        homeClubKlasemen.point += 3;
        homeClubKlasemen.goalWin += match.homeScore!;

        awayClubKlasemen.lose++;
        awayClubKlasemen.goalLose += match.homeScore!;
      } else if (match.homeScore! < match.awayScore!) {
        //away win
        awayClubKlasemen.win++;
        awayClubKlasemen.point += 3;
        awayClubKlasemen.goalWin += match.awayScore!;

        homeClubKlasemen.lose++;
        homeClubKlasemen.goalLose += match.awayScore!;
      }
    }

    tempListKlasemen.sort((a, b) => b.point.compareTo(a.point));

    setState(() {
      listKlasemen = tempListKlasemen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      onClickAddData: () => _handleOnClickAddData(context),
      onClickAddScore: () => _handleOnClickAddScore(context),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Kelasemen",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: listKlasemen.length,
              padding: const EdgeInsets.only(bottom: 120),
              itemBuilder: (context, index) => CardItemKlasemen(
                klasemen: listKlasemen[index],
                index: index + 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
