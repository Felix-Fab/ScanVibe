import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool errorVisible = false;

  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff388e3c),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              const Image(
                image: AssetImage('assets/logo.png'),
                width: 400,
                height: 400,
              ),
              EmailInput(controller: emailController),
              PasswordInput(controller: passwordController),
              Container(
                padding: const EdgeInsets.only(left: 160, top: 2),
                child: const Text("Password vergessen?",
                    style: TextStyle(color: Colors.white)),
              ),
              LoginButton(
                emailController: emailController,
                passwordController: passwordController,
                onLoginError: (message) {
                  setState(() {
                    errorVisible = true;
                    errorMessage = message;
                  });
                },
              ),
              ErrorMessage(
                  errorVisible: errorVisible, errorMessage: errorMessage),
              const DividerWidget(),
              const LoginService(),
              const RegisterText()
            ],
          ),
        ));
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      width: 300,
      height: 60,
      child: TextField(
        controller: controller,
        maxLines: 1,
        style: GoogleFonts.inter(
            color: Colors.black, fontWeight: FontWeight.normal, fontSize: 14),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            hintText: 'Email Adresse',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            prefixIcon: const Icon(Icons.email, color: Colors.black),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.only(
              bottom: 60 / 2, // HERE THE IMPORTANT PART
            )),
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 13),
      width: 300,
      height: 60,
      child: TextField(
        controller: controller,
        maxLines: 1,
        style: GoogleFonts.inter(
            color: Colors.black, fontWeight: FontWeight.normal, fontSize: 14),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            hintText: 'Passwort',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            prefixIcon: const Icon(Icons.lock, color: Colors.black),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.only(
              bottom: 60 / 2, // HERE THE IMPORTANT PART
            )),
      ),
    );
  }
}

class LoginButton extends StatefulWidget {
  const LoginButton({super.key, required this.emailController, required this.passwordController, required this.onLoginError});

  final TextEditingController emailController;
  final TextEditingController passwordController;

  final Function(String) onLoginError;

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {

  var _isLoading = false;

  Future<void> _onSubmit() async {
    setState(() {
      _isLoading = true;
    });

    if (widget.emailController.text.isEmpty || widget.passwordController.text.isEmpty) {
      widget.onLoginError("Fehlende Informationen");

      setState(() {
        _isLoading = false;
      });

      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: widget.emailController.text, password: widget.passwordController.text);

      setState(() {
        _isLoading = false;
      });

      if (context.mounted) {
        context.go('/navigation');
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });

      widget.onLoginError(e.code);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      widget.onLoginError("Unbekannter Fehler aufgetreten");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 60,
      padding: const EdgeInsets.only(top: 20),
      child: ElevatedButton.icon(
        onPressed: _isLoading ? null : _onSubmit,
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xff4caf50)), foregroundColor: MaterialStateProperty.all(Colors.white)),
        icon: _isLoading
            ? Container(
          width: 24,
          height: 24,
          padding: const EdgeInsets.all(2.0),
          child: const CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 3,
          ),
        )
            : const Icon(Icons.person_search),
        label: const Text('Login'),
      ),
    );
  }
}

class ErrorMessage extends StatelessWidget {
  const ErrorMessage(
      {super.key, required this.errorVisible, required this.errorMessage});

  final bool errorVisible;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Visibility(
        visible: errorVisible,
        child: Text(errorMessage, style: const TextStyle(color: Colors.red)),
      ),
    );
  }
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35),
      child: Row(children: <Widget>[
        Expanded(
          child: Container(
              margin: const EdgeInsets.only(left: 10.0, right: 20.0),
              child: const Divider(
                color: Colors.white,
                height: 36,
              )),
        ),
        const Text("Login with", style: TextStyle(color: Colors.white)),
        Expanded(
          child: Container(
              margin: const EdgeInsets.only(left: 20.0, right: 10.0),
              child: const Divider(
                color: Colors.white,
                height: 36,
              )),
        ),
      ]),
    );
  }
}

class LoginService extends StatelessWidget {
  const LoginService({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => loginWithGoogle(context),
            child: const Image(
                image: AssetImage('assets/google.png'), width: 48, height: 48),
          ),
          GestureDetector(
            child: const Image(
                image: AssetImage('assets/apple.png'), width: 50, height: 50),
          ),
          GestureDetector(
            child: const Image(
                image: AssetImage('assets/facebook.png'),
                width: 50,
                height: 50),
          )
        ],
      ),
    );
  }

  loginWithGoogle(BuildContext context) async {
    GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();

    if (kIsWeb) {
      await FirebaseAuth.instance.signInWithPopup(googleAuthProvider);
    } else {
      try {
        await FirebaseAuth.instance.signInWithProvider(googleAuthProvider);

        if (context.mounted) {
          context.go('/navigation');
        }
      } catch (error) {
        debugPrint("Error occured on Google Login");
      }
    }
  }
}

class RegisterText extends StatelessWidget {
  const RegisterText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Noch kein Account? ",
              style: TextStyle(color: Colors.white)),
          GestureDetector(
            onTap: () {
              context.go('/registration');
            },
            child: const Text("Registrieren",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
