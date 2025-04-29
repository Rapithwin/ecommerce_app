import 'package:flutter/material.dart';

class AddQuantity extends StatefulWidget {
  const AddQuantity(
      {super.key,
      required this.minNumber,
      required this.maxNumber,
      required this.iconSize,
      required this.value,
      required this.valueChanged});
  final int minNumber;
  final int maxNumber;
  final double iconSize;
  final int value;
  final ValueChanged valueChanged;

  @override
  State<AddQuantity> createState() => _AddQuantityState();
}

class _AddQuantityState extends State<AddQuantity> {
  late int value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: () {
            setState(
              () {
                value =
                    value == widget.minNumber ? widget.minNumber : value -= 1;
                widget.valueChanged(value);
              },
            );
          },
          icon: const Icon(Icons.remove),
        ),
        Container(
          width: widget.iconSize + 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: theme.colorScheme.outlineVariant,
            ),
          ),
          child: Text(
            value.toString(),
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(
              () {
                value =
                    value == widget.maxNumber ? widget.maxNumber : value += 1;
                widget.valueChanged(value);
              },
            );
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
