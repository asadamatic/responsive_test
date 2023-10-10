import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveBuilderApp extends StatelessWidget {
  const ResponsiveBuilderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Responsive Builder',
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
    print("Orientation");
    print(getDeviceType(MediaQuery.sizeOf(context)));

    final textStyle = getValueForScreenType(
        context: context,
        mobile: Theme.of(context).textTheme.headlineSmall,
        tablet: Theme.of(context).textTheme.headlineMedium,
        desktop: Theme.of(context).textTheme.headlineLarge);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Responsive Builder"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: getValueForScreenType(
              context: context,
              mobile: MainAxisAlignment.center,
              tablet: MainAxisAlignment.spaceBetween,
              desktop: MainAxisAlignment.spaceBetween,
              watch: MainAxisAlignment.center),
          children: [
            ScreenTypeLayout.builder(
              mobile: (context) => OrientationLayoutBuilder(
                portrait: (context) => SizedBox(),
                landscape: (context) => CustomDrawer(),
              ),
              tablet: (context) => CustomDrawer(),
              desktop: (context) => CustomDrawer(),
            ),
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
      drawer: ScreenTypeLayout.builder(
        mobile: (context) => OrientationLayoutBuilder(
          portrait: (context) => CustomDrawer(),
          landscape: (context) => SizedBox(),
        ),
        // desktop: (context) => CustomDrawer()
      ),
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
