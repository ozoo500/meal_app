import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/provider/meal.dart';
import 'package:provider/provider.dart';

class MealDetails extends StatelessWidget {
  static const routeName = "meal_details";

  const MealDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLandScape=MediaQuery.of(context).orientation==Orientation.landscape;

    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedId = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    var liSteps =ListView.builder(
      itemCount: selectedId.steps.length,
      itemBuilder: (context, index) => Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text("${index + 1}"),
            ),
            title: Text(selectedId.steps[index],style:const TextStyle(color:Colors.black)),
          ),
          const Divider(),
        ],
      ),
    );
    var liIngrediant = ListView.builder(
      itemCount: selectedId.ingredients.length,
      itemBuilder: (context, index) => Card(
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            selectedId.ingredients[index],


          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedId.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Hero(
                tag: mealId,
                child: Image.network(
                  selectedId.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          if(isLandScape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    buildContainer(context, "Ingredients"),
                    buildListView(liIngrediant,context),
                  ],
                ),
                Column(
                  children: [
                    buildContainer(context, "Steps"),
                    buildListView(liSteps,context),

                  ],
                ),
              ],

            ),
          if(!isLandScape)
            buildContainer(context, "Ingredients"),
            buildListView(liIngrediant,context),
            buildContainer(context, "Steps"),
            buildListView(liSteps,context),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<MealProvider>(context, listen: false)
              .toggleFavorites(mealId);
        },
        child: Icon((Provider.of<MealProvider>(context).isMealFavorite(mealId))
            ? Icons.star
            : Icons.star_border),
      ),
    );
  }

  Widget buildListView(Widget child,BuildContext context) {
    bool isLandScape=MediaQuery.of(context).orientation==Orientation.landscape;
    var sizeDevice=MediaQuery.of(context).size.width;
    var sizeDeviceHeigth=MediaQuery.of(context).size.height;
    return Container(
      height: isLandScape?(sizeDeviceHeigth*0.5):sizeDeviceHeigth*0.25,
      width: isLandScape?(sizeDevice*0.5-30):sizeDevice,
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10.0)),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: child,
    );
  }

  Container buildContainer(BuildContext context, String str) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        str,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
