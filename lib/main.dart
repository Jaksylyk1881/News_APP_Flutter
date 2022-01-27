import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/data/cubit/main_page_cubit.dart';
import 'package:newsapp/screens/detail_page.dart';
import 'package:newsapp/screens/main_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainPageCubit>(create: (context)=>MainPageCubit())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(
            color: Color(0xff253B49)
          ),
          scaffoldBackgroundColor: const Color(0xff0D2331)

        ),
        initialRoute: MainPage.id,
        routes: {
          MainPage.id :(context)=> const MainPage(),
        },

      ),
    );
  }
}

