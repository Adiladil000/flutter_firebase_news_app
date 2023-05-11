part of '../home_view.dart';

class _PassiveChip extends StatelessWidget {
  const _PassiveChip(this.tag);
  final Tag tag;
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        tag.name ?? '',
        style: context.textTheme.bodySmall?.copyWith(color: ColorsConstants.grayPrimary),
      ),
      backgroundColor: ColorsConstants.grayLighter,
      padding: context.paddingLow,
    );
  }
}

class _ActiveChip extends StatelessWidget {
  const _ActiveChip(this.tag);
  final Tag tag;
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        tag.name ?? '',
        style: context.textTheme.bodySmall?.copyWith(color: ColorsConstants.white),
      ),
      backgroundColor: ColorsConstants.purplePrimary,
      padding: context.paddingLow,
    );
  }
}
