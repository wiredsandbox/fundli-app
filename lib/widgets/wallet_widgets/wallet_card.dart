import 'package:flutter/material.dart';
import 'package:pocket_guard/utilities/constants.dart';

class WalletCard extends StatelessWidget {
  final bool isEnabled;
  final Color color;
  final IconData iconData;
  final String title;
  final double amount;
  final VoidCallback onTap;
  const WalletCard({
    Key? key,
    required this.isEnabled,
    required this.amount,
    required this.onTap,
    required this.color,
    required this.iconData,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.width * 0.41,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 9,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: isEnabled ? Border.all(color: kPrimary, width: 1.7) : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(iconData, size: 30),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey[800],
              ),
            ),
            Text(
              //"₦${MainUtilities().formatAmount(amount)}",
              "₦₦",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  }
}
