import 'package:flutter/material.dart';
import 'package:meal_app/screens/filter_screen.dart';
import 'package:meal_app/screens/theme.dart';

class  MainDrawer extends StatelessWidget {
  const  MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Column(
        children: [
          Container(
            height:120,
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            alignment: Alignment.centerLeft,
            child:  const Text("Cooking Up!",style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.white),),
            color:Theme.of(context).accentColor,
          ),
          const SizedBox(height: 20,),
           buildListTile(context,"Meal",Icons.restaurant,(){ Navigator.of(context).pushReplacementNamed('/');}),
           buildListTile(context,"Filter",Icons.settings,(){ Navigator.of(context).pushReplacementNamed(
               FilterScreen.routeName);}),
          buildListTile(context,"Themes",Icons.color_lens,(){ Navigator.of(context).pushReplacementNamed(
              ThemeScreen.routeName);}),
        ],
      ),
    );
  }

  ListTile buildListTile(BuildContext context,String title,IconData icon,VoidCallback tap ) {
    return ListTile(
          leading: Icon(icon,size: 20,color: Theme.of(context).buttonColor,),
          title: Text(title,style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
            fontFamily:  'RobotoCondensed',),),
           onTap: tap ,
    );
  }
}


