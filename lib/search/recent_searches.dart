import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/search/search_cubit.dart';

class RecentSearches extends StatefulWidget {
  const RecentSearches({super.key});

  @override
  State<RecentSearches> createState() => _RecentSearchesState();
}

class _RecentSearchesState extends State<RecentSearches> {
  List<String> recentSearches = [];

  @override
  void initState() {
    super.initState();
    loadRecentSearches();
  }

  void loadRecentSearches() async {
    recentSearches = await context.read<SearchCubit>().getRecentSearches();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            children: [
              Text(
                " ${S.of(context).recentSearches}",
                style: TextStyle(color: Colors.grey[700]),
              ),
            ],
          ),
          const SizedBox(height: 10),
          BlocListener<SearchCubit, SearchState>(
            listener: (context, state) {
              if (state is SearchAdd) {
                loadRecentSearches();
              }
            },
            child: Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey, width: 0.2),
              ),
              child: recentSearches.isEmpty
                  ? Center(
                      child: Text(
                        S.of(context).noRecentSearches,
                        style: TextStyle(color: Colors.grey[700], fontSize: 16),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: recentSearches.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(1),
                            child: Row(
                              children: [
                                Text(
                                  '${1 + index}. ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    recentSearches[index],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
