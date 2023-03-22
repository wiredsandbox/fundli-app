import 'package:flutter/material.dart';

class AccountCard extends StatefulWidget {
  final double incoming;
  final double outgoing;
  const AccountCard({
    Key? key,
    required this.incoming,
    required this.outgoing,
  }) : super(key: key);

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.197,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/card.png"),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_circle_up,
                    size: size.width * 0.07,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "₦${widget.incoming}",
                    style: TextStyle(
                      fontSize: size.width * 0.046,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_circle_down,
                    size: size.width * 0.07,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "₦${widget.outgoing}",
                    style: TextStyle(
                      fontSize: size.width * 0.046,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
