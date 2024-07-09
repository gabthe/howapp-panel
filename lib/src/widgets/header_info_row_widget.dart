import 'package:flutter/material.dart';

class HeaderInfoRowWidget extends StatelessWidget {
  final String text;
  final String placeholderText;
  final IconData icons;
  final bool darkMode;
  final Color? darkModeColor;

  const HeaderInfoRowWidget({
    super.key,
    this.darkModeColor,
    required this.text,
    required this.icons,
    required this.placeholderText,
    required this.darkMode,
  });

  @override
  Widget build(BuildContext context) {
    // Define o valor padrão para darkModeColor como Colors.white se for null
    final effectiveDarkModeColor = darkModeColor ?? Colors.white;

    return Row(
      children: [
        Icon(
          icons,
          color: darkMode ? effectiveDarkModeColor : Colors.black,
        ),
        Flexible(
          child: Tooltip(
            message: text,
            child: Text(
              text.isEmpty ? placeholderText : text,
              style: TextStyle(
                color: darkMode ? effectiveDarkModeColor : Colors.black,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
