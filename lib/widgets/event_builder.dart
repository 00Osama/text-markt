import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:text_markt/bloc/event_cubit.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/models/event.dart';
import 'package:text_markt/widgets/event_preview.dart';
import 'package:text_markt/widgets/note_item.dart';
import 'package:text_markt/widgets/swipe_item.dart';

class EventBuilder extends StatelessWidget {
  const EventBuilder({super.key, required this.events});

  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Swipeitem(),
        const SizedBox(height: 1),
        Expanded(
          child: ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              return Slidable(
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        context.read<EventCubit>().deleteEvent(
                          events[index].id,
                          index,
                        );
                      },
                      backgroundColor: const Color(0xffEB4D3D),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: S.of(context).deleteEvent,
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return EventPreview(
                            title: TextEditingController(
                              text: events[index].title,
                            ),
                            note: TextEditingController(
                              text: events[index].note,
                            ),
                            dateTime: events[index].dateTime,
                          );
                        },
                      ),
                    );
                  },
                  child: NoteItem(
                    note: events[index].note,
                    title: events[index].title,
                    eventTime: events[index].dateTime,
                    showeventTime: true,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
