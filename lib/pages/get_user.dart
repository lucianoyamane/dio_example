import 'package:dio_example/models/data.dart';
import 'package:dio_example/pages/bloc/user_data_bloc.dart';
import 'package:dio_example/pages/bloc/user_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetUser extends StatefulWidget {
    const GetUser({Key? key}) : super(key: key);

  @override
  _GetUserState createState() => _GetUserState();
}

class _GetUserState extends State<GetUser> {
  final TextEditingController _idController = TextEditingController();
  final UserDataBloc _userDataBloc = UserDataBloc();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _idController,
                    decoration: const InputDecoration(hintText: 'Enter ID'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16.0),
                BlocProvider(create: (context) => _userDataBloc,
                  child: BlocBuilder<UserDataBloc, UserDataState>(
                    builder:(context, state) {
                      if (state.getState() == 'loading') {
                        return const CircularProgressIndicator();
                      }
                      return ElevatedButton(onPressed: ()  async{
                        BlocProvider.of<UserDataBloc>(context).add(GetUserDataEvent(_idController.text));
                      }, child: const Text('Get'));

                    }) ,
                  ) ,

              ],
            ),
            BlocProvider(create: (context) => _userDataBloc,
              child: BlocBuilder<UserDataBloc, UserDataState>(
                  builder:(context, state) {
                    if (state.getState() == 'loaded') {
                      UserDataLoaded loaded = state as UserDataLoaded;
                      Data? data = loaded.data;
                      String? imgURL = data?.avatar;
                      return  Column(children: [
                          Text('ID: ${data?.id}'),
                          Text(
                            'Name: ${data?.firstName} ${data?.lastName}',
                          ),
                          Text('Email: ${data?.email}'),
                          Image.network(imgURL!),
                        ],
                      );
                    }
                    return const Text('sem dados');

                  }) ,
            ),
          ],
        ),
      ),
    );
  }
}