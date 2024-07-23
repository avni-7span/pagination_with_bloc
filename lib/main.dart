import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_bloc/weather_data/bloc/user_data_bloc.dart';
import 'package:pagination_bloc/weather_data/views/user_data_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDataBloc(),
      child: const MaterialApp(
        home: UserDataScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
