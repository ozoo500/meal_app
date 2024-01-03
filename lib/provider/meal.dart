
import'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dummy_data.dart';
import '../models/category.dart';
import '../models/meal.dart';
class MealProvider with ChangeNotifier{

  Map<String ,bool> filters ={
    'isGlutenFree' : false,
    'isLactoseFree' : false,
    'isVegan' : false,
    'isVegetarian' : false,
  };
  List<Meal> availableMeal = DUMMY_MEALS;
  List<Meal> favoriteMeal = [];
  List<String>preferMealId =[];
 List<Category>availableCategory=[];
  void setFilters()async{

      availableMeal =DUMMY_MEALS.where((meal) {
        if(filters['isGlutenFree']! &&!meal.isGlutenFree){
          return false;
        }
        if(filters['isLactoseFree']! &&!meal.isLactoseFree){
          return false;
        }
        if(filters['isVegan']! &&!meal.isVegan){
          return false;
        }
        if(filters[ 'isVegetarian']! &&!meal.isVegetarian){
          return false;
        }
        return true;
      }).toList();
      List<Category>ac=[];
availableMeal.forEach((meal) {
  meal.categories.forEach((catId) {
    DUMMY_CATEGORIES.forEach((cat) {
      if(cat.id ==catId){
        if(!ac.any((cat) =>cat.id==catId )) {
          ac.add(cat);
        }



      }
    });
  });
});
availableCategory =ac;
   notifyListeners();
   SharedPreferences  prefer= await SharedPreferences.getInstance() ;
   prefer.setBool("isGlutenFree", filters['isGlutenFree']!);
   prefer.setBool("isLactoseFree", filters['isLactoseFree']!);
   prefer.setBool("isVegan", filters['isVegan']!);
   prefer.setBool( "isVegetarian", filters[ 'isVegetarian']!);

  }
  setData()async{
    SharedPreferences  prefer= await SharedPreferences.getInstance() ;
   // prefer.clear();
    filters['isGlutenFree']= prefer.getBool("isGlutenFree" )??false;
    filters['isLactoseFree']= prefer.getBool("isLactoseFree" )??false;
    filters['isVegan']= prefer.getBool("isVegan" )??false;
    filters['isVegetarian']= prefer.getBool("isVegetarian" )??false;
    setFilters();
    preferMealId=prefer.getStringList("preferMealId")??[];
    for(var mealId in preferMealId){
      final existingIndex = favoriteMeal.indexWhere((meal) => meal.id ==mealId);
      if(existingIndex<0) {
        favoriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      }
    }

    notifyListeners();

  }
  void toggleFavorites(String mealId) async{
    SharedPreferences  prefer= await SharedPreferences.getInstance() ;
    final existingIndex = favoriteMeal.indexWhere((meal) => meal.id ==mealId);
    if(existingIndex>=0){

        favoriteMeal.removeAt(existingIndex);
        preferMealId.remove(mealId);
    }else{

      favoriteMeal.add(DUMMY_MEALS.firstWhere((meal)=> meal.id ==mealId));
      preferMealId.add(mealId);
    }
    prefer.setStringList("preferMealId", preferMealId);
    notifyListeners();
  }
  bool isMealFavorite(String id){
    return favoriteMeal.any((meal) => meal.id ==id);
   // notifyListeners();
  }
}
