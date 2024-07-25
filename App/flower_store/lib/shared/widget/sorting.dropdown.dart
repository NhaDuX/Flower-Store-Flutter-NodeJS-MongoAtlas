import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class SortingDropdown extends StatefulWidget {
  final Function(String) onSortOptionChanged;

  const SortingDropdown({required this.onSortOptionChanged});

  @override
  _SortingDropdownState createState() => _SortingDropdownState();
}

class _SortingDropdownState extends State<SortingDropdown> {
  String? _selectedSortOption;
  final List<String> _sortOptions = [
    'A-Z',
    'Z-A',
    'Giá, thấp đến cao',
    'Giá, cao đến thấp',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 35,
        width: 165,
        decoration: BoxDecoration(
          color: const Color(0xFFFA6C6C),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Center(
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                alignment: Alignment.center,
                value: _selectedSortOption,
                hint: const Text(
                  'Sắp xếp',
                  style: TextStyle(color: Colors.white),
                ),
                items: _sortOptions.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                customButton: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          _selectedSortOption ?? 'Sắp xếp',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                  ],
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedSortOption = newValue;
                    widget.onSortOptionChanged(newValue!);
                  });
                },
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFA6C6C),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                buttonStyleData: ButtonStyleData(
                  height: 35,
                  width: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFA6C6C),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                iconStyleData: const IconStyleData(
                  iconEnabledColor: Colors.white,
                  iconDisabledColor: Colors.grey,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
