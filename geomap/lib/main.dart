import 'package:flutter/material.dart';
import 'package:geomap/pages/geo_page.dart';
import 'package:geomap/providers/geo_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GeoProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/geo-page',
        routes: {
          '/geo-page': (_) => const GetPage(),
        },
      ),
    );
  }
}
