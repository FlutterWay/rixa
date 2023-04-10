<p align="center">
<img src="https://raw.githubusercontent.com/FlutterWay/files/main/rixa_poster.png"> 
<img src="https://raw.githubusercontent.com/FlutterWay/files/main/rixa-tanitim.gif"> 
</p>

- [About Rixa](#about-rixa)
- [Features](#features)
- [Installing](#installing)
- [Basic Setup](#basic-setup)
- [Page Management](#page-management)
  - [Window Title for Web development](#window-title-for-web-development)
  - [NestedPage](#nestedpage)
    - [Architecture](#architecture)
    - [MyNestedPage](#mynestedpage)
  - [Page Transition](#page-transition)
  - [Common Issue Fixed - GoRouter Issues Fixed](#common-issue-fixed---gorouter-issues-fixed)
    - [ShellRoute](#shellroute)
    - [Common Issue Fixed - Back Button Problem on Mobile App](#common-issue-fixed---back-button-problem-on-mobile-app)
  - [Navigation Methods](#navigation-methods)
    - [go](#go)
    - [goName](#goname)
    - [push](#push)
    - [pushNamed](#pushnamed)
    - [pushReplacement](#pushreplacement)
    - [pushReplacementNamed](#pushreplacementnamed)
    - [goToPreviousPage](#gotopreviouspage)
    - [pop](#pop)
    - [canPop](#canpop)
  - [AppFonts](#appfonts)
    - [Pre-defined Fonts](#pre-defined-fonts)
    - [Pre-defined Text Styles](#pre-defined-text-styles)
    - [Pre-defined Icon Sizes](#pre-defined-icon-sizes)
    - [Specify font sizes for the page](#specify-font-sizes-for-the-page)
      - [Defining different font sizes in RixaPage](#defining-different-font-sizes-in-rixapage)
      - [Fetch these changes](#fetch-these-changes)
    - [Customizing Default Fonts](#customizing-default-fonts)
- [AppColors](#appcolors)
  - [Set Appearances](#set-appearances)
  - [Variables of Appearance Class](#variables-of-appearance-class)
- [AppSettings](#appsettings)
  - [Internet Connection Checker](#internet-connection-checker)
- [Languages](#languages)
  - [RixaText](#rixatext)
      - [Warning: Parameters of RixaText\&RixaList must be in same order with AppLanguages](#warning-parameters-of-rixatextrixalist-must-be-in-same-order-with-applanguages)
    - [RixaText can be used inside text widget](#rixatext-can-be-used-inside-text-widget)
    - [RixaList](#rixalist)
- [Responsive Design](#responsive-design)
  - [How to Fetch RixaProperties](#how-to-fetch-rixaproperties)
    - [How to Fetch Screen Modes](#how-to-fetch-screen-modes)
    - [Other Features](#other-features)
  - [Example Design](#example-design)
- [Customizable Features](#customizable-features)
- [Some Of Useful Rixa Features](#some-of-useful-rixa-features)
    - [openDialog - Open Alert Dialog](#opendialog---open-alert-dialog)
    - [pickFile - Pick a File](#pickfile---pick-a-file)
    - [cropImage - Crop an Image File](#cropimage---crop-an-image-file)
    - [Emoji Gif Picker](#emoji-gif-picker)
- [Widgets, Functions, Extensions](#widgets-functions-extensions)
  - [To Contribute](#to-contribute)
  
# About Rixa

Rixa is the easiest and simplest way to design your application.<br/> Creating the application skeleton could be tough and time taking. It can cause unnecessary time waste and struggle. After completing the simple steps below, you can use this skeleton we've prepared for yo. Work on a single project to create your multi-platform app instead of separating your project for any specific platform. We have also prepared a lot of widgets that will come handy and make your job way easier.

To learn more about Rixa and many more, please visit the [FlutterWay web site](https://www.flutterway.net/)

# Features

Very simple page/route system to understand.<br/>
Writing the same textstyle again and again could become a boring task, you will have an access to your own textstyle. They can be customised for each page if you want <br/>
You will be able to access these features easily from anywhere in the application.<br/>  
- Page/Route management (Based on GoRouter but fixed common issues developers experience)
- Manage fonts of your pages
- Simple & Effective Navigation
- Text styles and Icon sizes adjusted(static/dynamic) according to screen sizes
- Manage appearances&languages of your application(language and appearance information is held in cache memory. you do not need to make any special settings for this).
- Adjustable custom settings 
- Language supported text and list of text
- Run your own function on change of internet connection status
- Also you can define spesific textstyle, icon size, word/sentence, color
- Reach App size, width, height and the other variables anywhere on your project
- All given features are customizable to your own liking(textstyles,iconsize,colors..)

Pre-defined TextStyle types(from small to big):
- small1, small2, small3, small4, small5, small6, small7, small8, small9
- medium1, medium2, medium3, medium4, medium5, medium6, medium7, medium8, medium9
- large1, large2, large3, large4, large5, large6, large7, large8, large9
- mega1, mega2, mega3, mega4, mega5, mega6, mega7, mega8, mega9

Appearance contains these variables:
- Background Color
- Text Color
- Hint Color
- Button Color
- Button Text Color
- Secondary Background Color
- Secondary Text Color
- Secondary Hint Color
- Secondary Button Color
- Secondary Button Text Color
- AppBar Background Color
- AppBar Text Color
- AppBar Hint Color
- AppBar Button Color
- AppBar Button Text Color
- Drawer Background Color
- Drawer Text Color
- Drawer Hint Color
- Drawer Button Color
- Drawer Button Text Color
- Dialog Background Color
- Dialog Text Color
- Dialog Hint Color
- Dialog Button Color
- Dialog Button Text Color

Pre-defined Settings

- Languages
- Device Type(Desktop-Mobile)
- Internet connection status


# Installing

Add the library as a dependency to your project.
```yaml
dependencies:
 rixa: ^latest
```

Then run `flutter packages get`

# Basic Setup
Run Rixa.setup() in main function. 

```dart
void main() {
  Rixa.setup(
      pages: appPages, languages: languages, appearances: appearances);
}
```
To be able to display the changes on your page wrap your widgets with RixaBuilder

```dart
  @override
  Widget build(BuildContext context) {
    return RixaBuilder(builder: (properties, fonts) {
      return child;
    });
  }
```
That's it! You can fetch your defined fonts and rest of the rixa `properties` anywhere on your project!

# Page Management

Rixa uses `go_router` for its route management on the background.

- Define your pages

```dart
  AppPages appPages = AppPages(
      pages: [
        RixaPage(
            name: "page1",
            fonts: PageFonts(text_small: 15),
            builder: (context, properties) => const Page1(),
            description: (properties) => "page1",
            route: "/page1"),
        RixaPage(
            name: "page2",
            fonts: PageFonts(text_small: 15),
            builder: (context, properties) => const Page2(),
            description: (properties) => "page2",
            route: "/page2"),
        RixaPage(
            name: "login",
            builder: (context, properties) => const LoginPage(),
            description: (properties) => "login",
            redirect: (properties) => isUserSignedIn?"/":null,
            route: "/login"),
        RixaPage(
          name: "home",
          route: "/",
        )
      ],
      initialRoute: "/",
    );
```
- And put that inside setup function or set for PageState

```dart
  Rixa.setup(pages: appPages);
```
```dart
  Rixa.setAppPages(appPages);
```

- Full view
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Rixa.setup(
    pages: AppPages(
      pages: [
        RixaPage(
            name: "page1",
            fonts: PageFonts(text_small: 15),
            builder: (context, properties) => const Page1(),
            description: (properties) => "page1",
            route: "/page1"),
        RixaPage(
            name: "page2",
            fonts: PageFonts(text_small: 15),
            builder: (context, properties) => const Page2(),
            description: (properties) => "page2",
            route: "/page2"),
        RixaPage(
            name: "login",
            builder: (context, properties) => const LoginPage(),
            description: (properties) => "login",
            redirect: (properties) => isUserSignedIn?"/":null,
            route: "/login"),
        RixaPage(
          name: "home",
          route: "/",
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

  runApp(const MyApp());
}

```

## Window Title for Web development
Set the description parameter to change the page-specific window title. 

<img src="https://raw.githubusercontent.com/FlutterWay/files/main/rixa-window-title.gif"> 

```dart
  AppPages appPages = AppPages(
      pages: [
        RixaPage(
            name: "page1",
            fonts: PageFonts(text_small: 15),
            builder: (context, properties) => const Page1(),
            description: (properties) => "page1",
            route: "/page1"),
        RixaPage(
            name: "page2",
            fonts: PageFonts(text_small: 15),
            builder: (context, properties) => const Page2(),
            description: (properties) => "page2",
            route: "/page2"),
        RixaPage(
            name: "login",
            builder: (context, properties) => const LoginPage(),
            description: (properties) => "login",
            redirect: (properties) => isUserSignedIn?"/":null,
            route: "/login"),
        RixaPage(
          name: "home",
          route: "/",
        )
      ],
      initialRoute: "/",
    );
```

## NestedPage
If there is a common(stationary widgets) area used by a certain group of pages, you can make use of NestedPage<br><br/>
Note: Rixa does not use go_router's ShellRoute for the Nested Page structure. ShellRoute has the problem of not being visible when pushed from outside. Therefore, rixa uses its own structure for NestedPage.<br><br/> 
for more information: [#111842](https://github.com/flutter/flutter/issues/111842)

### Architecture
```dart
  AppPages appPages = AppPages(
      pages: [
        NestedPage(
            fonts: PageFonts(text_small: 10),
            builder: (context, properties, child) => MyNestedPage(child: child),
            children: [
              RixaPage(
                  name: "page1",
                  fonts: PageFonts(text_small: 15),
                  builder: (context, properties) => const Page1(),
                  description: (properties) => "page1",
                  route: "/page1"),
              RixaPage(
                  name: "page2",
                  fonts: PageFonts(text_small: 15),
                  builder: (context, properties) => const Page2(),
                  description: (properties) => "page2",
                  route: "/page2"),
              RixaPage(
                  name: "login",
                  builder: (context, properties) => const LoginPage(),
                  description: (properties) => "login",
                  redirect: (properties) => isUserSignedIn ? "/" : null,
                  route: "/login"),
              RixaPage(
                name: "home",
                route: "/",
              ),
            ])
      ],
      initialRoute: "/",
    );
```

### MyNestedPage

```dart
 class MyNestedPage extends StatefulWidget {
  final Widget child;
  const MyNestedPage({Key? key, required this.child}) : super(key: key);

  @override
  State<MyNestedPage> createState() => _MyNestedPageState();
}

class _MyNestedPageState extends State<MyNestedPage> {
  @override
  Widget build(BuildContext context) {
    return RixaBuilder(builder: (properties, fonts) {
      return Scaffold(
          backgroundColor: appColors.backgroundColor,
          appBar: const MyAppbar(),
          drawer: Rixa.properties.anyMobile ? MyDrawer() : null,
          body: Row(
            children: [
              if (!Rixa.properties.anyMobile)
                SizedBox(
                  height: double.infinity,
                  width: Rixa.properties.screenMode == ScreenMode.desktopLarge
                      ? 200
                      : 70,
                  child: LeftMenu(),
                ),
              Expanded(
                child: widget.child,
              ),
            ],
          ));
    });
  }
}
```
## Page Transition

Rixa allows you to customize the transition animation for each RixaPage. To configure a custom transition animation, provide a pageTransition parameter to the RixaPage constructor.

```dart
RixaPage(
  name: "page1",
  route: "/page1",
  builder: (context, properties) => const Page1(),
  description: (properties) => "page1",
  pageTransition: PageTransition(
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder:
        (context, animation, secondaryAnimation, child) =>
            FadeTransition(
      opacity: CurveTween(curve: Curves.easeInOutCirc)
          .animate(animation),
      child: child,
    ),
  ),
),
```
For a complete example, see the [transition animations sample](https://github.com/FlutterWay/rixa/tree/main/example/lib/transition_animations_sample).

For more information on animations in Flutter, visit the [Animations](https://docs.flutter.dev/development/ui/animations) page on flutter.dev.

## Common Issue Fixed - GoRouter Issues Fixed

### ShellRoute

Rixa does not use go_router's ShellRoute for the Nested Page structure. ShellRoute has the problem of not being visible when pushed from outside. Therefore, rixa uses its own structure for NestedPage.<br><br/>
for more information: [#111842](https://github.com/flutter/flutter/issues/111842)

### Common Issue Fixed - Back Button Problem on Mobile App

If you run your application on a platform other than the web and use context.go(), Android&Ios back button or Navigator.pop() will not functions as wanted and go to the previous page. You can use goToPreviousPage instead of Navigator.pop(). If you are using go() or goNamed() for navigation, add onWillPop to your scaffold then add this function. 

[Check the codes](#gotopreviouspage)

## Navigation Methods

You have several ways to switch between pages
- Data transfer between pages 
- You can run your own dispose function before go()
- The push function puts the pushed page at the top of the page stack. You can specify the function that will run if you return from the pushed page

for more information: [Flutter Navigation with GoRouter: Go vs Push](https://codewithandrea.com/articles/flutter-navigation-gorouter-go-vs-push/)  


### go

-via PageState:
```dart
   Rixa.pageManager.go(
    route: "/page1",
    context: context,
    quickDispose: () {
      disposeFunction();
    });
```

-via BuildContext:
```dart
   context.go(route: route); //Provide the defined name of the target page
```

### goName

-via PageState:
```dart
   Rixa.pageManager.goNamed(name: "page1"); //Provide the defined name of the target page
```

-via BuildContext:
```dart
   context.goNamed(name: "page1"); //Provide the defined name of the target page
```

### push

-via PageState:
```dart
   Rixa.pageManager.push(route: "/page1",context:context); //Provide the defined name of the target page
```

-via BuildContext:
```dart
  context.push(
    route: "/page1",
    onPop: () {
      print("RETURNED TO LOGIN PAGE");
      setState(() {});
  }); //Provide the defined name of the target page
```

### pushNamed

-via PageState:
```dart
   Rixa.pageManager.pushNamed(name: "page1",context:context); //Provide the defined name of the target page
```

-via BuildContext:
```dart
  context.pushNamed(name: "page1"); //Provide the defined name of the target page
```

### pushReplacement

-via PageState:
```dart
   Rixa.pageManager.pushReplacement(route: "/page1",context:context); //Provide the defined name of the target page
```

-via BuildContext:
```dart
  context.pushReplacement(route: "/page1"); //Provide the defined name of the target page
```

### pushReplacementNamed

-via PageState:
```dart
   Rixa.pageManager.pushReplacementNamed(name: "page1",context:context); //Provide the defined name of the target page
```

-via BuildContext:
```dart
  context.pushReplacementNamed(name: "page1"); //Provide the defined name of the target page
```

### goToPreviousPage

If you run your application on a platform other than the web and use context.go(), Navigator.pop() will not go to the previous page. You can use goToPreviousPage instead of Navigator.pop(). If you are using go() or goNamed() for navigation, add onWillPop to your scaffold and add this function. 

```dart
   WillPopScope(
      onWillPop: () async {
        return (await context.goToPreviousPage());
      },
      child: Scaffold(
```

-via PageState:
```dart
   Rixa.pageManager.goToPreviousPage(context:context); 
```

-via BuildContext:
```dart
  context.goToPreviousPage(); 
```

### pop

Pop the top-most route off the current screen.

-via PageState:
```dart
   Rixa.pageManager.pop(context:context); 
```

-via BuildContext:
```dart
  context.pop(); 
```

### canPop

```dart
  Rixa.pageManager.canPop(context:context); 
  context.canPop(); 
```

## AppFonts

By default fonts sizes are static unless your screen mode is ScreenMode.Mobile. To change this pre-defined setting, you can change the staticFonts parameter to true or false.

```dart
void main() {
  Rixa.setup(
      pages: appPages, languages: languages, appearances: appearances, staticFonts:true);
}
```

### Pre-defined Fonts

### Pre-defined Text Styles

small textstyles: small1, small2, small3, small4, small5, small6, small7, small8, small9
medium textstyles: medium1, medium2, medium3, medium4, medium5, medium6, medium7, medium8, medium9
large textstyles: large1, large2, large3, large4, large5, large6, large7, large8, large9
mega textstyles: mega1, mega2, mega3, mega4, mega5, mega6, mega7, mega8, mega9 <br></br>
xS()=>small3, S()=>small5, M()=>medium5, L()=>large5 
xL()=>large7, mega()=>mega5, giga()=>mega7 

### Pre-defined Icon Sizes

small icon sizes: icon_small1, icon_small2, icon_small3, icon_small4, icon_small5, icon_small6, icon_small7, icon_small8, icon_small9
medium icon sizes: icon_medium1, icon_medium2, icon_medium3, icon_medium4, icon_medium5, icon_medium6, icon_medium7, icon_medium8, icon_medium9
large icon sizes: icon_large1, icon_large2, icon_large3, icon_large4, icon_large5, icon_large6, icon_large7, icon_large8, icon_large9
mega icon sizes: icon_mega1, icon_mega2, icon_mega3, icon_mega4, icon_mega5, icon_mega6, icon_mega7, icon_mega8, icon_mega9 <br></br>
icon_xS()=>small3, icon_S()=>small5, icon_M()=>medium5, icon_L()=>large5 
icon_xL()=>large7, icon_mega()=>mega5, icon_giga()=>mega7 

TextStyle parameters = color, isBold, fontFamily, pageName, fontWeight, isStatic. These parameters have their own default values so you dont have to define them.<br></br>
By default, Rixa supports `Google Fonts`. You can simply use them by calling font family name from parameter named `fontFamily`.

```dart
    Text(
      "Hello",
      style: Rixa.appFonts.large2(
      isBold: true,
      fontFamily:"Lato",
      pageName: "home",
      color: Rixa.appColors.textColor,
      fontWeight: FontWeight.normal),
        ),
```
Static and dynamic textstyle could be chosen for specific cases of your project<br/>
- Fetching TextStyle
```dart
    Text(
       "Hello",
       style: Rixa.appFonts.large3(isStatic: true),
    )
```
### Specify font sizes for the page
You can change the font sizes specifically depended on pages. There are two ways to fetch these changes

#### Defining different font sizes in RixaPage
```dart
PageFonts(
       text_small: 15,
       text_medium: 30,
       text_large: 50,
       text_mega: 70
     )
```
#### Fetch these changes
via RixaBuilder
```dart
@override
Widget build(BuildContext context) {
  return RixaBuilder(
      name: "page1",
      builder: (properties, fonts) {
        return Text(
          "Rixa",
          style: fonts.medium3(),
        );
      });
}
```
via AppFonts
```dart
Text(
  "Rixa",
  style: Rixa.appFonts.medium3(pageName: "page1"),
)
```

### Customizing Default Fonts
- If you are working with dynamic textstyle, these textstyle sizes are determined by the multiplication of  pre-determined rates and total size of application

```
  Ratios : {
    "small": 0.013,
    "medium": 0.026,
    "large": 0.039,
    "mega": 0.052
  }
  IconRatios : {
    "small": 0.015,
    "medium": 0.03,
    "large": 0.045,
    "mega": 0.06
  }
```
These ratios could be changed with ratio parameter:
```dart
   Rixa.appFonts.changeStaticSizeRatio(name:"medium", ratio:0.022);
```
- Default value of each static size are given below:
```
  Sizes : {
    "small": 20,
    "medium": 40,
    "large": 60,
    "mega": 80,
  }
  IconSizes : {
    "small": 30,
    "medium": 60,
    "large": 90,
    "mega": 120,
  }
```

These default values could be changed with code given below:

```dart
   Rixa.appFonts.changeStaticSize(name:"large", size:20);
```

# AppColors

AppColors contains the color types of your application. Application's appearances have to be defined to be able to use that. 

## Set Appearances

-Define your appearances

```dart
  AppAppearances appearances = AppAppearances(appearances: [
    Appearance.dark(),
    Appearance.light(),
  ], initAppearance: Appearance.dark());
```

-And put that inside setup function or set your app's appearances through setAppAppearances function inside Rixa

```dart
  Rixa.setup(appearances: appearances);
```
```dart
  Rixa.setAppAppearances(appearances);
```
## Variables of Appearance Class

- backgroundColor
- textColor
- hintColor
- btnColor
- btnTextColor
- iconColor
- secondaryBackgroundColor
- secondaryTextColor
- secondaryHintColor
- secondaryBtnColor
- secondaryBtnTextColor
- secondaryIconColor
- appBarBackgroundColor
- appBarTextColor
- appBarHintColor
- appBarBtnColor
- appBarBtnTextColor
- appBarIconColor
- drawerBackgroundColor
- drawerTextColor
- drawerHintColor
- drawerBtnColor
- drawerBtnTextColor
- drawerIconColor
- dialogBackgroundColor
- dialogTextColor
- dialogHintColor
- dialogBtnColor
- dialogBtnTextColor
- dialogIconColor

Applications usually requires at least two background colors to fill the entire page. Some apps might have left menus and in such cases it would be wise to use secondary background color. <br/>

-An example below was given for app with left menus :

```dart
Row(
  children: [
    Expanded(
      child: Container(
        width: 400,
        height: double.infinity,
        color: Rixa.appColors.secondaryBackgroundColor,
        child: LeftMenu(),
      ),
    ),
    Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Rixa.appColors.backgroundColor,
        child: child,
      ),
    )
  ],
)
```
-This would mean two text colors are required to design the app. Those variables are called textColor and secondaryTextColor

# AppSettings

AppSettings is the control mechanism of your app. Whenever something gets updated in AppColors and AppFonts, this will trigger AppSettings. Which means AppColors and AppFonts dont need to be listened

AppSettings contains:
- Languages
- Device Type(Desktop-Mobile)
- Internet connection status
- Run your own function on change of internet connection status
  
## Internet Connection Checker

- Run your own function on change of internet connection status:
```dart
  Rixa.appSettings.onConnectionChange=(status) {
    print("Connection status has changed");
  };
```
# Languages
Languages of the app need to be defined to be able to use "App Language" option.

```dart
  AppLanguages languages =
      AppLanguages(languages: ["English,Turkish"], initLanguge: "English");
  Rixa.setup(languages: languages);
```
## RixaText

Managing the multi language development can be done with ease with the utilization of smartText widget.
- Make sure to define the languages of your app
- RixaText can be used to create single string translations
- RixaList can be used to create a list of translations for multiple strings <br/>

#### Warning: Parameters of RixaText&RixaList must be in same order with AppLanguages

### RixaText can be used inside text widget
```dart
Text(
  RixaText(["Page", "Sayfa"]).text,
  style: appFonts.giga(),
)
```
### RixaList

```dart
Text(
  RixaText(["Page", "Sayfa"]).text,
  style: appFonts.giga(),
)
for (var language in RixaList([
  ["Page1", "Page2", "Page3"],
  ["Seite1", "Seite2", "Seite3"]
]).texts)
  Text(language)
```
-A class that includes common words of an application can be designed the way it was shown in the example given below

```dart
class AppTexts {
  static String get ok => RixaText(["ok", "tamam"]).text;
  static String get hello => RixaText(["Hello", "Merhaba"]).text;
  static String get lang => RixaText(["Language", "Dil"]).text;
  static String get page => RixaText(["Page", "Sayfa"]).text;
  static String get login => RixaText(["Login", "Giriş"]).text;
  static String get appbar_title =>
      RixaText(["Rixa App Design", "Akıllı Uygulama Tasarımı"]).text;
  static String get settings => RixaText(["Settings", "Ayarlar"]).text;
  static String get signout => RixaText(["Signout", "Çıkış"]).text;
  static String get darkMode => RixaText(["Dark Mode", "Karanlık Mod"]).text;
  static String get btnText => RixaText([
        "You have pushed the button this many times",
        "Düğmeye bukadar çok bastın",
      ]).text;
  static List<String> get languages => RixaList([
        ["English", "Turkish"],
        ["İngilizce", "Türkçe"]
      ]).text;
  static List<String> get menus => RixaList([
        ["Page 1", "Page 2", "Settings", "Signout"],
        ["Sayfa 1", "Sayfa 2", "Ayarlar", "Çıkış"]
      ]).text;
}
```

-And it can be used as presented below:

```dart
Text(
  AppTexts.hello,
  style: appFonts.giga(),
)
```


# Responsive Design
If you want to make the design of your application responsive, you should make a special design for 2 to 4 modes. These modes are Mobile mode, Landscaped Mobile mode, Desktop Mini, Desktop Large. You may also want to make designs according to the screen sizes. That's what RixaProperties is for

## How to Fetch RixaProperties
via RixaBuilder
```dart
@override
Widget build(BuildContext context) {
  return RixaBuilder(
      name: "page1",
      builder: (properties, fonts) {
        return Text(
          properties.isMobile?"Rixa-Mobile":"Rixa-Desktop",
          style: fonts.medium3(),
        );
      });
}
```
via Rixa
```dart
Text(
  Rixa.properties.isMobile?"Rixa-Mobile":"Rixa-Desktop",
  style: Rixa.appFonts.medium3(pageName: "page1"),
)
```
### How to Fetch Screen Modes
```dart
Text(
  Rixa.properties.screenMode==ScreenMode.desktopLarge ? "Rixa-DesktopLarge" : "Rixa",
  style: Rixa.appFonts.medium3(pageName: "page1"),
)
```
### Other Features
- isMobile: The platform can be checked if it's phone
- isDesktop: The platform can be checked if it's desktop
- isWeb: The platform can be checked if it's web
- screenMode.mobile: Size of desktop app can be checked if it's downsized to mobileMode
- screenMode.landScape: Landscape mode can be checked with
- screenMode.desktopMini: Size of desktop app can be checked if it's between desktop large and landscape mode
- screenMode.desktopLarge: Size of desktop app can be checked if it's large mode
- anyMobile: if the app is multiplatform, the size of app can be checked if it's in mobile sizes (this will return true either the platform is mobile or the sizes are in pre-determined mobile sizes)
- language: Current language of application
- status: Current internet connection status of application
- appWidth: Screen width of application
- appHeight: Screen height of application
- route: Current route of application

## Example Design

```dart
  @override
  Widget build(BuildContext context) {
    return RixaBuilder(builder: (properties, fonts) {
      return Scaffold(
          backgroundColor: Rixa.appColors.backgroundColor,
          appBar: const MyAppbar(),
          drawer: properties.anyMobile ? MyDrawer() : null,
          body: Row(
            children: [
              if (!properties.anyMobile)
                SizedBox(
                  height: double.infinity,
                  width: properties.screenMode == ScreenMode.desktopLarge
                      ? properties.appWidth * 0.3
                      : properties.appWidth * 0.2,
                  child: LeftMenu(),
                ),
              Expanded(
                child: widget.child,
              ),
            ],
          ));
    });
  }
```


# Customizable Features

- Custom AppFonts
```dart
   double size=20;
   String name="middle";
   Rixa.appFonts.addSpecificSize(name:name,size:size);
   // Then get your specific textstyle and size
   double size=Rixa.appFonts.specificSize("middle");
   TextStyle specific=Rixa.appFonts.specific(specificType:"middle");
```
- Custom AppSettings
```dart
    bool variable = false;
    Rixa.appSettings.addSpecificVariable(variable: variable, name: "leftMenuOpened");
    Rixa.appSettings.addSpecificSetting(
        function: () {
          Rixa.appSettings.specificVariables["leftMenuOpened"] =
              !Rixa.appSettings.specificVariables["leftMenuOpened"];
        },
        name: "changeLeftMenuStatus");
```

# Some Of Useful Rixa Features

### openDialog - Open Alert Dialog

```dart
  Rixa.openDialog(child: MyDialogView(), context: context)
```
### pickFile - Pick a File

```dart
  List<PlatformFile>? files=await Rixa.pickFile();
```
### cropImage - Crop an Image File

```dart
  Rixa.cropImage(context: context, mainImage: imageData);
```
### Emoji Gif Picker

[![pub package](https://img.shields.io/pub/v/flutter_emoji_gif_picker.svg?label=flutter_emoji_gif_picker&color=blue)](https://pub.dev/packages/flutter_emoji_gif_picker)

flutter_emoji_gif_picker is found auto-installed in rixa. You dont need to EmojiGifPickerPanel.setup() in the main function. If you still want to change the design of the emoji gif picker, you will see the emojiGifPickerConfig parameter in the Rixa.setup function. [Learn how to use it](https://www.flutterway.net/our-packages/pick-a-single-package/emoji-gif-picker)

# Widgets, Functions, Extensions

You can find a list of all widgets, functions, extensions of Rixa!

<img width=800 src="https://raw.githubusercontent.com/worldwidee/files/main/widgets.gif"> 

[Checkout the details of all widgets](https://rixa/widgets)

| Widgets            |    Functions    |          Extensions           |
| ------------------ | :-------------: | :---------------------------: |
| CheckBox           |    cropImage    |        inCaps(String)         |
| CheckBoxList       | Rixa.openDialog |       allInCaps(String)       |
| ChildExpanded      |  Rixa.pickFile  |       allInCaps(String)       |
| CropImage          |                 | capitalizeFirstofEach(String) |
| DownloadButton     |                 |     capitalize()(String)      |
| DropDown           |                 |    go(route)(BuildContext)    |
| ExpandedContainer  |                 |  goNamed(name)(BuildContext)  |
| ExpandedLine       |                 |                               |
| ExpandedText       |                 |                               |
| ExpandedWidget     |                 |                               |
| ExpandedButton     |                 |                               |
| FileIcon           |                 |                               |
| FileType           |                 |                               |
| GlassMorphism      |                 |                               |
| IconOfFile         |                 |                               |
| ImageAvatar        |                 |                               |
| InfContainer       |                 |                               |
| InfiniteText       |                 |                               |
| LineChart          |                 |                               |
| LiquidLoadingBar   |                 |                               |
| MiddleOfExpanded   |                 |                               |
| OnHover            |                 |                               |
| PasswordField      |                 |                               |
| ProfileAvatar      |                 |                               |
| RadioButtonList    |                 |                               |
| RegionBar          |                 |                               |
| SizedButton        |                 |                               |
| RixaTextField      |                 |                               |
| RixaTextFieldFull  |                 |                               |
| ChatTextField      |                 |                               |
| ExpandedTextButton |                 |                               |
| SmartPlayer        |                 |                               |
| VideoPlayerMobile  |                 |                               |
| VideoPlayerDesktop |                 |                               |
| MarkdownWidget     |                 |                               |

## To Contribute
* If you **found a bug** or **have a feature request**, open an issue.
* If you **want to contribute**, submit a pull request.











