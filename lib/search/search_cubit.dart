import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchState {}

class SearchDefault extends SearchState {}

class SearchAdd extends SearchState {}

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchDefault());

  Future<List<String>> getRecentSearches() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('recentSearches') ?? [];
  }

  void addQuery(String query) async {
    if (query.length < 3) return;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> recentSearches = await getRecentSearches();

    if (!recentSearches.contains(query)) {
      recentSearches.insert(0, query);
      if (recentSearches.length > 35) {
        recentSearches.removeLast();
      }
      await prefs.setStringList(
        'recentSearches',
        recentSearches,
      );
      emit(SearchAdd());
    }
  }
}
