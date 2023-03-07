import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider/index.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeServiceProvider(
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeServiceProvider.of(context).currentThemeData,
          darkTheme: ThemeServiceProvider.of(context).currentThemeData,
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter(BuildContext context) {
    ThemeServiceProvider.of(context).changeThemeData(
        themeData: ThemeServiceProvider.of(context).currentThemeData ==
                ThemeServiceProvider.of(context).lightThemeData
            ? ThemeServiceProvider.of(context).darkThemeData
            : ThemeServiceProvider.of(context).lightThemeData);
  }

  final List<ThemeData> _lightThemes = List.generate(
    5,
    (index) {
      Color randomColor = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0);
      return ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: randomColor,
        ),
      );
    },
  );

  final List<ThemeData> _darkThemes = List.generate(
    5,
    (index) {
      Color randomColor = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0);
      return ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: randomColor,
        ),
      );
    },
  );
  var _selectedOption;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Divider(),
            const Text("Light themes"),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "${ThemeServiceProvider.of(context).lightThemeData.appBarTheme.backgroundColor}}"),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      height: 20,
                      width: 20,
                      color: ThemeServiceProvider.of(context)
                          .lightThemeData
                          .appBarTheme
                          .backgroundColor,
                    )
                  ],
                ),
              ],
            ),
            const Divider(),
            const Text("Dark themes"),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "${ThemeServiceProvider.of(context).darkThemeData.appBarTheme.backgroundColor}}"),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      height: 20,
                      width: 20,
                      color: ThemeServiceProvider.of(context)
                          .darkThemeData
                          .appBarTheme
                          .backgroundColor,
                    )
                  ],
                ),
              ],
            ),
            const Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.5,
              child: SingleChildScrollView(
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Select an option',
                        errorText: state.hasError ? state.errorText : null,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: _selectedOption,
                          onChanged: (value) {
                            setState(() {
                              _selectedOption = value;

                              // ThemeServiceProvider.of(context)
                              //     .rollBackThemeScope(
                              //   action: () {
                              //     ThemeServiceProvider.of(context)
                              //         .onChangeSystemTheme(
                              //       changeForDarkTheme:
                              //           _darkThemes.contains(value),
                              //       themeData: value as ThemeData,
                              //     );
                              //   },
                              //   confirmAction: () async {
                              //     showAlertDialog<bool>(BuildContext context) {
                              //       // set up the buttons
                              //       Widget cancelButton = TextButton(
                              //         child: const Text("Cancel"),
                              //         onPressed: () {
                              //           Navigator.of(context).pop(false);
                              //         },
                              //       );
                              //       Widget continueButton = TextButton(
                              //         child: const Text("Continue"),
                              //         onPressed: () {
                              //           Navigator.of(context).pop(true);
                              //         },
                              //       );

                              //       // set up the AlertDialog
                              //       AlertDialog alert = AlertDialog(
                              //         title: const Text("AlertDialog"),
                              //         content: const Text(
                              //             "Would you like to continue learning how to use Flutter alerts?"),
                              //         actions: [
                              //           cancelButton,
                              //           continueButton,
                              //         ],
                              //       );

                              //       // show the dialog
                              //       return showDialog<bool?>(
                              //         context: context,
                              //         builder: (BuildContext context) {
                              //           return alert;
                              //         },
                              //       );
                              //     }

                              //     bool? result = await showAlertDialog(context);

                              //     return result ?? false;
                              //   },
                              // );

                              /// ThemeServiceProvider.of(context).onChangeSystemThemeV2

                              ThemeServiceProvider.of(context)
                                  .onChangeSystemThemeV2(
                                lightThemeData: _lightThemes.contains(value)
                                    ? value as ThemeData
                                    : null,
                                darkThemeData: _darkThemes.contains(value)
                                    ? value as ThemeData
                                    : null,
                              );
                            });
                          },
                          items: [
                            "Light Theme",
                            ..._lightThemes,
                            "Dark Theme",
                            ..._darkThemes
                          ].map((value) {
                            if (value is String) {
                              return DropdownMenuItem(
                                value: value,
                                enabled: false,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(value),
                                      const Divider(),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return DropdownMenuItem(
                              value: value as ThemeData,
                              child: Row(
                                children: [
                                  Text("${value.appBarTheme.backgroundColor}}"),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    height: 20,
                                    width: 20,
                                    color: value.appBarTheme.backgroundColor,
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                  validator: (value) {
                    if (_selectedOption == null) {
                      return 'Please select an option';
                    }
                    return null;
                  },
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _incrementCounter(context),
        tooltip: 'Increment',
        child: const Icon(Icons.swap_horiz_sharp),
      ),
    );
  }
}
