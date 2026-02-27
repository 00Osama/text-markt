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
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isTablet = screenWidth > 600;

    // scalable sizes
    final containerHeight = isTablet ? screenWidth * 0.22 : 130.0;
    final borderRadius = isTablet ? 20.0 : 12.0;
    final horizontalPadding = isTablet ? screenWidth * 0.03 : 11.0;
    final verticalPadding = isTablet ? screenWidth * 0.02 : 6.0;
    final dividerThickness = isTablet ? 2.0 : 1.0;
    final noteFontSize = isTablet ? 35.0 : 12.0;
    final dateFontSize = isTablet ? screenWidth * 0.013 : 16.0;

    String formattedDate = eventTime != null
        ? '${DateFormat('EEEE, dd MMM yyyy').format(eventTime!)}, '
              '${eventTime!.hour > 12 ? eventTime!.hour - 12 : (eventTime!.hour == 0 ? 12 : eventTime!.hour)}:'
              '${eventTime!.minute.toString().padLeft(2, '0')} '
              '${DateFormat('a').format(eventTime!)}'
        : 'Invalid date';

    return Padding(
      padding: EdgeInsets.all(isTablet ? screenWidth * 0.01 : 4.0),
      child: Container(
        width: double.infinity,
        height: containerHeight,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: const Color.fromARGB(139, 184, 176, 176),
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
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
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (showeventTime == true && formattedDate.isNotEmpty)
                    const Spacer(),
                  if (showeventTime == true && formattedDate.isNotEmpty)
                    Flexible(
                      child: Text(
                        formattedDate,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: dateFontSize,
                          color:
                              Theme.of(context).brightness == Brightness.light
                              ? const Color.fromARGB(255, 104, 99, 99)
                              : const Color.fromARGB(255, 180, 180, 180),
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: verticalPadding),
                child: Divider(
                  color: const Color.fromARGB(139, 184, 176, 176),
                  thickness: dividerThickness,
                ),
              ),
              Text(
                note,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: noteFontSize),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
