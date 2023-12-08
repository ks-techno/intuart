import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:final_app/utils/app_colors.dart';
import 'package:flutter/material.dart';


class FilterWidget extends StatefulWidget {
  final String Function(String value) selectedOrderFilter;

  /// This is use to send selected Status value to parent class and save into another variable so we can retrieve here when we reload and hit the API call
  final String callBackOrderFilter;

  final bool kisWeb;
  final String Function(String value)? selectedFilter;

  FilterWidget({
    Key? key,
   required this.selectedOrderFilter,
    required this.kisWeb,
    this.selectedFilter,
    required this.callBackOrderFilter,
  }) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  TextEditingController searchController = TextEditingController();

  final List<String> filterItems = [
    'random', 'facade', 'crossbrick', 'weave', 'zigzag', 'hexagon', 'crossweave'
  ];
  List<String> selectedFilters = [];
  Map<String, String> itemValueMap = {
    'random': 'random',
    'facade': 'facade',
    'crossbrick': 'crossbrick',
    'weave': 'weave',
    'zigzag': 'zigzag',
    'hexagon': 'hexagon',
    'crossweave': 'crossweave',
  };
  String selectedSortValue = 'random';

  bool isSearchEnabled = false;
  final List<String> statusItems = [];
  String selectedStatusValue = 'All Programs';
  int selectedStatusId = -1;
  final List<int> statusItemIds = []; // Create a list to store the corresponding IDs
  String checkItem = '';
  Color textColor = Colors.grey; // Default text color

  @override
  void initState() {
    // print("------------->>>>${widget.callBackFilter}>>>>>>>>");
    // selectedStatusValue = widget.callBackFilter.isNotEmpty ? widget.callBackFilter : "All Programs";
    selectedSortValue = widget.callBackOrderFilter.isNotEmpty ? widget.callBackOrderFilter : "random";
    // selectedStatusId = widget.model.data?.programs?[0].programId ?? -1;
    // print(" values--before--selection-$selectedStatusValue $selectedSortValue");
    // statusItems.add("All Programs");
    // statusItemIds.add(0);
    // for (int i = 0; i < widget.model.data!.programs!.length; i++) {
    //   statusItems.add(widget.model.data?.programs?[i].programName ?? "");
    //   statusItemIds.add(widget.model.data?.programs?[i].programId ?? -1); // Add corresponding IDs
    // }

    // print("Status items name list is ${widget.onStatusSelected.toString()}");
    // widget.bloc.add(GetStatusDropdownDataEvent());
    super.initState();
  }
  void resetFunction() {
    setState(() {
      selectedSortValue = 'random';
      selectedFilters.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.095,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,

            borderRadius: BorderRadius.circular(14)
        ),
        //width: MediaQuery.of(context).size.height * 0.34,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _dropDownButton2(context),
              ],
            ),
          ),
        ),
      ),
    );
  }


  /// /*----------DROPDOWN STATUS----------*/
  _dropDownButton2(BuildContext context,) {
    int selectedIndex = 0; // Initialize the selected index
    return Padding(
      padding: widget.kisWeb
          ? const EdgeInsets.only(top: 0.0)
          : const EdgeInsets.only(top: 9.0),
      child: SizedBox(
        width: widget.kisWeb
            ? MediaQuery.of(context).size.width * 0.06
            : selectedSortValue == "random"
            ? MediaQuery.of(context).size.width * 0.2
            : MediaQuery.of(context).size.width * 0.2,
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            iconStyleData: const IconStyleData(icon: Icon(Icons.keyboard_arrow_down),),
            isExpanded: true,
            hint: Padding(
              padding: const EdgeInsets.only(left: 14.0,bottom:0),
              child: Text(
                selectedSortValue,
            // selectedSortValue[0].toUpperCase() + selectedSortValue.substring(1),
                //  item.isNotEmpty ? item[0].toUpperCase() + item.substring(1) : item,
              ),
            ),
            items: filterItems.map((item) {
              final index = filterItems.indexOf(item);

              return DropdownMenuItem(
                value: item,
                enabled: true, // Enable interaction with the items
                child: StatefulBuilder(
                  builder: (context, menuSetState) {
                    final isSelected = selectedFilters.contains(item);
                    return InkWell(
                      onTap: (!item.contains('random'))
                          ? () {
                        resetFunction();

                        if (isSelected) {
                          selectedFilters.remove(item);
                        } else {
                          final selectedValue = itemValueMap[item];
                          if (selectedValue != null) {
                            selectedSortValue = selectedValue;
                            print("Selected value 1 $selectedSortValue");
                          }
                        }
                        menuSetState(() {});
                        setState(() {
                          /// SETTING SELECTED VALUE
                          selectedIndex = index;
                          selectedSortValue = item;

                          widget.selectedOrderFilter(selectedSortValue);
                          print(
                              "<<Selected status item>>>  ${widget.selectedOrderFilter.toString()} $selectedSortValue");

                          Navigator.of(context).pop();
                        });
                      }
                          : null,
                      child: SizedBox(
                        height: double.infinity,
                        child: Column(
                          children: [
                            Container(
                              color: widget.callBackOrderFilter.contains(item)
                                  ?  Colors.indigo.shade900
                                  :  Colors.indigo.shade900,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8, left: 10),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Container(
                                    //   height: 12.0,
                                    //   width: 8.0,
                                    //   child: selectedIndex == index
                                    //       ? Icon(
                                    //     Icons.check,
                                    //     size: 14,
                                    //     color: selectedIndex == index
                                    //         ? Colors.white
                                    //         : Colors.white,
                                    //   )
                                    //       : Container(),
                                    // ),
                                    // const SizedBox(width: 10),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                        const  EdgeInsets.only(left: 8.0),
                                        child: Text(
                                    item.isNotEmpty ? item[0].toUpperCase() + item.substring(1) : item,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
            value: null,
            onChanged: (value) {},
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.indigo.shade900, // Set the dropdown background color
              ),
              maxHeight: widget.kisWeb ? 290 : 400,
              width: widget.kisWeb
                  ? getWidth(context) * 0.13
                  : getWidth(context) * 0.23,
              offset: widget.kisWeb ? const Offset(0, 6) : const Offset(14, 12),
            ),
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.only(left: 0, right: 6),
              height: 40,
              width: 140,
              decoration: BoxDecoration(),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(),
            ),
          ),
        ),
      ),
    );
  }

  double getWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  double getHeight(BuildContext context) {
    double statusBar = MediaQuery.paddingOf(context).top;
    double bottomBar = MediaQuery.paddingOf(context).bottom;
    double screenHeight = MediaQuery.sizeOf(context) .height - statusBar - bottomBar;
    return screenHeight;
  }
}

