import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/data.dart';
import 'bloc/user_data_bloc.dart';
import 'bloc/user_data_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _idController = TextEditingController();
  final _userDataBloc = UserDataBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: const Text('Example Dio'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            children: [
              _buildRequestField(),
              const SizedBox(height: 64),
              _buildRequestReturn(),
            ],
          ),
        ),
      ),
    );
  }

  _buildRequestField() {
    return Row(
      children: [
        Flexible(
          child: TextField(
            controller: _idController,
            decoration: const InputDecoration(hintText: 'Enter ID'),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 16),
        BlocProvider(
          create: (context) => _userDataBloc,
          child: BlocBuilder<UserDataBloc, UserDataState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () async {
                  if (_idController.text.isEmpty) {
                    const snackBar = SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(
                        'Please enter some text',
                        textAlign: TextAlign.center,
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    BlocProvider.of<UserDataBloc>(context)
                        .add(GetUserDataEvent(_idController.text));
                  }
                },
                child: const Text('Get'),
              );
            },
          ),
        ),
      ],
    );
  }

  _buildRequestReturn() {
    return BlocProvider(
      create: (context) => _userDataBloc,
      child: BlocBuilder<UserDataBloc, UserDataState>(
        builder: (context, state) {
          if (state.getState() == 'loading') {
            return const CircularProgressIndicator();
          }
          if (state.getState() == 'loaded') {
            UserDataLoaded loaded = state as UserDataLoaded;
            Data? data = loaded.data;
            String? imgURL = data?.avatar;
            return Column(
              children: [
                Text('ID: ${data?.id}'),
                Text(
                  'Name: ${data?.firstName} ${data?.lastName}',
                ),
                Text('Email: ${data?.email}'),
                Image.network(imgURL!),
              ],
            );
          }

          return const Text('Sem dados.');
        },
      ),
    );
  }
}
