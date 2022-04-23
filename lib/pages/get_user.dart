import 'package:dio_example/models/user.dart';
import 'package:dio_example/service/user_service.dart';
import 'package:flutter/material.dart';

class GetUser extends StatefulWidget {
    const GetUser({Key? key}) : super(key: key);

  @override
  _GetUserState createState() => _GetUserState();
}

class _GetUserState extends State<GetUser> {
  final UserService _userService = UserService();
  final TextEditingController _idController = TextEditingController();

  bool _isFetching = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _idController,
                decoration: InputDecoration(hintText: 'Enter ID'),
              ),
            ),
            SizedBox(width: 16.0),
            _isFetching? CircularProgressIndicator() : ElevatedButton(onPressed: () async{
              setState(() {
                _isFetching = true;
              });

              User? user = await _userService.getUser(
                id: _idController.text,
              );
              if (user != null) {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(user.data.avatar),
                            Text('ID: ${user.data.id}'),
                            Text(
                              'Name: ${user.data.firstName} ${user.data.lastName}',
                            ),
                            Text('Email: ${user.data.email}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }

              setState(() {
                _isFetching = false;
              });
            }, child: Text('Get'))
          ],
        ),
      ),
    );
  }

}