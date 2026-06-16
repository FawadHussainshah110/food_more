part of '../pinput.dart';

typedef PinItemWidgetBuilder = Widget Function(BuildContext context, PinItemState pinItemBuilderState);

enum PinItemStateType { initial, focused, submitted, following, disabled, error }

class PinItemState {
  const PinItemState({required this.value, required this.index, required this.type});
  final String value;
  final int index;
  final PinItemStateType type;
}

class _PinItemBuilder {
  const _PinItemBuilder({
    required this.itemBuilder,
  });

  final PinItemWidgetBuilder itemBuilder;
}
