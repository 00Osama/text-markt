import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/features/search/cubits/search_cubit.dart';
import 'package:text_markt/features/search/widgets/search_delegate.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isTablet = screenWidth > 600;
    return GestureDetector(
      onTap: () {
        showSearch<String?>(context: context, delegate: Searchdelegate()).then((
          query,
        ) {
          final lastQuery = query?.trim();
          if (lastQuery != null && lastQuery.isNotEmpty && context.mounted) {
            context.read<SearchCubit>().addQuery(lastQuery);
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Container(
          width: double.infinity,
          height: isTablet ? 62 : 44,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey, width: 0.2),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(flex: 1),
              Text(
                S.of(context).searchTitle,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const Spacer(flex: 30),
            ],
          ),
        ),
      ),
    );
  }
}
