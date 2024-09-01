import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/app_user.dart';
import 'package:todo_app/ui/screens/home_screen/home_screen.dart';
import 'package:todo_app/ui/utils/dialog_utils.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register";

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = "";

  String password = "";

  String username = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .25,
              ),
              TextFormField(
                onChanged: (text) {
                  username = text;
                },
                decoration: const InputDecoration(
                  label: Text(
                    "user name",
                  ),
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
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                onChanged: (text) {
                  password = text;
                },
                decoration: const InputDecoration(
                  label: Text(
                    "Password",
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .2,
              ),
              ElevatedButton(
                  onPressed: () {
                    createAccount();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    child: Row(
                      children: [
                        Text(
                          "Create account",
                          style: TextStyle(fontSize: 18),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void createAccount() async {
    try {
      showLoading(context);
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      AppUser user =
          AppUser(id: userCredential.user!.uid, name: username, email: email);
      await addUserToFireStore(user);
      AppUser.currentUser = user;
      if (mounted) {
        hideDialog(context);
        // showMessage(context,
        //     title: 'Success',
        //     body: 'Account created succesfully',
        //     posButtonTitle: 'ok');
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);

      }
    } on FirebaseAuthException catch (authError) {
      if (mounted) {
        hideDialog(context);
      }

      String errorMessage = "";
      if (authError.code == 'weak-password') {
        errorMessage = "The password provided is too weak.";
        // showMessage(context,
        //     title: 'Error', body: 'The password provided is too weak.');
      } else if (authError.code == 'email-already-in-use') {
        errorMessage = "The account already exists for that email.";
        // showMessage(context,
        //     title: 'Error', body: 'The account already exists for that email.');
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

  Future<void> addUserToFireStore(AppUser user) async {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection(AppUser.collectionName);
    DocumentReference userDoc = userCollection.doc(user.id);
    await userDoc.set(user.toJson());
  }
}
