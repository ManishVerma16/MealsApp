
import 'package:flutter/material.dart';

import './screens/category_meals_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/filters_screen.dart';
import './dummy_data.dart';
import './models/meal.dart';

// import 'screens/categories_screen.dart';

void main(){
  runApp(MyApp()); 
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData){
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if(_filters['gluten'] && !meal.isGlutenFree){
          return false;
        }
        if(_filters['lactose'] && !meal.isLactoseFree){
          return false;
        }
        if(_filters['vegan'] && !meal.isVegan){
          return false;
        }
        if(_filters['vegetarian'] && !meal.isVegetarian){
          return false;
        }
        return true;
      }).toList();
    });
  }
    
  void _toggleFavorite(String mealId){
      final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id== mealId);
      if(existingIndex >=0 ){
        setState(() {
          _favoriteMeals.removeAt(existingIndex);
        });
      }
      else{
        setState(() {
          _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id==mealId));
        });
      }
    }

  bool _isMealFavorite(String id){
      return _favoriteMeals.any((meal) => meal.id==id);
    }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delicious Meal',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.amber,  //black,
        canvasColor: Color.fromRGBO(255,254,229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          bodyText2: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          headline6: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoCondensed',
          ),
        ),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/', // points to default route '/' but can be change to some other page
      routes: {
        '/' : (ctx) => TabsScreen(_favoriteMeals),  // Annotation for home route

        // '/' : (ctx) => CategoriesScreen(),  // Annotation for home route
        CategoryMealsScreen.routeName : (ctx) => CategoryMealsScreen(_availableMeals), // route name created as a static const property
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
    );
  }
}

/*
Route name for meals page
'/category_meals' : (ctx) => CategoryMealsScreen(),  // route name create as a string

*/

/*
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delicious Meals')
      ),
      body: Center(
        child: Text('Navigation Time'),
      ),
    );
  }
}

*/