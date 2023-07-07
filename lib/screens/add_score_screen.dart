import 'package:flutter/material.dart';
import 'package:test_coding/models/club.dart';
import 'package:test_coding/models/match_app.dart';
import 'package:test_coding/widgets/screen_wrapper.dart';

import '../widgets/card_item_match.dart';

class AddScoreScreen extends StatefulWidget {
  const AddScoreScreen({super.key, required this.clubList});

  final List<Club> clubList;

  @override
  State<AddScoreScreen> createState() => _AddScoreScreenState();
}

class _AddScoreScreenState extends State<AddScoreScreen> {
  List<MatchApp> matches = [
    MatchApp.empty(),
  ];

  bool _validateInputs(BuildContext context) {
    //check if contain error inputs
    bool hasInputError = matches.indexWhere((element) =>
            element.homeClub == null ||
            element.awayClub == null ||
            element.homeScore == null ||
            element.awayScore == null) !=
        -1;

    if (hasInputError) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 5),
          content: Text("Silahkan cek kembali input data yang memiliki error / tidak di isi"),
        ),
      );
      return false;
    }

    //check if contain duplicated data
    if (matches.length > 1) {
      MatchApp? duplicatedMatch;
      List<MatchApp> tempMatches = [];
      for (MatchApp match in matches) {
        if (tempMatches.contains(match)) {
          duplicatedMatch = match;
          break;
        } else {
          tempMatches.add(match);
        }
      }
      if (duplicatedMatch != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 10),
            content: Text(
                "Pertandingan ${duplicatedMatch.homeClub?.name} ${duplicatedMatch.homeScore} vs "
                "${duplicatedMatch.awayClub?.name} ${duplicatedMatch.awayScore} sudah terinput 2 kali"),
          ),
        );
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      body: Column(
        children: [
          Text(
            "Score Data Input",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: FilledButton.tonal(
                    onPressed: () {
                      setState(() {
                        matches.add(MatchApp.empty());
                      });
                    },
                    child: const Text("Add match"),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 30),
                    itemCount: matches.length,
                    itemBuilder: (context, index) => CardItemMatch(
                        clubList: widget.clubList,
                        oChangedMatch: (MatchApp match) {
                          matches[index] = match;
                        }),
                  ),
                ),
              ],
            ),
          ),
          FilledButton(
            onPressed: () {
              if (_validateInputs(context)) {
                Navigator.pop(context, matches);
              }
            },
            child: const Text("Save Score"),
          ),
        ],
      ),
    );
  }
}
