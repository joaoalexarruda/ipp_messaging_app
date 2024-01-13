/*
  Esse widget é usado para exibir a gaveta na página inicial.
  Ela contém as tiles de logotipo, página inicial, configurações e lista de logout.
  O home list tile é usado para navegar até a página inicial.
  O settings list tile é usado para navegar até a página de configurações.
  O logout list tile é usado para fazer logout do aplicativo.
*/

import 'package:flutter/material.dart';
import 'package:ipp_messaging_app/services/auth/auth_service.dart';
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
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage("assets/images/ipp_logo.png"),
                        height: 40,
                      ),
                      const SizedBox(width: 12),
                      Icon(Icons.message,
                          size: 45,
                          color: Theme.of(context).colorScheme.primary),
                    ],
                  ),
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
