part of '../home_view.dart';

class _PassiveChip extends StatelessWidget {
  const _PassiveChip();

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        'label passive',
        style: context.textTheme.bodySmall?.copyWith(color: ColorsConstants.grayPrimary),
      ),
      backgroundColor: ColorsConstants.grayLighter,
      padding: context.paddingLow,
    );
  }
}

class _ActiveChip extends StatelessWidget {
  const _ActiveChip();

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        'label active',
        style: context.textTheme.bodySmall?.copyWith(color: ColorsConstants.white),
      ),
      backgroundColor: ColorsConstants.purplePrimary,
      padding: context.paddingLow,
    );
  }
}
