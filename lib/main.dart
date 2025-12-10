import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:suitmediatest/screens/first_page.dart';
import 'blocs/user_bloc/user_bloc.dart';
import 'repositories/user_repository.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  final userRepository = UserRepository();
  runApp(MyApp(userRepository: userRepository));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: userRepository,
      child: BlocProvider(
        create: (_) => UserBloc(userRepository: userRepository),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mobile Dev Test',
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
            primarySwatch: Colors.teal,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: FirstPage(),
        ),
      ),
    );
  }
}
