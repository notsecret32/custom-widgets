import 'package:custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:week_of_year/week_of_year.dart';

/// A calendar for selecting the day of the week by week.
///
/// Displays the month, the type of week, and the weekday picker.
class CustomWeeklyCalendar extends StatefulWidget {
  const CustomWeeklyCalendar({
    super.key,
    this.onDayChanged,
    this.weekdays = globalWeekdays,
    this.daysInWeek = 7,
    this.background,
    this.unselectedTextStyle,
    this.selectedTextStyle,
  })  : assert(
          weekdays.length == daysInWeek,
          'daysInWeek must be equal to the number of items in weekdays',
        ),
        assert(
          daysInWeek > 0 && daysInWeek <= 7,
          'There are only 1-7 days in a week',
        );

  /// The callback method is triggered every time
  /// the user selects a day of the week.
  final Function(DateTime selectedDay)? onDayChanged;

  /// A list of days of the week in text form.
  ///
  /// ```dart
  /// final List<String> weekdays = <String>[
  ///   'ПН',
  ///   'ВТ',
  ///   'СР',
  ///   'ЧТ',
  ///   'ПТ',
  ///   'СБ',
  ///   'ВС',
  /// ];
  /// ```
  final List<String> weekdays;

  /// Number of days per week, used to draw only the required number of days.
  final int daysInWeek;

  /// The back color of the widget.
  final Color? background;

  /// The text style of the selected day.
  final TextStyle? selectedTextStyle;

  /// The text style of the unselected day.
  final TextStyle? unselectedTextStyle;

  @override
  State<CustomWeeklyCalendar> createState() => _CustomWeeklyCalendarState();
}

class _CustomWeeklyCalendarState extends State<CustomWeeklyCalendar> {
  /// Selected day of the week.
  DateTime _selectedDay = DateTime.now();

  /// The number of the week in the year.
  int _weekOfYear = DateTime.now().weekOfYear;

  @override
  Widget build(BuildContext context) {
    final Color background =
        widget.background ?? Theme.of(context).colorScheme.primary;

    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle selected = widget.selectedTextStyle ??
        textTheme.bodyMedium!.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        );
    final TextStyle unselected =
        widget.unselectedTextStyle ?? textTheme.bodyMedium!;

    return CustomContainer(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        children: <Widget>[
          // ========== [Month + Week Type] ==========
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  _getMonthName(),
                  style: textTheme.labelMedium,
                ),
                Text(
                  'Неделя №${_getParityOfTheWeek()}',
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),

          // ========== [Spacer] ==========
          const SizedBox(
            height: 8,
          ),

          // ========== [Custom Weekday Picker] ==========
          _CustomWeekdayPicker(
            // ========== [Settings] ==========
            selectedDay: _selectedDay,
            weekdays: widget.weekdays,
            daysInWeek: widget.daysInWeek,

            // ========== [Appearance] ==========
            background: background,
            selectedTextStyle: selected,
            unselectedTextStyle: unselected,

            // ========== [Methods] ==========
            onDayChanged: _onDayChanged,
            onSwipe: _onSwipe,
          ),
        ],
      ),
    );
  }

  /// Updates the number of the week in the year every time a swipe occurs.
  void _onSwipe(int weekOfYear) {
    setState(() {
      _weekOfYear = weekOfYear;
    });
  }

  /// Updates the selected day of the week every time the
  /// user selects a new day of the week.
  void _onDayChanged(DateTime value) {
    setState(() {
      _selectedDay = value;
    });

    if (widget.onDayChanged != null) {
      widget.onDayChanged!(value);
    }
  }

  /// Returns the type of week depending on whether it is even or odd.
  int _getParityOfTheWeek() {
    return _weekOfYear % 2 == 0 ? 2 : 1;
  }

  /// Returns the name of the month depending on the week number.
  String _getMonthName() {
    // Get the `firstDayOfYear`.
    final DateTime firstDayOfYear = DateTime(DateTime.now().year);

    // Count the number of days from the beginning of the year
    // to the selected week number.
    final Duration daysFromStartOfYear = Duration(
      days: (_weekOfYear - 1) * 7,
    );

    // Calculates the current date by adding the number of days
    // to the beginning of the year.
    final DateTime targetDate = firstDayOfYear.add(daysFromStartOfYear);

    // Return the name of the month based on calculations.
    return months[targetDate.month - 1];
  }
}

/// A private widget for selecting the day of the week by week.
class _CustomWeekdayPicker extends StatefulWidget {
  const _CustomWeekdayPicker({
    required this.selectedDay,
    required this.onDayChanged,
    required this.weekdays,
    required this.daysInWeek,
    this.onSwipe,
    this.background,
    this.selectedTextStyle,
    this.unselectedTextStyle,
  });

  final DateTime selectedDay;
  final List<String> weekdays;
  final int daysInWeek;
  final Function(DateTime selectedDay) onDayChanged;
  final Function(int weekOfYear)? onSwipe;
  final Color? background;
  final TextStyle? unselectedTextStyle;
  final TextStyle? selectedTextStyle;

  @override
  State<_CustomWeekdayPicker> createState() => _CustomWeekdayPickerState();
}

class _CustomWeekdayPickerState extends State<_CustomWeekdayPicker> {
  /// About 1 years back in time should be sufficient for most users, 52 weeks
  final int _weekIndexOffset = 52;

  /// The [PageController] of the weeks pages so that they can be changed.
  late final PageController _controller;

  /// The initial selected day.
  late final DateTime _initialSelectedDay;

  /// The number of the week in the year from the selected day.
  int _weekOfYear = 1;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: _weekIndexOffset);
    _initialSelectedDay = widget.selectedDay;
    _weekOfYear = widget.selectedDay.weekOfYear;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      child: Row(
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (int index) {
                setState(() {
                  _weekOfYear = _initialSelectedDay
                      .addDays(7 * (index - _weekIndexOffset))
                      .weekOfYear;

                  if (widget.onSwipe != null) {
                    widget.onSwipe!(_weekOfYear);
                  }
                });
              },
              itemBuilder: (_, int weekIndex) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _weekdays(weekIndex - _weekIndexOffset),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// A method that builds a week depending on the number of days in a week.
  ///
  /// The number of days per week is specified in the `daysInWeek` parameter.
  List<Widget> _weekdays(int weekIndex) {
    final List<Widget> weekdays = <Widget>[];

    for (int i = 0; i < widget.daysInWeek; i++) {
      final int offset = i + 1 - _initialSelectedDay.weekday;
      final int daysToAdd = weekIndex * 7 + offset;
      final DateTime dateTime = _initialSelectedDay.addDays(daysToAdd);
      weekdays.add(_dateButton(dateTime));
    }

    return weekdays;
  }

  /// The method that builds the button that the widget consists of.
  Widget _dateButton(DateTime dateTime) {
    final String weekday = widget.weekdays[dateTime.weekday - 1];
    final bool isSelected = dateTime.isSameDateAs(widget.selectedDay);

    return GestureDetector(
      onTap: () => widget.onDayChanged(dateTime),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: isSelected ? widget.background : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomText.toggle(
              weekday,
              active: isSelected,
              activeStyle: widget.selectedTextStyle,
              inactiveStyle: widget.unselectedTextStyle,
            ),
            CustomText.toggle(
              '${dateTime.day}',
              active: isSelected,
              activeStyle: widget.selectedTextStyle,
              inactiveStyle: widget.unselectedTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
