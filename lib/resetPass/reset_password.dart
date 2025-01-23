import 'package:flutter/material.dart';
import 'package:my_auth/auth/auth_service.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();


  Future<void> resetPassword(String email)async{
    await AuthService().resetPassword(context: context, email: email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const Center(child: Text("Reset Password", style: const TextStyle(
                fontSize: 25
              ),),),
              const SizedBox(
                height: 200,
              ),

              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                ),
                child: GestureDetector(
                  onTap: (){
                    resetPassword(_emailController.text.trim());
                  },
                  child: const Center(child:  Text('Reset Password', style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
