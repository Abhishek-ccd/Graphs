# Graphs

To use custom graphs in flutterflow first we need to create custom widgets and use these custom widgets in the application.

## Custom widgets

To create an custom widget first got to this section(Custom Code)

<img width="44" alt="image" src="https://github.com/Abhishek-ccd/Graphs/assets/137879656/48a00b74-bf37-4483-a645-ccf1427804fd">


Now click on the Add button and then select the widget option

<img width="226" alt="image" src="https://github.com/Abhishek-ccd/Graphs/assets/137879656/e3ce420f-0e8a-4920-bbc7-804520c69ace">


Now a new widget is created then click on the code icon present on the top right of the screen 

<img width="920" alt="image" src="https://github.com/Abhishek-ccd/Graphs/assets/137879656/659572f7-3a39-43da-82e3-af0a3070b6ba">

Now you get a popup like this, click on the copy to editor button

<img width="566" alt="image" src="https://github.com/Abhishek-ccd/Graphs/assets/137879656/dd30c82c-ef54-468d-9be3-a68c6253f0b1">

## Custom Graphs

To create custom graphs we are using syncfusion package you can find documentation here https://pub.dev/packages/syncfusion_flutter_charts/versions/20.4.44

This repo consists of Area, Multiline, Spline and StackedBar charts. To create any graph open that graph folder, you find two files a dart file that contains the code for the graph and json file which contains data format for the graph.

### Data Format

```json
[
    {
      "line": "header 1",
      "data": [
        {"year":"2015","data":8843},
        {"year":"2016","data":17165},
        {"year":"2017","data":116871},
        {"year":"2018","data":186481},
        {"year":"2019","data":350126},
        {"year":"2020","data":914007},
        {"year":"2021","data":1553947}
      ]
    },
    {
      "line": "header 2",
      "data": [
        {"year":"2015","data":8843},
        {"year":"2016","data":12885},
        {"year":"2017","data":71986},
        {"year":"2018","data":46551},
        {"year":"2019","data":138382},
        {"year":"2020","data":145446},
        {"year":"2021","data":205854}
      ]
    }
  ]
  
```

This is an array of JSON object where each object refers to an individual category and in each object it has two keys
1. line: the value should be the legend of that data points
2. data: the value is an array of json objects, where each json object has two keys one refers to x- coordinate and other refers to y-coordinate

### Dart File

Now to use the dart file, copy and paste the entire code in the custom widget code and you need to change the API url at 

```
final response = await http.get(Uri.parse('https://demo3803644.mockable.io/new'));
```

Now save the widget and after that compile code and if it has no errors it will look like this.

<img width="752" alt="image" src="https://github.com/Abhishek-ccd/Graphs/assets/137879656/d7d620e0-9ed2-45dc-abe6-5a0e9d026da6">

Now to use this custom graph in our project select the icon and below it shows the names of custom widgets select the one which you want to use.

<img width="387" alt="image" src="https://github.com/Abhishek-ccd/Graphs/assets/137879656/c293c810-9306-4be7-904b-d951b9198125">








