import 'package:flutter/material.dart';
import 'package:ipp_messaging_app/auth/auth_service.dart';
import 'package:ipp_messaging_app/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // logo
          Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: Icon(Icons.message,
                      size: 45, color: Theme.of(context).colorScheme.primary),
                ),
              ),

              // home list tile
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text(
                    "H O M E",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context)
                          .colorScheme
                          .inversePrimary
                          .withOpacity(0.5),
                    ),
                  ),
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              // settings list tile
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text(
                    "S E T T I N G S",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context)
                          .colorScheme
                          .inversePrimary
                          .withOpacity(0.5),
                    ),
                  ),
                  leading: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onTap: () {
                    Navigator.pop(context);

                    // navigate to settings page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          // logout list tile
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
              bottom: 25,
            ),
            child: ListTile(
              title: Text(
                "L O G O U T",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context)
                      .colorScheme
                      .inversePrimary
                      .withOpacity(0.5),
                ),
              ),
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: () {
                logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
