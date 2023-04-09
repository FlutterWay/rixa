import 'package:flutter/material.dart';
import 'package:rixa/rixa.dart';
import 'package:rixa_example/pages/page2.dart';
import 'pages/widgets.dart';
import '/pages/login_page.dart';
import '/pages/page1.dart';
import '/pages/settings.dart';
import 'pages/app_design/page_control_panel.dart';

late AppColors appColors;
late AppFonts appFonts;
late AppSettings appSettings;
late PageManager pageManager;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Rixa.setup(
    pages: AppPages(
      pages: [
        NestedPage(
            fonts: PageFonts(text_small: 10),
            builder: (context, properties, child) => MyNestedPage(child: child),
            children: [
              RixaPage(
                  name: "page1",
                  builder: (context, properties) => const Page1(),
                  description: (properties) => "page1",
                  route: "/page1"),
              RixaPage(
                  name: "page2",
                  route: "/page2",
                  description: (properties) => "page2",
                  builder: (context, properties) => const Page2(),
                  children: [
                    NestedPage(
                        builder: (context, properties, child) =>
                            MyNestedPage(child: child),
                        children: [
                          RixaPage(
                              name: "page2nested",
                              description: (properties) => "page2nested",
                              builder: (context, properties) => const Page2(),
                              route: "/page2nested"),
                        ]),
                  ]),
              RixaPage(
                  name: "settings",
                  description: (properties) => "settings",
                  builder: (context, properties) => const Settings(),
                  route: "/settings"),
              RixaPage(
                  name: "widgets",
                  description: (properties) => "widgets",
                  builder: (context, properties) => const Widgets(),
                  route: "/widgets"),
            ]),
        RixaPage(
            name: "login",
            builder: (context, properties) => const LoginPage(),
            description: (properties) => "login",
            route: "/login"),
        RixaPage(
          name: "home",
          route: "/",
          description: (properties) => "home",
          redirect: (properties) => "/login",
        )
      ],
      initialRoute: "/login",
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
  pageManager = Rixa.pageManager;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RixaMaterial();
  }
}
