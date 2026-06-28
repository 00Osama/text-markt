import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_markt/core/helpers/responsive.dart';
import 'package:text_markt/core/localization/language_cubit.dart';
import 'package:text_markt/generated/l10n.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 60 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).preferences,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 5),
              _SettingsPillSwitcher<LanguageState>(
                selectedValue: state,
                items: [
                  _SwitcherItem(
                    value: LanguageState.english,
                    label: S.of(context).english,
                  ),
                  _SwitcherItem(
                    value: LanguageState.arabic,
                    label: S.of(context).arabic,
                  ),
                  _SwitcherItem(
                    value: LanguageState.french,
                    label: S.of(context).french,
                  ),
                ],
                onChanged: context.read<LanguageCubit>().setLanguage,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SettingsPillSwitcher<T> extends StatelessWidget {
  const _SettingsPillSwitcher({
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  final List<_SwitcherItem<T>> items;
  final T selectedValue;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isTablet = Responsive.isTablet(context);

    return Container(
      height: isTablet ? 72 : 48,
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 14 : 8),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _SettingIcon(icon: Icons.language_rounded, isTablet: isTablet),
          SizedBox(width: isTablet ? 14 : 9),
          Text(
            S.of(context).language,
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF17383D),
              fontSize: isTablet ? 20 : 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Container(
            height: isTablet ? 42 : 30,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: items.map((item) {
                final isSelected = item.value == selectedValue;
                return _SwitcherButton(
                  label: item.label,
                  isTablet: isTablet,
                  isSelected: isSelected,
                  onTap: () => onChanged(item.value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingIcon extends StatelessWidget {
  const _SettingIcon({required this.icon, required this.isTablet});

  final IconData icon;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isTablet ? 42 : 28,
      height: isTablet ? 42 : 28,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: isTablet ? 24 : 16,
        color: Theme.of(context).textTheme.bodyMedium?.color,
      ),
    );
  }
}

class _SwitcherButton extends StatelessWidget {
  const _SwitcherButton({
    required this.label,
    required this.isTablet,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isTablet;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isSelected
        ? (isDark ? Colors.white : const Color(0xFF17383D))
        : (isDark ? const Color(0xFFB6C8CA) : const Color(0xFF64777A));

    return AnimatedContainer(
      height: double.infinity,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: isSelected
            ? (isDark ? const Color(0xFF09282D) : Colors.white)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? .18 : .08),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 12 : 8),
            child: Center(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: textColor,
                  fontSize: isTablet ? 16 : 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SwitcherItem<T> {
  const _SwitcherItem({required this.value, required this.label});

  final T value;
  final String label;
}
