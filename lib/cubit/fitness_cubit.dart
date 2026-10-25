import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/fitness_repository.dart';
import '../models/fitness_data.dart';
import 'fitness_state.dart';

enum SortBy { none, calories, duration, title }

class FitnessCubit extends Cubit<FitnessState> {
  final FitnessRepository _repo;

  FitnessCubit(this._repo) : super(FitnessLoading());

  FitnessData? _data;
  String _query = '';
  String _filterId = 'all';
  SortBy _sort = SortBy.none;
  bool _onlyFavorites = false;
  final Set<String> _favorites = {};

  // ---- Getteri pentru UI ----
  FitnessData get data => _data!;
  String get filterId => _filterId;
  SortBy get sort => _sort;
  bool get onlyFavorites => _onlyFavorites;
  bool isFavorite(String id) => _favorites.contains(id);

  // ---- Încărcare asincronă ----
  Future<void> load() async {
    emit(FitnessLoading());
    try {
      final d = await _repo.fetchFitnessData();
      _data = d;
      _filterId = d.filters
          .firstWhere((f) => f.selected, orElse: () => d.filters.first)
          .id;
      _apply();
    } catch (e) {
      emit(FitnessError('Nu s-au putut încărca datele.'));
    }
  }

  // ---- Acțiuni ----
  void search(String q) {
    _query = q;
    _apply();
  }

  void selectFilter(String id) {
    _filterId = id;
    _apply();
  }

  void changeSort(SortBy s) {
    _sort = s;
    _apply();
  }

  void toggleOnlyFavorites() {
    _onlyFavorites = !_onlyFavorites;
    _apply();
  }

  void toggleFavorite(String id) {
    if (!_favorites.remove(id)) {
      _favorites.add(id);
    }
    _apply();
  }

  // ---- Căutare + filtrare + sortare ----
  void _apply() {
    final d = data;
    final q = _query.trim().toLowerCase();
    final filter = d.filters.firstWhere((f) => f.id == _filterId);

    final list = d.items.where((w) {
      final title = w.title.toLowerCase();
      final okQuery = q.isEmpty || title.contains(q);
      // "All Type" arată tot; altfel titlul trebuie să conțină numele filtrului
      final okFilter =
          filter.id == 'all' || title.contains(filter.name.toLowerCase());
      final okFavorite = !_onlyFavorites || _favorites.contains(w.id);
      return okQuery && okFilter && okFavorite;
    }).toList();

    switch (_sort) {
      case SortBy.calories:
        list.sort((a, b) => b.calories.compareTo(a.calories));
        break;
      case SortBy.duration:
        list.sort((a, b) => a.durationMinutes.compareTo(b.durationMinutes));
        break;
      case SortBy.title:
        list.sort((a, b) => a.title.compareTo(b.title));
        break;
      case SortBy.none:
        break;
    }

    emit(list.isEmpty ? FitnessEmpty() : FitnessSuccess(list));
  }
}