import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:text_markt/core/routing/app_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:text_markt/core/helpers/error_snackbar_helper.dart';
import 'package:text_markt/core/helpers/responsive.dart';
import 'package:text_markt/core/helpers/success_snackbar_helper.dart';
import 'package:text_markt/features/notes/presentation/cubits/note_cubit.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/globals.dart';
import 'package:text_markt/features/notes/domain/entities/note.dart';
import 'package:text_markt/features/search/widgets/search_bar.dart';
import 'package:text_markt/features/notes/presentation/widgets/note_section.dart';
import 'package:text_markt/features/notes/presentation/widgets/notes_builder.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  String getMonthName(int monthNumber) {
    const monthNames = [
      "Invalid month",
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return (monthNumber >= 1 && monthNumber <= 12)
        ? monthNames[monthNumber]
        : "Invalid month";
  }

  String getCollectionName(String newCollection) {
    switch (newCollection) {
      case 'AllNotes':
        return S.of(context).allNotes;
      case 'Favourites':
        return S.of(context).noteAddedToFavorites;
      case 'Hidden':
        return S.of(context).noteAddedToHidden;
      case 'Trash':
        return S.of(context).noteAddedToTrash;
      default:
        return '';
    }
  }

  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: isTablet ? 100 : kToolbarHeight,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        surfaceTintColor: Theme.of(context).appBarTheme.surfaceTintColor,
        title: Column(
          children: [
            Row(
              children: [
                Text(
                  DateFormat(
                    'EEEE, d MMMM y',
                    Localizations.localeOf(context).toLanguageTag(),
                  ).format(DateTime.now()),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  S.of(context).Notes,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: isTablet ? 90 : 55,
        height: isTablet ? 90 : 55,
        child: FloatingActionButton(
          backgroundColor: Theme.of(
            context,
          ).floatingActionButtonTheme.backgroundColor,
          foregroundColor: Theme.of(
            context,
          ).floatingActionButtonTheme.foregroundColor,
          onPressed: () {
            context.push(
              AppRoutes.noteEditor,
              extra: const NoteEditorRouteExtra(operation: 'add'),
            );
          },
          child: Icon(Icons.add_rounded, size: isTablet ? 45 : 24),
        ),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        header: WaterDropHeader(complete: Text(S().refreshCompleted)),
        controller: refreshController,
        onRefresh: () {
          setState(() {
            allNotes.clear();
            favourites.clear();
            hidden.clear();
            trash.clear();
            refreshController.refreshCompleted();
          });
        },
        child: Column(
          children: [
            const SizedBox(height: 15),
            const MySearchBar(),
            const SizedBox(height: 19),
            BlocBuilder<NoteCubit, NoteState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NoteSection(
                        sectionIcon: Icons.favorite,
                        iconColor: const Color(0xff8E8E92),
                        borderColor: state is AllNotes
                            ? const Color(0xff8E8E92)
                            : Colors.transparent,
                        sectionName: 'All Notes',
                        onPressed: () {
                          context.read<NoteCubit>().switchNotes('AllNotes');
                        },
                      ),
                      const SizedBox(width: 10),
                      NoteSection(
                        sectionIcon: Icons.favorite_border,
                        iconColor: const Color(0xffF7CE45),
                        borderColor: state is Favourites
                            ? const Color(0xffF7CE45)
                            : Colors.transparent,
                        sectionName: S.of(context).favorites,
                        onPressed: () {
                          context.read<NoteCubit>().switchNotes('Favourites');
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            BlocBuilder<NoteCubit, NoteState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NoteSection(
                        sectionIcon: Icons.visibility_off_rounded,
                        iconColor: const Color(0xff4E94F8),
                        borderColor: state is Hidden
                            ? const Color(0xff4E94F8)
                            : Colors.transparent,
                        sectionName: S.of(context).hidden,
                        onPressed: () {
                          context.read<NoteCubit>().switchNotes('Hidden');
                        },
                      ),
                      const SizedBox(width: 10),
                      NoteSection(
                        sectionIcon: Icons.delete_rounded,
                        iconColor: const Color(0xffEB4D3D),
                        borderColor: state is Trash
                            ? const Color(0xffEB4D3D)
                            : Colors.transparent,
                        sectionName: S.of(context).trash,
                        onPressed: () {
                          context.read<NoteCubit>().switchNotes('Trash');
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            BlocConsumer<NoteCubit, NoteState>(
              listener: (context, state) {
                if (state is NoteMovedSuccess) {
                  successSnackBar(
                    context: context,
                    title: getCollectionName(state.newCollection),
                  );

                  if (state.oldCollection == 'AllNotes') {
                    allNotes.removeAt(state.index);
                  } else if (state.oldCollection == 'Favourites') {
                    favourites.removeAt(state.index);
                  } else if (state.oldCollection == 'Hidden') {
                    hidden.removeAt(state.index);
                  }
                  if (state.newCollection == 'Favourites') {
                    favourites.insert(
                      0,
                      Note(
                        title: state.title,
                        note: state.note,
                        time: Timestamp.now(),
                        id: state.id,
                        status: state.status,
                      ),
                    );
                  }
                  if (state.newCollection == 'Hidden') {
                    hidden.insert(
                      0,
                      Note(
                        title: state.title,
                        note: state.note,
                        time: Timestamp.now(),
                        id: state.id,
                        status: state.status,
                      ),
                    );
                  }
                  if (state.newCollection == 'Trash') {
                    trash.insert(
                      0,
                      Note(
                        title: state.title,
                        note: state.note,
                        time: Timestamp.now(),
                        id: state.id,
                        status: state.status,
                      ),
                    );
                  }
                }
                if (state is NoteMovedFail) {
                  errorSnackBar(
                    context: context,
                    title: 'failed to add note to ${state.collection}',
                  );
                }
                if (state is NoteDeleteSuccess) {
                  trash.removeAt(state.index);
                  successSnackBar(
                    context: context,
                    title: S.of(context).noteDeletedSuccessfully,
                  );
                }
                if (state is NoteDeleteFail) {
                  errorSnackBar(
                    context: context,
                    title: S.of(context).failedToDeleteNote,
                  );
                }
              },
              builder: (context, state) {
                late final String currentState;

                if (state is AllNotes) {
                  currentState = 'AllNotes';
                } else if (state is Favourites) {
                  currentState = 'Favourites';
                } else if (state is Hidden) {
                  currentState = 'Hidden';
                } else if (state is Trash) {
                  currentState = 'Trash';
                } else {
                  currentState = 'AllNotes';
                }

                if (state is NoteMovedLoading) {
                  return Expanded(
                    child: Column(
                      children: [
                        const Spacer(flex: 1),
                        LoadingAnimationWidget.threeRotatingDots(
                          color: const Color.fromARGB(255, 67, 143, 224),
                          size: 90,
                        ),
                        const Spacer(flex: 1),
                      ],
                    ),
                  );
                }

                return FutureBuilder<List<Note>>(
                  future: context.read<NoteCubit>().getNotesData(currentState),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(
                        child: Column(
                          children: [
                            const Spacer(flex: 1),
                            LoadingAnimationWidget.threeRotatingDots(
                              color: const Color.fromARGB(255, 67, 143, 224),
                              size: 90,
                            ),
                            const Spacer(flex: 1),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Spacer(flex: 1),
                            Image.asset(
                              'assets/images/error.png',
                              width: screenHeight * 0.5,
                              height: screenHeight * 0.25,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            Text(
                              'Unexpected error occurred',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const Spacer(flex: 1),
                          ],
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Spacer(flex: 1),
                            Image.asset(
                              'assets/images/no.png',
                              width: screenHeight * 0.5,
                              height: screenHeight * 0.25,
                              fit: BoxFit.contain,
                            ),
                            Text(
                              S.of(context).noNotes,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const Spacer(flex: 1),
                          ],
                        ),
                      );
                    }

                    return Expanded(
                      child: NotesBuilder(
                        notes: snapshot.data!,
                        currentCollection: currentState,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
