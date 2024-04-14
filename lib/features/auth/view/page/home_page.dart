import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_quran/features/auth/controller/bloc/auth_controller_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: BlocProvider(
          create: (context) => AuthControllerBloc(),
          child: BlocBuilder<AuthControllerBloc, AuthControllerState>(
            builder: (context, state) {
              AuthControllerBloc bloc = context.read<AuthControllerBloc>();
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome to the Home Page!',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      bloc.add(SignOut());
                    },
                    child: const Text('Log Out'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
