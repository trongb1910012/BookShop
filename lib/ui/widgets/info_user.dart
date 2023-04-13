import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/auth_manager.dart';

class InfoUser extends StatelessWidget {
  const InfoUser({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthManager>();
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100.0,
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQh8EQgAuMYw_vwzL4TTBiLw6eJnV5cJDGQZe4aiZf6Ou2ErQy2"),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              auth.email.toString(),
              style: TextStyle(
                fontSize: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}
