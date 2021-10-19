import 'package:advance_video_share/consts/AppColors.dart';
import 'package:advance_video_share/views/pages/BussinessForm2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:advance_video_share/models/cardModel.dart';

class BussinessForm extends StatefulWidget {
  // String categoryType;
  //
  // BussinessForm({Key key, this.categoryType}) : super(key: key);

  @override
  _BussinessFormState createState() => _BussinessFormState();
}

class _BussinessFormState extends State<BussinessForm> {
  DateTime selectedDate = DateTime.now();
  List<cardModel> cardList = [];

  @override
  void initState() {
    super.initState();
    prepareCards();
  }

  void prepareCards() {
    setState(() {
     // for (int i = 0; i < 10; i++) {
        cardList.add(new cardModel("assets/cards/card1.jpg",AppColors.card1, true));
        cardList.add(new cardModel("assets/cards/card2.jpg",AppColors.card2, false));
        cardList.add(new cardModel("assets/cards/card3.jpg",AppColors.card3, false));
        cardList.add(new cardModel("assets/cards/card4.jpg",AppColors.card4, false));
        cardList.add(new cardModel("assets/cards/card6.jpg",AppColors.card6, false));
        cardList.add(new cardModel("assets/cards/card7.jpg",AppColors.card7, false));
        cardList.add(new cardModel("assets/cards/card8.jpg",AppColors.card8, false));
        cardList.add(new cardModel("assets/cards/card9.jpg",AppColors.card9, false));
        cardList.add(new cardModel("assets/cards/card10.jpg",AppColors.card10, false));
     // }
    });
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
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 12.0,
            ),
            Center(
              child: Text(
                'Select Date',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),

                child: SfDateRangePicker(
                  backgroundColor: Colors.white,
                  onSelectionChanged: _onSelectionChanged,
                  selectionMode: DateRangePickerSelectionMode.single,
                ),
              ),
            ),
            Center(
              child: Text(
                'Select Format',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: List<Widget>.generate(cardList.length, (int index1) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InkWell(
                        child: Stack(
                          fit: StackFit.loose,
                          children: [
                            Container(
                              height: 160,
                              width: 160,
                              decoration: BoxDecoration(
                                  // border: Border.all(
                                  //   width: cardList[index1].isSelect?6.0:0.0,
                                  //   color: cardList[index1].isSelect ? Colors.red : Colors.transparent,
                                  // ),
                                  image: new DecorationImage(fit: BoxFit.cover, image: new AssetImage(cardList[index1].list)),
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8.0)),
                            ),
                            cardList[index1].isSelect?Align(
                              alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FaIcon(FontAwesomeIcons.plusCircle,size: 28.0,color: Colors.black,),
                                )):Container(),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            for (int i = 0;i < cardList.length; i++) {
                              if (i == index1)
                                cardList[index1].isSelect = true;
                              else
                                cardList[i].isSelect = false;
                            }
                          });
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
                padding: EdgeInsets.only(right: 16.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BussinessForm2(categoryType: getSelectedIndex(),),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 14.0, right: 12.0),
                    decoration: BoxDecoration(color: Color(0xFF8B0000), borderRadius: BorderRadius.circular(8.0)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Next",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Source Sans Pro', fontWeight: FontWeight.bold, letterSpacing: 0.7,height: 1),
                        ),
                        Icon(
                          Icons.navigate_next,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            )
          ],
        ),
      )),
    );
  }

  cardModel getSelectedIndex(){
    cardModel temp ;
    for (int i = 0;i < cardList.length; i++) {
      if (cardList[i].isSelect)
        temp = cardList[i];
    }
    return temp;
  }

  Future<void> _onSelectionChanged(DateRangePickerSelectionChangedArgs args) async {
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
    print("Date---"+args.value.toString());

     // if (args.value is PickerDateRange) {
        String date =  DateFormat('dd MMM yyyy').format(args.value).toString();
        print("Date---"+date);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('date', date);
        //   _range = DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
        //       ' - ' +
        //       DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate).toString();
        // } else if (args.value is DateTime) {
        //   _selectedDate = args.value.toString();
        // } else if (args.value is List<DateTime>) {
        //   _dateCount = args.value.length.toString();
        // } else {
        //   _rangeCount = args.value.length.toString();
      // }

  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}
