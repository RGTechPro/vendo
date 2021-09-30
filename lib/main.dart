import 'package:flutter/material.dart';
import 'package:vendo/screens/Home/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:vendo/screens/Home/MapPage.dart';
import 'package:vendo/screens/Home/StoryThing/storyHome.dart';
//import 'package:vendo/screens/Home/NewMP.dart';
import 'models/StoryModels/data.dart';
import 'providers/mainProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SellerProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vendo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MapPage(),
      ),
    );
  }
}
