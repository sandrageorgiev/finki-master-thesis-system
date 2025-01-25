import 'package:flutter/material.dart';
import 'package:mis_project/models/auth_model.dart';
import 'package:mis_project/services/auth_service.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const BaseAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Navigator.canPop(context)
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
            )
          : null,
      title: Text(title, style: const TextStyle(color: Colors.black)),
      actions: [
        FutureBuilder<User?>(
          future: AuthService.getLoggedInUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Text(
                    snapshot.data!.username,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
