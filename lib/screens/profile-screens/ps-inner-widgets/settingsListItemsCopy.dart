import 'package:flutter/material.dart';
import 'package:project_borla/theme/app_color.dart';
import '../../../role/components/text/common_text.dart';


class SettingsListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? iconColor;
  final Color? titleColor;
  final VoidCallback? onTap; // already declared

  const SettingsListItem({
    super.key,
    required this.icon,
    required this.title,
    this.iconColor = Colors.amber, // Green accent
    this.titleColor = AppColors.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: onTap, // handle tap
        borderRadius: BorderRadius.circular(10), // ripple respects corners
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE6E6E6)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 26),
              const SizedBox(width: 16),
              CommonText(
                text: title,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: titleColor!,
                textAlign: TextAlign.left,
                maxLines: 1,
              ),
              const Spacer(),
              Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsListItemTwo extends StatelessWidget {
  //final IconData icon;
  final String img;
  final String title;
  //final Color? iconColor;
  final Color? titleColor;
  final VoidCallback? onTap; // already declared

  const SettingsListItemTwo({
    super.key,
    required this.img,
    required this.title,
    //this.iconColor = Colors.amber, // Green accent
    this.titleColor = AppColors.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: onTap, // handle tap
        borderRadius: BorderRadius.circular(10), // ripple respects corners
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE6E6E6)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              //Icon(icon, color: iconColor, size: 26),
              Image.asset( img , height: 26, width: 26,),
              const SizedBox(width: 16),
              CommonText(
                text: title,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: titleColor!,
                textAlign: TextAlign.left,
                maxLines: 1,
              ),
              const Spacer(),
              Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
            ],
          ),
        ),
      ),
    );
  }
}