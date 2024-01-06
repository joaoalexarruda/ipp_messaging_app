/* 
  Esse widget é responsável por criar uma tile com o email dos usuários
  na home page 
*/

import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 0,
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // icon
            Icon(Icons.person, color: Theme.of(context).colorScheme.primary),

            const SizedBox(
              width: 20,
            ),

            // user name
            Text(
              text,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
