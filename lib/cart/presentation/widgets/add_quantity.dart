import 'package:e_commerce/authentication/presentation/bloc/auth_bloc.dart';
import 'package:e_commerce/cart/presentation/bloc/cart_bloc.dart';
import 'package:e_commerce_data/cart_data/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddQuantity extends StatefulWidget {
  const AddQuantity(
      {super.key,
      required this.minNumber,
      required this.maxNumber,
      required this.iconSize,
      required this.value,
      required this.valueChanged,
      required this.item});
  final int minNumber;
  final int maxNumber;
  final double iconSize;
  final int value;
  final CartItems item;
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
            final authState = context.read<AuthBloc>().state;
            if (authState is Authenticated) {
              context
                  .read<CartBloc>()
                  .add(RemoveItemFromCart(widget.item.id!, authState.token));
            }
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
            final authState = context.read<AuthBloc>().state;
            if (authState is Authenticated) {
              context.read<CartBloc>().add(
                  AddItemToCart(widget.item.productId!, 1, authState.token));
            }
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
