import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/fitness_data.dart';

class FitnessRepository {
  // Pentru a testa starea Error, schimbă temporar în 'assets/data/x.json'
  static const String _path = 'assets/data/fitness.json';

  Future<FitnessData> fetchFitnessData() async {
    // Întârziere artificială, ca să se vadă starea Loading
    await Future.delayed(const Duration(milliseconds: 1500));

    final raw = await rootBundle.loadString(_path);
    return FitnessData.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }
}