import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordReplyController = TextEditingController();

  bool errorVisible = false;

  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff388e3c),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
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
              PasswordReplyInput(controller: passwordReplyController),
              RegistrationButton(
                emailController: emailController,
                passwordController: passwordController,
                passwordReplyController: passwordReplyController,
                onLoginError: (message) {
                  setState(() {
                    errorVisible = true;
                    errorMessage = message;
                  });
                },
              ),
              ErrorMessage(
                  errorVisible: errorVisible, errorMessage: errorMessage),
              const LoginText()
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
      padding: const EdgeInsets.only(top: 18),
      width: 300,
      height: 65,
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

class PasswordReplyInput extends StatelessWidget {
  const PasswordReplyInput({super.key, required this.controller});

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

class RegistrationButton extends StatefulWidget {
  const RegistrationButton(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.passwordReplyController,
      required this.onLoginError});

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordReplyController;

  final Function(String) onLoginError;

  @override
  State<RegistrationButton> createState() => _RegistrationButtonState();
}

class _RegistrationButtonState extends State<RegistrationButton> {
  var isLoading = false;

  Future<void> _onSubmit() async {
    setState(() {
      isLoading = true;
    });

    if (widget.emailController.text.isEmpty ||
        widget.passwordController.text.isEmpty ||
        widget.passwordReplyController.text.isEmpty) {
      widget.onLoginError("Fehlende Informationen");

      setState(() {
        isLoading = false;
      });

      return;
    }

    if (widget.passwordController.text != widget.passwordReplyController.text) {
      widget.onLoginError("Passwörter sind nicht gleich");

      setState(() {
        isLoading = false;
      });

      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: widget.emailController.text,
          password: widget.passwordController.text);

      if (context.mounted) {
        setState(() {
          isLoading = false;
        });

        QuickAlert.show(
            title: "Account erstellt",
            context: context,
            type: QuickAlertType.success,
            onConfirmBtnTap: () {
              context.go('/navigation');
            });
      }
    } on FirebaseAuthException catch (e) {
      widget.onLoginError(e.code);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      widget.onLoginError("Unbekannter Fehler aufgetreten");

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 60,
      padding: const EdgeInsets.only(top: 20),
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : _onSubmit,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xff4caf50)),
            foregroundColor: MaterialStateProperty.all(Colors.white)),
        icon: isLoading
            ? Container(
                width: 24,
                height: 24,
                padding: const EdgeInsets.all(2.0),
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
            : const Icon(Icons.person_add),
        label: const Text('Registrieren'),
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

class LoginText extends StatelessWidget {
  const LoginText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Schon ein Account? ",
              style: TextStyle(color: Colors.white)),
          GestureDetector(
            onTap: () {
              context.go('/');
            },
            child: const Text("Zur Anmeldung",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
