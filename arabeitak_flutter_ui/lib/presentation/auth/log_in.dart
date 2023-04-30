import 'package:arabeitak_flutter_ui/domain/models/user/user.dart';
import 'package:arabeitak_flutter_ui/domain/models/user/technician.dart';
import 'package:arabeitak_flutter_ui/domain/models/user/owner.dart';
import 'package:arabeitak_flutter_ui/domain/models/user/admin.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //TODO: UI + implementation + session handler
            TextButton(
                onPressed: (() {
                  Navigator.pushNamed(context, '/home');
                }),
                style: ButtonStyle(
                    shadowColor: MaterialStateProperty.all(Colors.black12)),
                child: const Text("Sign in",
                    style: TextStyle(color: Colors.black))),
            TextButton(
                onPressed: (() {
                  Navigator.pushNamed(context, '/auth/sign_up');
                }),
                style: ButtonStyle(
                    shadowColor: MaterialStateProperty.all(Colors.black12)),
                child: const Text("Sign up",
                    style: TextStyle(color: Colors.black))),
          ],
        ),
      ),
    );
  }
}
