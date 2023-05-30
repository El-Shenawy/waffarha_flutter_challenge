import 'package:flutter/material.dart';

class DisplayTypeToggleButtons extends StatefulWidget {
  final bool isGrid;
  final ValueChanged<bool> onChanged;

  const DisplayTypeToggleButtons({
    Key? key,
    this.isGrid = false,
    required this.onChanged,
  }) : super(key: key);

  @override
  _DisplayTypeToggleButtonsState createState() =>
      _DisplayTypeToggleButtonsState();
}

class _DisplayTypeToggleButtonsState extends State<DisplayTypeToggleButtons> {
  late bool _isGrid;

  @override
  void initState() {
    super.initState();
    _isGrid = widget.isGrid;
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: [_isGrid, !_isGrid],
      onPressed: (index) {
        setState(() {
          _isGrid = index == 1;
          widget.onChanged(_isGrid);
        });
      },
      children: const [
        Icon(Icons.list),
        Icon(Icons.grid_on),
      ],
    );
  }
}
