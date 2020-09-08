import 'package:bright/states/types_states.dart';
import 'package:flutter/material.dart';

class MeetFilteringDS extends StatelessWidget with _MeetFilteringDSComponents {
  final MeetFilter meetFilter;
  final Function(MeetFilter) onSelectFilter;

  MeetFilteringDS({Key key, this.meetFilter, this.onSelectFilter})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MeetFilter>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      icon: popupIcon(meetFilter),
      tooltip: 'Filtrar por',
      onSelected: (value) => onSelectFilter(value),
      itemBuilder: (context) => <PopupMenuItem<MeetFilter>>[
        PopupMenuItem<MeetFilter>(
          value: MeetFilter.paid,
          child: Row(
            children: [
              paidIcon,
              SizedBox(width: 5),
              Text(MeetFilter.paid.label),
            ],
          ),
        ),
        PopupMenuItem<MeetFilter>(
          value: MeetFilter.notpaid,
          child: Row(
            children: [
              notpaidIcon,
              SizedBox(width: 5),
              Text(MeetFilter.notpaid.label),
            ],
          ),
        ),
      ],
    );
  }
}

class _MeetFilteringDSComponents {
  final paidIcon = Icon(Icons.monetization_on);
  final notpaidIcon = Icon(Icons.money_off);
  Icon popupIcon(MeetFilter meetFilter) {
    var icon = paidIcon;
    if (meetFilter == MeetFilter.notpaid) {
      icon = notpaidIcon;
    }
    return icon;
  }
}
