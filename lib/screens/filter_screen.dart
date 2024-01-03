
import 'package:flutter/material.dart';
import 'package:meal_app/provider/meal.dart';
import 'package:meal_app/provider/theme_provider.dart';
import 'package:meal_app/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
static const routeName = "filter_screen";

  const FilterScreen({Key? key}) : super(key: key);


  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String,bool>currentFilter=Provider.of<MealProvider>(context,listen: true).filters;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      body: Column(
        children: [
          Container(
            padding:const EdgeInsets.all(20),
            child:   Text("Adjust Your Meal Selection",style: Theme.of(context).textTheme.headline6),
          ),
            Expanded(
                child: ListView(
                  children: [
                    buildSwitchListTile("Gluten-free","Only include Gluten-free Meals",
                        currentFilter[' isGlutenFree']??false,(val){
                      setState(() {
                        currentFilter[' isGlutenFree'] =val;
                      });
                      Provider.of<MealProvider>(context,listen: false).setFilters();
                    }),
                    buildSwitchListTile("Vegetarian","Only include Vegetarian Meals",
                        currentFilter['isVegetarian']??false,(val){
                      setState(() {
                        currentFilter['isVegetarian'] =val;
                      });
                      Provider.of<MealProvider>(context,listen: false).setFilters();

                        }),
                    buildSwitchListTile("Vegan","Only include Vegan Meals",
                        currentFilter[' isVegan']??false,(val){
                      setState(() {
                        currentFilter[' isVegan'] =val;
                      });
                      Provider.of<MealProvider>(context,listen: false).setFilters();

                        }),
                    buildSwitchListTile("LactoseFree","Only include LactoseFree Meals",
                        currentFilter['isLactoseFree']??false,(val){
                      setState(() {
                        currentFilter['isLactoseFree'] =val;
                      });
                      Provider.of<MealProvider>(context,listen: false).setFilters();

                        })

                  ],
                ),
            ),

        ],
      ),
      drawer: const MainDrawer(),
    );
  }

  SwitchListTile buildSwitchListTile(String title,String desc, bool currentVal, updateValue) {
    return SwitchListTile(
                      title: Text(title) ,
                      subtitle:Text(desc) ,
                      value: currentVal,
                      onChanged: updateValue,
      inactiveTrackColor: Provider.of<ThemeProvider>(context,listen: true).tm==ThemeMode.light?null:Colors.black,
                      );
  }

}

