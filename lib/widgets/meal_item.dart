import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meal_details.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String title;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;


 const MealItem(
      {required this.id,
        required this.imageUrl,
      required this.title,
      required this.duration,
      required this.complexity,
      required this.affordability,
      });

  void selectMeal(BuildContext context) {
    Navigator.of(context).pushNamed(MealDetails.routeName,
    arguments: id);

  }
  String get complexityText{
    switch(complexity){
      case Complexity.Simple :return 'Simple' ; break;
      case Complexity.Challenging :return 'Challenging' ; break;
      case Complexity.Hard:return 'Hard' ; break;
      default: return 'Unknown '; break;

    }
  }

  String get  affordabilityText{
    switch(affordability){
      case Affordability.Affordable :return 'Affordable' ; break;
      case Affordability.Luxurious :return 'Luxurious' ; break;
      case Affordability.Pricey:return 'Pricey' ; break;
      default: return 'Unknown '; break;

    }
  }



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                    child: Hero(
                      tag: id,
                      child: Image.network(
                        imageUrl,

                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: Container(
                      width: 200,
                      color: Colors.black38,
                      child: Text(
                        title,
                        style: const TextStyle(fontSize: 20.0, color: Colors.white),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                       Icon(Icons.schedule,color: Theme.of(context).buttonColor,),
                      const SizedBox(width: 5,),
                      Text("$duration min",style: const TextStyle(
                        color: Colors.white60
                      ),),
                    ],
                  ),
                  Row(
                    children: [
                       Icon(Icons.work,color: Theme.of(context).buttonColor),
                      const SizedBox(width: 5,),
                      Text(complexityText,style: const TextStyle(
                          color: Colors.white60
                      ),),
                    ],),
                  Row(
                    children: [
                      Icon(Icons.attach_money,color: Theme.of(context).buttonColor),
                      const SizedBox(width: 5,),
                      Text(affordabilityText,style: const TextStyle(
                          color: Colors.white60
                      ),),
                    ],

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
