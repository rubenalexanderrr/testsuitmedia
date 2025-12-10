import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmediatest/screens/third_page.dart';
import 'package:suitmediatest/utils/my_app_bar.dart';
import '../blocs/user_bloc/user_bloc.dart';
import '../blocs/user_bloc/user_state.dart';

class SecondPage extends StatelessWidget {
  final String name;
  const SecondPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(text: 'Second Screen'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 32, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 6),
              Text(
                name.isEmpty ? 'Unknown' : name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              Expanded(
                child: Center(
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      String selected = 'Selected User Name';
                      if (state is UserLoadSuccess &&
                          state.selectedUser != null) {
                        selected = state.selectedUser!.fullName;
                      }
                      return Text(
                        selected,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ThirdPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 43, 99, 123),
                  foregroundColor: Colors.white,
                ),
                child: Center(child: Text('Choose a User')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
