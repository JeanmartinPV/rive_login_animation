import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:rive_login_animation/features/login/login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  final urlRive = 'assets/rive/login.riv';
  SMITrigger? failTrigger, successTrigger;
  SMIBool? isHandsUp, isChecking;
  SMINumber? lookNumber;
  StateMachineController? stateMachineController;
  Artboard? artboard;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        rootBundle.load(urlRive).then(
          (value) async {
            await RiveFile.initialize();
            final file = RiveFile.import(value);
            final art = file.mainArtboard;
            stateMachineController =
                StateMachineController.fromArtboard(art, "Login Machine");
            if (stateMachineController != null) {
              art.addController(stateMachineController!);
              for (var element in stateMachineController!.inputs) {
                if (element.name == 'isChecking') {
                  isChecking = element as SMIBool;
                } else if (element.name == 'isHandsUp') {
                  isHandsUp = element as SMIBool;
                } else if (element.name == 'trigSuccess') {
                  successTrigger = element as SMITrigger;
                } else if (element.name == 'trigFail') {
                  failTrigger = element as SMITrigger;
                } else if (element.name == 'numLook') {
                  lookNumber = element as SMINumber;
                }
              }
            }

            setState(() => artboard = art);
          },
        );
      },
    );

    super.initState();
  }

  void lookAtInputField() {
    isChecking?.change(true);
    lookNumber?.change(0);
    isHandsUp?.change(false);
  }

  void moveEyes(value) {
    lookNumber?.change(value.length.toDouble());
  }

  void handsUpOnEyes() {
    isHandsUp?.change(true);
    isChecking?.change(false);
  }

  void loginClick() {
    isChecking?.change(false);
    isHandsUp?.change(false);
    if (emailController.text == 'email' && passwordController.text == 'pass') {
      successTrigger?.fire();
    } else {
      failTrigger?.fire();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD6E2EA),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (artboard != null) ...[
              SizedBox(
                height: 250,
                child: Rive(artboard: artboard!),
              )
            ],
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    CustomInput(
                      controller: emailController,
                      labelText: 'Email',
                      hintText: 'Email',
                      onTap: lookAtInputField,
                      onChanged: (value) => moveEyes(value),
                    ),
                    const SizedBox(height: 8),
                    CustomInput(
                      controller: passwordController,
                      labelText: 'Password',
                      hintText: 'Password',
                      onTap: handsUpOnEyes,
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(327, 50),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  )),
              onPressed: loginClick,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
