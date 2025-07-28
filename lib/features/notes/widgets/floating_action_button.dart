
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/ui_view_model.dart';

class FloatingActionButtonComponent extends StatelessWidget {
  const FloatingActionButtonComponent({
    super.key,
    required this.dVm,
  });

  final UiViewModel dVm;

  @override
  Widget build(BuildContext context) {
    return Selector<UiViewModel, bool>(
        builder: (context, value, child) {
          return value
              ? const SizedBox.shrink()
              : FloatingActionButton(
                  onPressed: () => dVm.navigateToAdd(),
                  child: const Icon(Icons.add_outlined, size: 30),
                );
        },
        selector: (_, vm) => vm.isSelectedMode);
  }
}
