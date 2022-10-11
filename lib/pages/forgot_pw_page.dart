import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _emailController = TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
  try{
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: _emailController.text.trim());
    showDialog(
        context: context,
        builder: (builder){
          return AlertDialog(
            content: Text('Password reset link sent!Check your mail.'),
          );
        }
    );
  } on FirebaseAuthException catch (e){
    print(e);
    showDialog(
        context: context,
        builder: (builder){
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        }
    );
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Enter your email and we will send you a password reset link',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10,),
          //email textfield
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadiusDirectional.circular(12),
              ),
              child:  Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          MaterialButton(
            onPressed: (){
              passwordReset();
            },
            child: Text('Reset Password'),
            color: Colors.deepPurple[200],
          )

        ],
      ),
    );
  }
}
