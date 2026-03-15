import 'package:bloc_tdd/src/authentication/authentication.dart';
import 'package:bloc_tdd/src/authentication/presentation/blocs/cubit/authentication/authentication.dart';
import 'package:bloc_tdd/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TDD BLOC Simple App',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.redAccent)),
      home: BlocProvider(
        create: (context) => sl<AuthenticationCubit>(),
        child: HomeScreen(),
      ),
    );
  }
}
