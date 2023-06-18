import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zomato_clone/common/utils/colors.dart';
import 'package:zomato_clone/common/utils/utils.dart';
import 'package:zomato_clone/common/widgets/custom_button.dart';
import 'package:zomato_clone/common/widgets/progress_bar_with_text.dart';
import 'package:zomato_clone/features/home/screens/home_screen.dart';
import 'package:zomato_clone/features/loginandsignup/controller/login_signup_controller.dart';
import 'package:zomato_clone/features/loginandsignup/repository/login_signup_repository.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = "/login-screen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneEditingController = TextEditingController();
  var isSigning = false;

  void googleSignInOrSignUp() {
    setState(() {
      isSigning = true;
    });
    ref.read(loginSignUpControllerProvider).signInOrSignUpWithGoogle().then(
      (value) {
        if (value.first == null) {
          showSnackBar(context, value.second ?? "Some Error Occurred");
        } else {
          if (value.first?.second == true) {
            showSnackBar(context, "New User to be created");
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
          }
        }
        setState(() {
          isSigning = false;
        });
      },
    );
  }

  void emailSignInOrSignUp() {}

  void facebookSignInOrSignUp(BuildContext context) {
    setState(() {
      isSigning = true;
    });
    ref.read(loginSignUpControllerProvider).signInOrSignUpWithFacebook().then(
      (value) {
        Navigator.pop(context);
        if (value.first == null) {
          showSnackBar(context, value.second ?? "Some Error Occurred");
        } else {
          if (value.first?.second == true) {
            showSnackBar(context, "New User to be created");
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
          }
        }
        setState(() {
          isSigning = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.4,
                  child: Image.asset(
                    "assets/images/login_image_1.jpg",
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                  child: Text(
                    "India's #1 Food Delivery and Dining App",
                    style: GoogleFonts.ebGaramond(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 1,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: lightGrey,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Log in or sign up",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: grey),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: lightGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 25),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: midGrey, width: 1.0)),
                        child: SizedBox(
                          height: 50,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0)
                                  .copyWith(left: 10),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Image.asset(
                                    "assets/images/indian_flag_icon.png",
                                    height: 30,
                                  ),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    size: 25,
                                    color: midGrey,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 4.0)
                              .copyWith(left: 10),
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: midGrey, width: 1.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 8,
                              ),
                              const Text(
                                "+91",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: TextFormField(
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                                    controller: phoneEditingController,
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        isCollapsed: true,
                                        contentPadding: EdgeInsets.zero,
                                        hintText: "Enter Phone Number"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: CustomButton(text: "Continue", onPressed: () {}),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: lightGrey,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "or",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: grey),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: lightGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: googleSignInOrSignUp,
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(lightGrey),
                        shape: MaterialStateProperty.all(
                          const CircleBorder(),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Image.asset(
                          "assets/images/google_icon.png",
                          height: 25,
                          width: 25,
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(black),
                                      overlayColor:
                                          MaterialStateProperty.all(lightGrey),
                                      shape: MaterialStateProperty.all(
                                        const CircleBorder(),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Icon(
                                        Icons.close,
                                        color: white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    decoration: const BoxDecoration(
                                        borderRadius:
                                            BorderRadiusDirectional.only(
                                                topStart: Radius.circular(15),
                                                topEnd: Radius.circular(15)),
                                        color: white),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 40),
                                    child: Column(
                                      children: [
                                        OutlinedButton(
                                          onPressed: () =>
                                              facebookSignInOrSignUp(context),
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                  Icons.facebook,
                                                  color: blue,
                                                  size: 30,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Continue with Facebook",
                                                  style: TextStyle(
                                                      color: grey,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        OutlinedButton(
                                          onPressed: emailSignInOrSignUp,
                                          child: Container(
                                            padding: const EdgeInsets.all(15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                  Icons.email,
                                                  color: black,
                                                  size: 30,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Continue with Email",
                                                  style: TextStyle(
                                                      color: grey,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                            backgroundColor: transparent);
                      },
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(lightGrey),
                        shape: MaterialStateProperty.all(
                          const CircleBorder(),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.more_horiz_rounded,
                          size: 30,
                          color: black,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "By continuing, you agree to our\nTerms of Service, Privacy Policy, and Content Policy",
                    style: TextStyle(color: darkGrey),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            if (isSigning)
              const ProgressBarWithText(text: "Verifying Credentials")
          ],
        ));
  }
}
