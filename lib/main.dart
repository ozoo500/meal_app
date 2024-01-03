import 'package:flutter/material.dart';
import 'package:meal_app/provider/meal.dart';
import 'package:meal_app/provider/theme_provider.dart';
import 'package:meal_app/screens/category_meal_screen.dart';
import 'package:meal_app/screens/filter_screen.dart';
import 'package:meal_app/screens/meal_details.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:meal_app/screens/theme.dart';
import 'package:provider/provider.dart';

void main() {

  runApp(
    MultiProvider(providers:[
    ChangeNotifierProvider<MealProvider>(
    create: (BuildContext context) =>MealProvider(),),
      ChangeNotifierProvider(create: (BuildContext context)=>ThemeProvider())
  ],
    child: const MyApp(),
    ), );
}

   class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var primaryColor =Provider.of<ThemeProvider>(context,listen: true).primaryColor;
    var accentColor =Provider.of<ThemeProvider>(context,listen: true).accentColor;
    var tm=Provider.of<ThemeProvider>(context,listen: true).tm;
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: tm,
      theme: ThemeData(
        primarySwatch:primaryColor ,
        accentColor: accentColor,
        cardColor: Colors.white,
        buttonColor: Colors.black87,
        canvasColor: const Color.fromRGBO(255, 254, 299, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText2: const TextStyle( color: Color.fromRGBO(20, 50, 50, 1),),
          headline6:const TextStyle(
            color: Colors.black87,
            fontSize: 24,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold
          ),

        ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink).copyWith(secondary: Colors.amber)

      ),



      darkTheme: ThemeData(
          primarySwatch:primaryColor ,
          accentColor: accentColor,
          unselectedWidgetColor: Colors.white,
          cardColor: const Color.fromRGBO(35, 34, 39, 1),
          buttonColor: Colors.white,
          canvasColor: const Color.fromRGBO(14, 22, 33, 1),
          textTheme: ThemeData.dark().textTheme.copyWith(
            bodyText2: const TextStyle( color: Color.fromRGBO(20, 50, 50, 1),),
            headline6:const TextStyle(
                color: Colors.white60,
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold
            ),

          ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink).copyWith(secondary: Colors.amber)

      ),

      // home: const CategoryScreen(),
      routes: {
        '/':(context)=> TabsScreen(),
        CategoryMealScreen.routeName:(context) =>  CategoryMealScreen(),
        MealDetails.routeName:(context)=> const MealDetails(),
        FilterScreen.routeName:(context)=>FilterScreen(),
        ThemeScreen.routeName:(context)=>ThemeScreen(),
      },
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meal"),
      ),
      body: null,
    );
  }
}
