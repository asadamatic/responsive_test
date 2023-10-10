import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:responsive_framework/responsive_framework.dart';


class ResponsiveFrameworkApp extends StatelessWidget {
  const ResponsiveFrameworkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: (context, child) => DevicePreview.appBuilder(
          context,
          Builder(
            builder: (context) {
              return ResponsiveBreakpoints.builder(
                child: child!,
                breakpoints: [
                  const Breakpoint(start: 0, end: 450, name: MOBILE),
                  const Breakpoint(start: 451, end: 800, name: TABLET),
                  const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                  const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
                ],
              );
            }
          )),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
            initialRoute: "/",
            routes: {
              '/': (context) => MyHomePage(),

            },

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = ResponsiveValue(context, conditionalValues: [
      Condition.largerThan(
          value: Theme.of(context).textTheme.headlineMedium, name: TABLET)
    ]).getValue(context, [
      Condition.largerThan(
          value: Theme.of(context).textTheme.headlineMedium, name: TABLET)
    ]);

print("Orientation");
print(ResponsiveBreakpoints.of(context).orientation);

print(ResponsiveBreakpoints.of(context).breakpoints);
    print('<---- TABLET ---->');
    print('Larger Than Tablet');
    print(ResponsiveBreakpoints.of(context).largerThan(TABLET));
    print('Equal to Tablet');
    print(ResponsiveBreakpoints.of(context).equals(TABLET));
    print('Smaller Than Tablet');
    print(ResponsiveBreakpoints.of(context).smallerThan(TABLET));

    print('<---- DESKTOP ---->');
    print('Larger Than Desktop');
    print(ResponsiveBreakpoints.of(context).largerThan(DESKTOP));
    print('Equal to Desktop');
    print(ResponsiveBreakpoints.of(context).equals(DESKTOP));
    print('Smaller Than Desktop');
    print(ResponsiveBreakpoints.of(context).smallerThan(DESKTOP));
    final responsiveValues = ResponsiveValue<MainAxisAlignment>(context,
        // defaultValue: MainAxisAlignment.center,
        conditionalValues: [
          Condition.largerThan(
            value: MainAxisAlignment.spaceBetween,
            name: TABLET,
            landscapeValue: MainAxisAlignment.start,
          ),
          Condition.equals(
            value: MainAxisAlignment.spaceBetween,
            name: TABLET,
            landscapeValue: MainAxisAlignment.spaceBetween,
          ),
          Condition.smallerThan(
            value: MainAxisAlignment.center,
            name: TABLET,
            landscapeValue: MainAxisAlignment.spaceBetween,
          ),
        ]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Responsive Framework"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: responsiveValues.value!,
          children: [
            ResponsiveVisibility(
              hiddenConditions: [
             
              Condition.smallerThan(
                value: true,
                name: TABLET,
                landscapeValue: true,
              ),
            ], 
            
            child: CustomDrawer()),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You have pushed the button this many times:',
                    style: textStyle,
                  ),
                  Text(
                    '$_counter',
                    style: textStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer:
          ResponsiveBreakpoints.of(context).isMobile ? CustomDrawer() : null,
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) => ListTile(
          title: Text(index.toString()),
        ),
      ),
    );
  }
}
