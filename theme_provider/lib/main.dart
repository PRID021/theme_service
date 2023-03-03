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
      Color ramdomColor = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0);
      return ThemeData.light().copyWith(
        primaryColor: ramdomColor,
        colorScheme: const ColorScheme.light().copyWith(
          primary: ramdomColor,
        ),
      );
    },
  );

  final List<ThemeData> _darkThemes = List.generate(
    5,
    (index) {
      Color ramdomColor = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0);
      return ThemeData.dark().copyWith(
          primaryColor: ramdomColor,
          colorScheme: const ColorScheme.dark().copyWith(
            primary: ramdomColor,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: ramdomColor,
          ));
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
            Text(
              'CustomTheme: ${ThemeServiceProvider.of(context).currentThemeData}',
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
                              ThemeServiceProvider.of(context)
                                  .onChangeSystemTheme(
                                changeForDarkTheme: _darkThemes.contains(value),
                                themeData: value as ThemeData,
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
                                  Text("${value.colorScheme.primary}}"),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    height: 20,
                                    width: 20,
                                    color: value.colorScheme.primary,
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
