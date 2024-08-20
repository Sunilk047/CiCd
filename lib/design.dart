// lib/main.dart

import 'package:dynamic_flutter_flow/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'models/widget_model.dart';



// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'FlutterFlow Clone',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomeScreen(),
//     );
//   }
// }

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterFlow Clone'),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: WidgetPanel(),
          ),
          Expanded(
            flex: 3,
            child: CanvasArea(),
          ),
        ],
      ),
    );
  }
}

class WidgetPanel extends StatelessWidget {
  final List<WidgetModel> availableWidgets = [
    WidgetModel(id: 'text', widget: Text('Text Widget')),
    WidgetModel(id: 'row', widget: Row(children: [Text('Row')])),
    WidgetModel(id: 'column', widget: Column(children: [Text('Column')])),
    WidgetModel(id: 'container', widget: Container(width: 100, height: 100, color: Colors.blue)),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: availableWidgets.length,
      itemBuilder: (context, index) {
        final widgetModel = availableWidgets[index];
        return Draggable<WidgetModel>(
          data: widgetModel,
          child: ListTile(
            title: Text(widgetModel.id),
          ),
          feedback: Material(
            child: widgetModel.widget,
          ),
          childWhenDragging: ListTile(
            title: Text(widgetModel.id),
            enabled: false,
          ),
        );
      },
    );
  }
}

class CanvasArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WidgetProvider>(
      builder: (context, provider, child) {
        return DragTarget<WidgetModel>(
          onAccept: (widgetModel) {
            provider.addWidget(widgetModel);
          },
          builder: (context, candidateData, rejectedData) {
            return Container(
              color: Colors.grey[300],
              child: Stack(
                children: provider.widgets
                    .map((model) => Positioned(
                          top: 50.0 * provider.widgets.indexOf(model),
                          left: 20.0,
                          child: model.widget,
                        ))
                    .toList(),
              ),
            );
          },
        );
      },
    );
  }
}

class WidgetProvider with ChangeNotifier {
  final List<WidgetModel> _widgets = [];

  List<WidgetModel> get widgets => _widgets;

  void addWidget(WidgetModel widgetModel) {
    _widgets.add(widgetModel);
    notifyListeners();
  }
}
