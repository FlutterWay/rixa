import 'package:flutter/material.dart';
import 'package:rixa/rixa.dart';
import 'pages/app_design/error_screen.dart';
import 'pages/widgets.dart';
import '/pages/login_page.dart';
import '/pages/page1.dart';
import '/pages/page2.dart';
import '/pages/settings.dart';
import 'pages/app_design/page_control_panel.dart';

late AppColors appColors;
late AppFonts appFonts;
late AppSettings appSettings;
late PageManager pageManager;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Rixa.setup(
    pages: AppPages(
      pages: [
        RixaPage(name: "page1", page: () => const Page1(), route: "/page1"),
        RixaPage(
            name: "page2",
            page: () => const Page2(),
            route: "/page2",
            children: [
              ChildPage(
                  route: "/:userId",
                  name: "user",
                  children: [ChildPage(route: "/:players", name: "player")])
            ]),
        RixaPage(
            name: "settings", page: () => const Settings(), route: "/settings"),
        RixaPage(name: "login", page: () => const LoginPage(), route: "/login"),
        RixaPage(
            name: "widgets",
            page: () => const Widgets(),
            route: "/widgets",
            redirectFrom: ["/"]),
      ],
      initPage: "widgets",
      errorPage: const ErrorPage(),
    ),
    languages: AppLanguages(
      languages: ["English", "Turkish"],
      initLanguge: "English",
    ),
    appearances: AppAppearances(
      appearances: [
        Appearance.dark(),
        Appearance.light(),
      ],
      initAppearance: Appearance.dark(),
    ),
  );
  appColors = Rixa.appColors;
  appFonts = Rixa.appFonts;
  appSettings = Rixa.appSettings;
  pageManager = Rixa.pageManager;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RixaMaterial(
      pageControlPanel: PageControlPanel(),
    );
  }
}
