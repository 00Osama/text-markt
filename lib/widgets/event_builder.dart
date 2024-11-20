import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:textmarkt/bloc/event_cubit.dart';
import 'package:textmarkt/models/event.dart';
import 'package:textmarkt/widgets/event_date.dart';
import 'package:textmarkt/widgets/note_item.dart';

class EventBuilder extends StatefulWidget {
  const EventBuilder({
    super.key,
    required this.events,
  });

  final List<Event> events;

  @override
  _EventBuilderState createState() => _EventBuilderState();
}

class _EventBuilderState extends State<EventBuilder> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Initialize the first event when the widget is first built
    if (widget.events.isNotEmpty) {
      final firstEventId = widget.events[0].id;
      final eventCubit = context.read<EventCubit>();

      // Check if the state hasn't been set already
      if (eventCubit.state is EventIntial &&
          (eventCubit.state as EventIntial).firstId == null) {
        eventCubit.initializeFirstEvent(firstEventId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final uniqueEvents = getUniqueEventsByDay(widget.events);

    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: uniqueEvents.length,
                itemBuilder: (itemContext, index) {
                  final event = uniqueEvents[index];
                  final dateTime = DateTime.parse(event.dateTime);
                  final formattedMonth =
                      DateFormat('MMM').format(dateTime).toUpperCase();
                  final formattedDayNumber = DateFormat('d').format(dateTime);
                  final formattedDayName =
                      DateFormat('EEE').format(dateTime).toUpperCase();

                  return Row(
                    children: [
                      const SizedBox(width: 2),
                      GestureDetector(
                        onTap: () {
                          context.read<EventCubit>().chooseDay(event.id!);
                        },
                        child: EventDate(
                          monthName: formattedMonth,
                          dayNumber: int.parse(formattedDayNumber),
                          dayName: formattedDayName,
                          id: event.id ?? '',
                        ),
                      ),
                      const SizedBox(width: 2),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: uniqueEvents.length,
                itemBuilder: (context, index) {
                  final event = uniqueEvents[index];
                  return NoteItem(
                    note: event.note,
                    title: event.title,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  List<Event> getUniqueEventsByDay(List<Event> events) {
    final uniqueDays = <String>{};
    final uniqueEvents = <Event>[];

    for (var event in events) {
      final eventDate =
          DateTime.parse(event.dateTime).toIso8601String().split('T')[0];
      if (!uniqueDays.contains(eventDate)) {
        uniqueDays.add(eventDate);
        uniqueEvents.add(event);
      }
    }
    return uniqueEvents;
  }
}
