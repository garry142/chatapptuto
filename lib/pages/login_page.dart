import 'package:chatapptuto/services/auth/auth_service.dart';
import 'package:chatapptuto/components/my_botton.dart';
import 'package:chatapptuto/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  //email and pw text  controller

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwlController = TextEditingController();

  //tap to go to register page
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  //Login  method
  void login(BuildContext context) async {
    //auth service
    final authService = AuthService();

    //try login
    try {
      await authService.signInWithEmailPassword(
        _emailController.text,
        _pwlController.text,
      );
    }

    //cath any errors
    catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title:Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // ignore: deprecated_member_use
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo

              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(
                height: 50,
              ),
              //Welcome  back messenge
              Text(
                "Welcome back, you've been missed!",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 25,
              ),

              //email texfield
              MyTextfield(
                hintText: "Email",
                obscureText: false,
                constroller: _emailController,
              ),
              const SizedBox(
                height: 10,
              ),
              //pw texfield
              MyTextfield(
                hintText: "Password",
                obscureText: true,
                constroller: _pwlController,
              ),
              const SizedBox(
                height: 20,
              ),

              //login button
              MyButton(
                text: "Login",
                onTap: () => login(context),
              ),
              const SizedBox(
                height: 20,
              ),
              //register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member?",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      "Register now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
