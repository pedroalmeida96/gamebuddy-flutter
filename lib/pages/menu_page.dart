import 'package:flutter/material.dart';
import 'package:gamebuddy/widgets/gamebuddy_appbar.dart';

import '../widgets/menu_card.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GamebuddyAppBar(title: 'Menu'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 350, // Adjust the width of the SizedBox
              height: 350, // Adjust the height of the SizedBox
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(16),
                children: [
                  MenuCard(
                    title: 'My Games',
                    icon: Icons.games,
                    onTap: () {
                      Navigator.pushNamed(context, '/myGames');
                    },
                  ),
                  MenuCard(
                    title: 'All Games',
                    icon: Icons.list_alt,
                    onTap: () {
                      Navigator.pushNamed(context, '/gameList');
                    },
                  ),
                  MenuCard(
                    title: 'Search',
                    icon: Icons.search,
                    onTap: () {
                      Navigator.pushNamed(context, '/search');
                    },
                  ),
                  MenuCard(
                    title: 'Settings',
                    icon: Icons.settings,
                    onTap: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
