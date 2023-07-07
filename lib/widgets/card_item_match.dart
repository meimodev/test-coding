import 'package:flutter/material.dart';

import '../models/club.dart';
import '../models/match_app.dart';

class CardItemMatch extends StatefulWidget {
  const CardItemMatch({
    super.key,
    required this.clubList,
    required this.oChangedMatch,
  });

  final List<Club> clubList;
  final void Function(MatchApp match) oChangedMatch;

  @override
  State<CardItemMatch> createState() => _CardItemMatchState();
}

class _CardItemMatchState extends State<CardItemMatch> {
  String? homeClub;
  String? awayClub;

  final tecHomeScore = TextEditingController();
  final tecAwayScore = TextEditingController();

  String errorText = "";

  @override
  void dispose() {
    tecHomeScore.dispose();
    tecAwayScore.dispose();
    super.dispose();
  }

  _validateInputs() {
    setState(() {
      errorText = "";
    });

    final homeScore = tecHomeScore.text;
    final awayScore = tecAwayScore.text;
    widget.oChangedMatch(
      MatchApp(
        homeClub: homeClub != null
            ? widget.clubList.firstWhere(
              (element) =>
          element.name.toLowerCase() == homeClub!.toLowerCase(),
        )
            : null,
        awayClub: awayClub != null
            ? widget.clubList.firstWhere(
              (element) =>
          element.name.toLowerCase() == awayClub!.toLowerCase(),
        )
            : null,
        homeScore: int.tryParse(homeScore),
        awayScore: int.tryParse(awayScore),
      ),
    );

    if (homeClub == null || awayClub == null) {
      setState(() {
        errorText = "kedua club harus di pilih";
      });
      return false;
    }

    if (homeClub!.toLowerCase() == awayClub!.toLowerCase()) {
      setState(() {
        errorText = "kedua club tidak boleh sama";
      });
      return false;
    }

    if (homeScore.isEmpty || awayScore.isEmpty) {
      setState(() {
        errorText = "kedua score harus di isi";
      });
      return false;
    }

    if (int.tryParse(homeScore) == null || int.tryParse(awayScore) == null) {
      setState(() {
        errorText = "gunakan angka 0-9 untuk score";
      });
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.only(
          top: 6,
          bottom: 24,
          left: 24,
          right: 24,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      DropdownButton(
                        items: widget.clubList
                            .map((e) => DropdownMenuItem(
                            value: e.name, child: Text(e.name)))
                            .toList(),
                        hint: const Text("Pilih Club"),
                        value: homeClub,
                        onChanged: (value) {
                          setState(() {
                            homeClub = value;
                          });
                          _validateInputs();
                        },
                      ),
                      TextFormField(
                        onChanged: (_) => _validateInputs(),
                        controller: tecHomeScore,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Score",
                          isDense: true,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                const Text("VS"),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    children: [
                      DropdownButton(
                        items: widget.clubList
                            .map((e) => DropdownMenuItem(
                            value: e.name, child: Text(e.name)))
                            .toList(),
                        hint: const Text("Pilih Club"),
                        value: awayClub,
                        onChanged: (value) {
                          setState(() {
                            awayClub = value;
                          });
                          _validateInputs();
                        },
                      ),
                      TextFormField(
                        onChanged: (_) => _validateInputs(),
                        controller: tecAwayScore,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Score",
                          isDense: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            errorText.isEmpty ? const SizedBox() : const SizedBox(height: 12),
            errorText.isEmpty
                ? const SizedBox()
                : Text(
              errorText,
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
