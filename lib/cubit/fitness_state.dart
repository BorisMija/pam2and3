import '../models/fitness_data.dart';

// Fără `const`, ca două stări de același tip emise la rând
// să fie obiecte diferite și UI-ul să se reîmprospăteze.

abstract class FitnessState {}

class FitnessLoading extends FitnessState {}

class FitnessError extends FitnessState {
  final String message;
  FitnessError(this.message);
}

class FitnessEmpty extends FitnessState {}

class FitnessSuccess extends FitnessState {
  final List<WorkoutItem> items;
  FitnessSuccess(this.items);
}