import 'package:flutter/material.dart';
import 'package:meal_app/provider/meal.dart';
import 'package:meal_app/screens/category_screen.dart';
import 'package:meal_app/screens/favorite_screen.dart';
import 'package:meal_app/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';
class TabsScreen extends StatefulWidget {


  @override
  _TabsScreenState createState() => _TabsScreenState();

}
class _TabsScreenState extends State<TabsScreen> {

   late List<Map<String,Object>> pages;
  int selectedIndex=0;
  void selectedPage(int val){
    setState((){
      selectedIndex=val;
    });
  }
  @override
  void didChangeDependencies() {

    Provider.of<MealProvider>(context,listen: false).setData();
    Provider.of<ThemeProvider>(context,listen: false).getThemeMode();
    Provider.of<ThemeProvider>(context,listen: false).getThemeColor();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

  }
  @override
  void initState() {

    pages=
    [
      {'page': CategoryScreen(),
        'title': 'Categories',
      },
      {
        'page':  FavoriteScreen() ,
        'title': 'Favorite',
      }
    ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pages[selectedIndex]['title'] as String) ,),
      body: pages[selectedIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectedPage,
        backgroundColor: Colors.pink,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon:Icon(Icons.category),label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favorite"),

        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
