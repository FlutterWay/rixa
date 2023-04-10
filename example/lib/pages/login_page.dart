import 'package:flutter/material.dart';
import '../texts/app_text.dart';
import 'package:rixa/rixa.dart';
import '/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double iconW = appFonts.appWidth * 0.3;
    double iconH = appFonts.appHeight * 0.07;
    return RixaBuilder(builder: (properties, fonts) {
      return Scaffold(
        backgroundColor: appColors.backgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${AppTexts.login} ${AppTexts.page}",
                style: appFonts.large5(),
              ),
              SizedBox(
                height: appFonts.appHeight * 0.01,
              ),
              TextButton(
                  onPressed: () async {
                    context.go(
                      route: "/page1",
                    );
                  },
                  child: Container(
                    width: iconW,
                    height: iconH,
                    decoration: BoxDecoration(
                        color: appColors.btnColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.login,
                          size: appFonts.icon_medium5(),
                          color: appColors.btnTextColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          AppTexts.login,
                          style: appFonts.small5(color: appColors.btnTextColor),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      );
    });
  }
}
