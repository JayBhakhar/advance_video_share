import 'package:advance_video_share/views/pages/BussinessForm2.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class BussinessForm extends StatefulWidget {
  // String categoryType;
  //
  // BussinessForm({Key key, this.categoryType}) : super(key: key);

  @override
  _BussinessFormState createState() => _BussinessFormState();
}

class _BussinessFormState extends State<BussinessForm> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Everyday Status, BusinessCard, photo & video status',
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 12.0,
          ),
          Center(
            child: Text('Select Date',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 16),),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRect(
              child: SfDateRangePicker(
                backgroundColor: Colors.white,
                onSelectionChanged: _onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.single,
              ),
            ),
          ),
          Center(
            child: Text('Select Format',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 16),),
          ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: List<Widget>.generate(3, (int index1) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    child: Container(
                      height: 160,
                      width: 160,
                      decoration: BoxDecoration(
                          image: new DecorationImage(
                              fit: BoxFit.cover,
                              image: new AssetImage('assets/photos/01.jpg')),
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8.0)),
                      // child: VideoPlayer(
                      //   VideoPlayerController.network(videoUrlList[index1])
                      //     ..initialize(),
                      // ),
                    ),
                    onTap: () {
                    },
                  ),
                );
              }),
            ),
          ),
        ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding:  EdgeInsets.only(right:16.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BussinessForm2(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.only(
                      top: 12.0,
                      bottom: 12.0,
                      left: 16.0,
                      right: 12.0),
                  decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(8.0)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Next",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'nirmalaB', fontWeight: FontWeight.bold, letterSpacing: 0.7),
                      ),
                      Icon(Icons.navigate_next,color: Colors.white,)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
      //   _range = DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
      //       ' - ' +
      //       DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate).toString();
      // } else if (args.value is DateTime) {
      //   _selectedDate = args.value.toString();
      // } else if (args.value is List<DateTime>) {
      //   _dateCount = args.value.length.toString();
      // } else {
      //   _rangeCount = args.value.length.toString();
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}
