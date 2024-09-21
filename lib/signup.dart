import 'dart:io';

import 'package:flutter/material.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  @override @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      showSheet(context, const Sheet());
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/cover.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  showSheet(context, const Sheet());
                },
                child: const Text(
                  "Clique moi dessus !",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
            )
          ],
        ),
      )
    );
  }
}

void showSheet(BuildContext context, Widget widget)
{
  const double radius = 40;

  showModalBottomSheet(
    context: context,
    clipBehavior: Clip.hardEdge,
    shape: const RoundedRectangleBorder(
      side: BorderSide(
        color: Colors.transparent
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      )
    ),
    sheetAnimationStyle: AnimationStyle(
      duration: const Duration(milliseconds: 200),
    ),
    isScrollControlled: true,
    builder: (context) {
      return widget;
    }
  );
}

class Sheet extends StatefulWidget {
  const Sheet({super.key});

  @override
  State<Sheet> createState() => _SheetState();
}

class _SheetState extends State<Sheet> {

  Widget currentSheet = Container();

  void changeSheet(Widget newSheet) {
    setState(() {
      currentSheet = newSheet;
    });
  }

  @override
  void initState() {
    super.initState();
    currentSheet = WelcomeSheet(changeSheet: (newSheet) {
      changeSheet(newSheet);
    });
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Duration(milliseconds: 100),
      curve: Curves.easeIn,
      child: currentSheet
    );
  }
}

class WelcomeSheet extends StatelessWidget {
  const WelcomeSheet({
    super.key,
    required this.changeSheet
  });

  final double fontSize = 32;
  final double spacing = 10;
  final Function changeSheet;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 325,
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: spacing),
            Text(
              "Find local \ncommunity events",
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: spacing),
            Text(
              "Get involved with what's happening near you",
              style: TextStyle(
                fontSize: fontSize - 8,
                color: Colors.grey
              ),
            ),
            Expanded(
              child: Container(),
            ),
            GradientButton(
              text: "Get started",
              onTap: () {
                changeSheet(const SignUpSheet());
              },
            ),
            SizedBox(height: spacing * 2),
          ],
        ),
      ),
    );
  }
}

class SignUpSheet extends StatefulWidget {
  const SignUpSheet({
    super.key,
  });

  @override
  State<SignUpSheet> createState() => _SignUpSheetState();
}

class _SignUpSheetState extends State<SignUpSheet> {
  final double fontSize = 32;

  final double spacing = 10;

  Color textFieldColor = Colors.grey.shade400;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? validateEmail(String? value) {

    if(value == null || value.isEmpty) {
      return "Please enter an email address";
    }

    if(!value.contains("@"))
    {
      return "Please enter a valid email address";
    }

    return null;
  }


  String? validatePassword(String? value) {

    if(value == null || value.isEmpty) {
      return "Please enter a password";
    }

    return null;
  }

  void onSave() {
    if(_formKey.currentState!.validate()) {
      print("Success");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: spacing),
              Text(
                "Create an account",
                style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: spacing * 2),
              TextFormField(
                textAlignVertical: TextAlignVertical.center,
                validator: validateEmail,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                      Icons.email,
                      color: textFieldColor
                  ),
                  hintStyle: TextStyle(
                    color: textFieldColor
                  ),
                  hintText: "Email address",
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: textFieldColor
                    )
                  )
                ),
              ),
              SizedBox(height: spacing * 2),
              TextFormField(
                obscureText: true,
                textAlignVertical: TextAlignVertical.center,
                validator: validatePassword,
                decoration: InputDecoration(
                    suffixIcon: Icon(
                        Icons.lock,
                        color: textFieldColor
                    ),
                    hintStyle: TextStyle(
                        color: textFieldColor
                    ),
                    hintText: "Password",
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: textFieldColor
                        )
                    )
                ),
              ),
              SizedBox(height: spacing * 6),
              GradientButton(
                  text: "Create account",
                  onTap: onSave
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Already have an account? Sign in",
                    style: TextStyle(
                        color: textFieldColor,
                        fontSize: 16
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.text,
    this.onTap,
  });


  final String text;
  final Gradient gradient = const LinearGradient(
    colors: [
      Color(0xFFffb56b),
      Color(0xFFfd9a67),
      Color(0xFFf77e69),
      Color(0xFFed646f),
      Color(0xFFdd4b77),
      Color(0xFFc83581),
      Color(0xFFad268a),
      Color(0xFF8b2192),
    ]
  );
  final double padding = 30;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            onTap!();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: padding / 2,
                horizontal: padding
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: gradient
            ),
            child: Row(
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 30,
                )
              ],
            )
          ),
        ),
      ],
    );
  }
}