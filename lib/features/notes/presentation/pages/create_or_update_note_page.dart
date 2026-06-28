import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:text_markt/core/helpers/error_snackbar_helper.dart';
import 'package:text_markt/core/helpers/success_snackbar_helper.dart';
import 'package:text_markt/features/notes/presentation/cubits/note_cubit.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/globals.dart';
import 'package:text_markt/features/notes/domain/entities/note.dart';

enum NoteStatus { pending, inProgress, done }

class CreateOrUpdateNote extends StatefulWidget {
  const CreateOrUpdateNote({
    super.key,
    required this.operation,
    this.index,
    this.collection,
    this.note,
    this.currentDay,
    this.dayName,
    this.monthName,
  });

  final String operation;
  final String? collection;
  final int? index;
  final Note? note;
  final DateTime? currentDay;
  final String? dayName;
  final String? monthName;

  @override
  State<CreateOrUpdateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateOrUpdateNote> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  late String newTitle;
  late String newNote;

  late String updatedTitle;
  late String updatedNote;

  @override
  void initState() {
    super.initState();

    if (widget.operation == 'update') {
      titleController.text = widget.note?.title ?? '';
      noteController.text = widget.note?.note ?? '';
      selectedStatus = noteStatusFromValue(widget.note?.status);
    }

    // Initialize newTitle and newNote with the current text
    newTitle = titleController.text;
    newNote = noteController.text;

    // Add listeners to update newTitle and newNote on changes
    titleController.addListener(() {
      setState(() {
        newTitle = titleController.text;
      });
    });

    noteController.addListener(() {
      setState(() {
        newNote = noteController.text;
      });
    });
  }

  @override
  void dispose() {
    // Always dispose of controllers when no longer needed to avoid memory leaks
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  String getStatusText(BuildContext context, NoteStatus status) {
    switch (status) {
      case NoteStatus.pending:
        return S.of(context).pending;
      case NoteStatus.inProgress:
        return S.of(context).inProgress;
      case NoteStatus.done:
        return S.of(context).done;
    }
  }

  IconData getStatusIcon(NoteStatus status) {
    switch (status) {
      case NoteStatus.pending:
        return Icons.schedule_rounded;

      case NoteStatus.inProgress:
        return Icons.autorenew_rounded;

      case NoteStatus.done:
        return Icons.task_alt_rounded;
    }
  }

  String noteStatusToValue(NoteStatus status) {
    switch (status) {
      case NoteStatus.pending:
        return 'pending';
      case NoteStatus.inProgress:
        return 'inProgress';
      case NoteStatus.done:
        return 'done';
    }
  }

  NoteStatus noteStatusFromValue(String? status) {
    switch (status?.toLowerCase()) {
      case 'notestatus.inprogress':
      case 'inprogress':
      case 'in progress':
        return NoteStatus.inProgress;
      case 'notestatus.done':
      case 'done':
        return NoteStatus.done;
      default:
        return NoteStatus.pending;
    }
  }

  NoteStatus selectedStatus = NoteStatus.pending;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isTablet = screenWidth > 600;
    final fabBgColor = Theme.of(
      context,
    ).floatingActionButtonTheme.backgroundColor;
    final fabFgColor = Theme.of(
      context,
    ).floatingActionButtonTheme.foregroundColor;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          widget.operation == 'add'
              ? S.of(context).newNote
              : S.of(context).updateNote,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(),
        ),
        leadingWidth: isTablet ? 70 : 56,
        leading: Padding(
          padding: EdgeInsets.all(isTablet ? 8 : 4),
          child: Container(
            width: isTablet ? 60 : 40,
            height: isTablet ? 60 : 40,

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(
                context,
              ).floatingActionButtonTheme.backgroundColor,
            ),
            child: IconButton(
              onPressed:
                  widget.operation == 'add' || widget.operation == 'newEvent'
                  ? () async {
                      if (widget.operation == 'add') {
                        if (titleController.text.trim().isEmpty &&
                            noteController.text.trim().isEmpty) {
                          errorSnackBar(
                            context: context,
                            title: S.of(context).enterAtLeastNoteTitle,
                          );
                        } else {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return Center(
                                child: LoadingAnimationWidget.threeRotatingDots(
                                  color: const Color.fromARGB(
                                    255,
                                    67,
                                    143,
                                    224,
                                  ),
                                  size: 90,
                                ),
                              );
                            },
                          );

                          context.read<NoteCubit>().addNewNote(
                            noteController.text.trim(),
                            titleController.text.trim(),
                            noteStatusToValue(selectedStatus),
                          );
                        }
                      } else {
                        ///////// add new event here
                      }
                    }
                  : () {
                      if (newTitle.trim().isEmpty && newNote.trim().isEmpty) {
                        errorSnackBar(
                          context: context,
                          title: S.of(context).enterAtLeastNoteTitle,
                        );
                      } else {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return Center(
                              child: LoadingAnimationWidget.threeRotatingDots(
                                color: const Color.fromARGB(255, 67, 143, 224),
                                size: 90,
                              ),
                            );
                          },
                        );
                        updatedTitle = newTitle;
                        updatedNote = newNote;
                        String? id = widget.note?.id;
                        context.read<NoteCubit>().updateNote(
                          newNote,
                          newTitle,
                          widget.collection!,
                          id,
                          widget.note!.time,
                          noteStatusToValue(selectedStatus),
                        );
                      }
                    },
              icon: Icon(
                Icons.done_rounded,
                size: isTablet ? 28 : 24,
                color: Theme.of(
                  context,
                ).floatingActionButtonTheme.foregroundColor,
              ),
              iconSize: MediaQuery.of(context).size.width * 0.06,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(isTablet ? 8 : 4),
            child: Container(
              width: isTablet ? 60 : 40,
              height: isTablet ? 60 : 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: fabBgColor,
              ),
              child: IconButton(
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
                onPressed: () => context.pop(),
                icon: Icon(
                  Icons.close_rounded,
                  size: isTablet ? 28 : 24,
                  color: fabFgColor,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: isTablet ? 64 : 52,
        child: PopupMenuButton<NoteStatus>(
          color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
          tooltip: '',
          onSelected: (status) {
            setState(() {
              selectedStatus = status;
            });
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: NoteStatus.pending,
              child: Row(
                children: [
                  const Icon(Icons.schedule_rounded),
                  const SizedBox(width: 10),
                  Text(
                    S().pending,
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: NoteStatus.inProgress,
              child: Row(
                children: [
                  const Icon(Icons.autorenew_rounded),
                  const SizedBox(width: 10),
                  Text(
                    S().inProgress,
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: NoteStatus.done,
              child: Row(
                children: [
                  const Icon(Icons.task_alt_rounded),
                  const SizedBox(width: 10),
                  Text(
                    S().done,
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 18 : 14,
              vertical: isTablet ? 14 : 10,
            ),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).floatingActionButtonTheme.backgroundColor,
              borderRadius: BorderRadius.circular(50),
              boxShadow: kElevationToShadow[6],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  getStatusIcon(selectedStatus),
                  size: isTablet ? 28 : 22,
                  color: Theme.of(
                    context,
                  ).floatingActionButtonTheme.foregroundColor,
                ),
                const SizedBox(width: 8),
                Text(
                  getStatusText(context, selectedStatus),
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(
                      context,
                    ).floatingActionButtonTheme.foregroundColor,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  size: isTablet ? 28 : 22,
                  color: Theme.of(
                    context,
                  ).floatingActionButtonTheme.foregroundColor,
                ),
              ],
            ),
          ),
        ),
      ),
      body: BlocListener<NoteCubit, NoteState>(
        listener: (context, state) {
          if (state is NoteAddSuccess) {
            allNotes.insert(
              0,
              Note(
                title: titleController.text,
                note: noteController.text,
                status: noteStatusToValue(selectedStatus),
                time: Timestamp.now(),
                id: state.id,
              ),
            );

            context.pop();
            context.pop();

            successSnackBar(
              context: context,
              title: S.of(context).noteAddedSuccessfully,
            );
          }

          if (state is NoteAddFail) {
            context.pop();
            errorSnackBar(
              context: context,
              title: S.of(context).failedToAddNote,
            );
          }

          if (state is NoteUpdateSuccess) {
            if (state.collection == 'AllNotes') {
              allNotes[widget.index!] = Note(
                title: updatedTitle,
                note: updatedNote,
                id: widget.note!.id,
                time: Timestamp.now(),
                status: noteStatusToValue(selectedStatus),
              );
            } else if (state.collection == 'Favourites') {
              favourites[widget.index!] = Note(
                title: updatedTitle,
                note: updatedNote,
                id: widget.note!.id,
                time: Timestamp.now(),
                status: noteStatusToValue(selectedStatus),
              );
            } else if (state.collection == 'Hidden') {
              hidden[widget.index!] = Note(
                title: updatedTitle,
                note: updatedNote,
                id: widget.note!.id,
                time: Timestamp.now(),
                status: noteStatusToValue(selectedStatus),
              );
            } else {
              trash[widget.index!] = Note(
                title: updatedTitle,
                note: updatedNote,
                id: widget.note!.id,
                time: Timestamp.now(),
                status: noteStatusToValue(selectedStatus),
              );
            }

            context.pop();
            context.pop();

            successSnackBar(
              context: context,
              title: S.of(context).noteUpdatedSuccessfully,
            );
          }

          if (state is NoteUpdateFail) {
            context.pop();
            errorSnackBar(
              context: context,
              title: S.of(context).failedToUpdateNote,
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Column(
              children: [
                widget.operation == 'newEvent'
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (widget.dayName?.isNotEmpty ?? false)
                                ? 'Event Date'
                                : 'Select Event Date',
                            style: TextStyle(
                              color: (widget.dayName?.isNotEmpty ?? false)
                                  ? Colors.black
                                  : Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                widget.dayName ?? '',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                ' ${widget.currentDay?.day ?? ''} ${widget.monthName ?? ''}'
                                '${(widget.monthName?.isNotEmpty ?? false) ? ',' : ''} '
                                '${widget.currentDay?.year ?? ''}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 14),
                    TextField(
                      controller: titleController,
                      maxLines: null,
                      cursorColor: const Color(0xff007AFF),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        hintText: S.of(context).title,
                        hintStyle: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: noteController,
                      cursorColor: const Color(0xff007AFF),
                      maxLines: null,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        hintText: S.of(context).Note,
                        hintStyle: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
