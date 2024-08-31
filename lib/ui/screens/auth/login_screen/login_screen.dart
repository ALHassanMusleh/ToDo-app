import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/screens/auth/register_screen/register_screen.dart';
import 'package:todo_app/ui/screens/home_screen/home_screen.dart';
import 'package:todo_app/ui/utils/dialog_utils.dart';
import 'package:todo_app/ui/utils/extension.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Login"),
        toolbarHeight: MediaQuery.of(context).size.height * .1,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .25,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Welcome back !",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  onChanged: (text) {
                    email = text;
                  },
                  decoration: const InputDecoration(
                    label: Text(
                      "Email",
                    ),
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty == true) {
                      return "emails can not be empty";
                    }
                    if (!text.isValidEmail) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  onChanged: (text) {
                    password = text;
                  },
                  obscureText: true,
                  validator: (password) {
                    if (password == null || password.isEmpty == true) {
                      return "empty passwords are not allowed";
                    }
                    if (password.length < 6) {
                      return "passwords can not be less than 6 charcters";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text(
                      "Password",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                ElevatedButton(
                    onPressed: () {
                      signIn();
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      child: Row(
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(fontSize: 18),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward)
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 18,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RegisterScreen.routeName);
                  },
                  child: const Text(
                    "Create account",
                    style: TextStyle(fontSize: 18, color: Colors.black45),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    if (!formKey.currentState!.validate()) return;
    try {
      showLoading(context);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print(userCredential.user!.uid);
      if (mounted) {
        hideDialog(context);
        // showMessage(context,
        //     title: 'Success',
        //     body: 'Account created succesfully',
        //     posButtonTitle: 'ok');
        Navigator.pushNamed(context, HomeScreen.routeName);
      }
    } on FirebaseAuthException catch (authError) {
      if (mounted) {
        hideDialog(context);
      }

      String errorMessage = "";
      // if (authError.code == 'user-not-found') {
      //   errorMessage = "No user found for that email.";
      //   // showMessage(context,
      //   //     title: 'Error', body: 'The password provided is too weak.');
      // } else if (authError.code == 'wrong-password') {
      //   errorMessage = "Wrong password provided for that user.";
      //   // showMessage(context,
      //   //     title: 'Error', body: 'The account already exists for that email.');
      // }
      if (authError.code == 'channel-error') {
        errorMessage = "Wrong email or password Pleas double your creds.";
      } else {
        errorMessage =
            "${authError.message ?? "something went wrong please later"} ";
        // showMessage(context,
        //     title: 'Error',
        //     body: '${authError.message} ?? something went wrong please later');
      }

      if (mounted) {
        showMessage(context,
            title: 'Error', body: errorMessage, posButtonTitle: 'ok');
      }
    } catch (error) {
      print('Error $error');
      if (mounted) {
        hideDialog(context);
        showMessage(context,
            title: 'Error',
            body: 'something went wrong please later',
            posButtonTitle: 'ok');
      }
    }
  }
}
