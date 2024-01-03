import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/provider/meal.dart';
import 'package:provider/provider.dart';
import '../widgets/meal_item.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = 'category_meals';
  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
   String ? categoryTitle;
   late List<Meal> displayMeals;
   @override
  void didChangeDependencies() {
     final List<Meal> availableMeal =Provider.of<MealProvider>(context).availableMeal;
     final routArg = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
     final categoryId = routArg['id']!;
     categoryTitle = routArg['title']!;
     displayMeals= availableMeal.where((meal) {
       return meal.categories.contains(categoryId);
     }).toList();
    super.didChangeDependencies();
  }
  void _removeItem(String item){
    setState(() {
      displayMeals.removeWhere((element) => element.id ==item);
    });

  }

  @override
  Widget build(BuildContext context) {
bool isLandScape=MediaQuery.of(context).orientation==Orientation.landscape;
var sizeDevice=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: GridView.builder(
        itemCount: displayMeals.length,
        gridDelegate:SliverGridDelegateWithMaxCrossAxisExtent(
          crossAxisSpacing:20 ,
          mainAxisSpacing:20 ,
          childAspectRatio: isLandScape? sizeDevice/(sizeDevice*0.8) : sizeDevice/(sizeDevice*0.75)  ,
          maxCrossAxisExtent:sizeDevice<= 400?400:500,
        ),
        itemBuilder: (context, index) {
          return MealItem(
            id:displayMeals[index].id,
            imageUrl: displayMeals[index].imageUrl,
            title: displayMeals[index].title,
            duration: displayMeals[index].duration,
            complexity: displayMeals[index].complexity,
            affordability: displayMeals[index].affordability
          );
        },
      ),
    );
  }
}
