import 'package:bright/states/types_states.dart';
import 'package:flutter/material.dart';

class StudentFilteringDS extends StatelessWidget
    with _StudentFilteringDSComponents {
  final StudentFilter studentFilter;
  final Function(StudentFilter) onSelectFilter;

  StudentFilteringDS({Key key, this.studentFilter, this.onSelectFilter})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<StudentFilter>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      icon: popupIcon(studentFilter),
      tooltip: 'Filtrar por',
      onSelected: (value) => onSelectFilter(value),
      itemBuilder: (context) => <PopupMenuItem<StudentFilter>>[
        PopupMenuItem<StudentFilter>(
          value: StudentFilter.active,
          child: Row(
            children: [
              activeIcon,
              SizedBox(width: 5),
              Text(StudentFilter.active.label),
            ],
          ),
        ),
        PopupMenuItem<StudentFilter>(
          value: StudentFilter.inactive,
          child: Row(
            children: [
              inactiveIcon,
              SizedBox(width: 5),
              Text(StudentFilter.inactive.label),
            ],
          ),
        ),
      ],
    );
  }
}

class _StudentFilteringDSComponents {
  final activeIcon = Icon(Icons.person);
  final inactiveIcon = Icon(Icons.person_outline);
  Icon popupIcon(StudentFilter studentFilter) {
    var icon = activeIcon;
    if (studentFilter == StudentFilter.inactive) {
      icon = inactiveIcon;
    }
    return icon;
  }
}
