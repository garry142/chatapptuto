import 'package:chatapptuto/services/auth/auth_service.dart';
import 'package:chatapptuto/components/my_botton.dart';
import 'package:chatapptuto/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwlController = TextEditingController();
  final TextEditingController _confirmpwlController = TextEditingController();

  //tap to go register page
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

//Register method
  void register(BuildContext context) {
    //get auth service
    final _auth = AuthService();
    //pasword match  -> create user
    if( _pwlController.text == _confirmpwlController.text){
      try{
      _auth.signUpWithEmailPassword(
      _emailController.text,
      _pwlController.text
      );
      }catch (e){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title:Text(e.toString()),
        ),
      );
      }
    }
    //paswords dont Match -> show error to user to fex
    else{
       showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title:Text("Password dont match"),
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
                "Let's create an accont for you",
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
                height: 15,
              ),
              MyTextfield(
                hintText: "Confirm Password",
                obscureText: true,
                constroller: _confirmpwlController,
              ),
              const SizedBox(
                height: 15,
              ),

              //login button
              MyButton(
                text: "Register",
                onTap: () => register(context),
              ),
              const SizedBox(
                height: 20,
              ),
              //register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have a accont?",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      "Login now",
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
