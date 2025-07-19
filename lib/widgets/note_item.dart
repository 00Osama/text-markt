import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({
    super.key,
    required this.note,
    required this.title,
    this.eventTime,
    this.showeventTime,
  });

  final String note;
  final String title;
  final DateTime? eventTime;
  final bool? showeventTime;

  @override
  Widget build(BuildContext context) {
    String formattedDate = eventTime != null
        ? '${DateFormat('EEEE, dd MMM yyyy').format(eventTime!)}, '
            '${eventTime!.hour > 12 ? eventTime!.hour - 12 : (eventTime!.hour == 0 ? 12 : eventTime!.hour)}:'
            '${eventTime!.minute.toString().padLeft(2, '0')} '
            '${DateFormat('a').format(eventTime!)}'
        : 'Invalid date';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 130,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color.fromARGB(139, 184, 176, 176),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (showeventTime == true && formattedDate.isNotEmpty)
                    const Spacer(),
                  if (showeventTime == true && formattedDate.isNotEmpty)
                    Text(
                      formattedDate,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(
                  color: Color.fromARGB(139, 184, 176, 176),
                ),
              ),
              Text(
                note,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
