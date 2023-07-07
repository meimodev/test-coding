import 'package:flutter/material.dart';
import 'package:test_coding/models/club.dart';
import 'package:test_coding/widgets/screen_wrapper.dart';


class AddClubScreen extends StatefulWidget {
  const AddClubScreen({super.key, required this.clubList});

  final List<Club> clubList;

  @override
  State<AddClubScreen> createState() => _AddClubScreenState();
}

class _AddClubScreenState extends State<AddClubScreen> {
  String errorText = "";

  final tecName = TextEditingController();
  final tecCity = TextEditingController();

  bool _validateInputs(BuildContext context) {
    final name = tecName.text;
    final city = tecCity.text;

    setState(() {
      errorText = "";
    });

    if (name.isEmpty || city.isEmpty) {
      setState(() {
        errorText = "Nama/Kota tidak boleh kosong";
      });
      return false;
    }

    //check if already exist
    bool clubAlreadyExist = false;
    for (Club club in widget.clubList) {
      if (club.name.toLowerCase() == name.toLowerCase() &&
          club.city.toLowerCase() == city.toLowerCase()) {
        clubAlreadyExist = true;
      }
    }
    if (clubAlreadyExist) {
      setState(() {
        errorText = "Club $name, $city sudah ada tersimpan";
      });
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      body: Column(
        children: [
          Text(
            "Club Data Input",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: tecName,
            decoration: const InputDecoration(
              labelText: "Nama",
              isDense: true,
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: tecCity,
            decoration: const InputDecoration(
              labelText: "Kota",
              isDense: true,
            ),
          ),
          errorText.isEmpty ? const SizedBox() : const SizedBox(height: 12),
          errorText.isEmpty
              ? const SizedBox()
              : Text(
                  errorText,
                  style: const TextStyle(color: Colors.red),
                ),
          const SizedBox(height: 48),
          FilledButton(
            onPressed: () {
              if (_validateInputs(context)) {
                final name = tecName.text.toUpperCase();
                final city = tecCity.text;
                final club = Club(
                    name: name,
                    city: city[0].toUpperCase()+city.substring(1));
                Navigator.pop(context, club);
              }
            },
            child: const Text("Save Club Data"),
          ),
        ],
      ),
    );
  }
}
