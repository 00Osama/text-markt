import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:text_markt/core/helpers/responsive.dart';
import 'package:text_markt/generated/l10n.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({
    super.key,
    required this.note,
    required this.title,
    required this.status,
    this.eventTime,
    this.showeventTime,
    this.eventDateColor,
    this.highlightQuery = '',
  });

  final String note;
  final String title;
  final String status;
  final DateTime? eventTime;
  final bool? showeventTime;
  final Color? eventDateColor;
  final String highlightQuery;

  List<TextSpan> _highlightSpans(String text, TextStyle style) {
    final query = highlightQuery.trim();
    if (query.isEmpty) {
      return [TextSpan(text: text, style: style)];
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final spans = <TextSpan>[];
    var start = 0;
    var index = lowerText.indexOf(lowerQuery);

    while (index != -1) {
      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index), style: style));
      }
      spans.add(
        TextSpan(
          text: text.substring(index, index + query.length),
          style: style.copyWith(backgroundColor: Colors.yellow),
        ),
      );
      start = index + query.length;
      index = lowerText.indexOf(lowerQuery, start);
    }

    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start), style: style));
    }

    return spans;
  }

  IconData _getStatusIcon() {
    switch (status.toLowerCase()) {
      case 'notestatus.done':
      case 'done':
        return Icons.task_alt_rounded;

      case 'notestatus.inprogress':
      case 'inprogress':
      case 'in progress':
        return Icons.autorenew_rounded;

      default:
        return Icons.schedule_rounded;
    }
  }

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'notestatus.done':
      case 'done':
        return Colors.green;

      case 'notestatus.inprogress':
      case 'inprogress':
      case 'in progress':
        return Colors.blue;

      default:
        return Colors.orange;
    }
  }

  String _getStatusName(String status) {
    switch (status.toLowerCase()) {
      case 'notestatus.done':
      case 'done':
        return S().done;

      case 'notestatus.inprogress':
      case 'inprogress':
      case 'in progress':
        return S().inProgress;

      default:
        return S().pending;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isTablet = Responsive.isTablet(context);

    final containerHeight = isTablet ? screenWidth * 0.24 : 145.0;
    final borderRadius = isTablet ? 20.0 : 12.0;
    final horizontalPadding = isTablet ? screenWidth * 0.03 : 11.0;
    final verticalPadding = isTablet ? screenWidth * 0.02 : 6.0;
    final dividerThickness = isTablet ? 2.0 : 1.0;
    final noteFontSize = isTablet ? 18.0 : 13.0;
    final titleFontSize = isTablet ? 22.0 : 16.0;
    final statusFontSize = isTablet ? 15.0 : 11.0;
    final dateFontSize = isTablet ? 13.0 : 11.0;

    String formattedDate = eventTime != null
        ? '${DateFormat('EEEE, dd MMM yyyy').format(eventTime!)}, '
              '${eventTime!.hour > 12 ? eventTime!.hour - 12 : (eventTime!.hour == 0 ? 12 : eventTime!.hour)}:'
              '${eventTime!.minute.toString().padLeft(2, '0')} '
              '${DateFormat('a').format(eventTime!)}'
        : '';

    return Padding(
      padding: EdgeInsets.all(isTablet ? screenWidth * 0.01 : 4),
      child: Container(
        width: double.infinity,
        height: containerHeight,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: const Color.fromARGB(139, 184, 176, 176)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title + Date
              Row(
                children: [
                  Expanded(
                    child: RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: _highlightSpans(
                          title,
                          TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.color,
                            fontWeight: FontWeight.bold,
                            fontSize: titleFontSize,
                          ),
                        ),
                      ),
                    ),
                  ),

                  if (showeventTime != true)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 12 : 8,
                        vertical: isTablet ? 8 : 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor().withAlpha(30),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getStatusIcon(),
                            color: _getStatusColor(),
                            size: isTablet ? 20 : 15,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _getStatusName(status),
                            style: TextStyle(
                              color: _getStatusColor(),
                              fontWeight: FontWeight.w600,
                              fontSize: statusFontSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (showeventTime == true && formattedDate.isNotEmpty)
                    Text(
                      formattedDate,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: dateFontSize,
                        color:
                            eventDateColor ??
                            (Theme.of(context).brightness == Brightness.light
                                ? const Color.fromARGB(255, 104, 99, 99)
                                : const Color.fromARGB(255, 180, 180, 180)),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 8),

              Padding(
                padding: EdgeInsets.symmetric(vertical: verticalPadding),
                child: Divider(
                  color: const Color.fromARGB(139, 184, 176, 176),
                  thickness: dividerThickness,
                ),
              ),

              /// Note Content
              Expanded(
                child: RichText(
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: _highlightSpans(
                      note,
                      TextStyle(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                        fontSize: noteFontSize,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
