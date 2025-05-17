import 'dart:convert';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/modules/home/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProvinceCityDialog extends StatefulWidget {
  const ProvinceCityDialog({super.key});

  @override
  _ProvinceCityDialogState createState() => _ProvinceCityDialogState();
}

class _ProvinceCityDialogState extends State<ProvinceCityDialog> {
  Map<String, List<String>> _locations = {};
  List<String> _provinces = [];
  List<String> _filteredCities = [];
  String? _selectedProvince;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadLocations();
    _searchController.addListener(_filterCities);
  }

  Future<void> _loadLocations() async {
    final raw = await rootBundle.loadString(R.assets.jsonData.jsonData);
    final Map<String, dynamic> jsonMap = json.decode(raw);
    setState(() {
      _locations = jsonMap.map((k, v) => MapEntry(k, List<String>.from(v)));
      _provinces = _locations.keys.toList()..sort();
    });
  }

  void _filterCities() {
    if (_selectedProvince == null) return;
    final q = _searchController.text.toLowerCase();
    final all = _locations[_selectedProvince!]!;
    setState(() {
      _filteredCities = all.where((c) => c.toLowerCase().contains(q)).toList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCities);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme.displayLarge!;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 20.h),
      height: 600.h,
      decoration: BoxDecoration(color: R.palette.white, borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        children: [
          // header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Row(
              children: [
                if (_selectedProvince != null)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedProvince = null;
                        _searchController.clear();
                      });
                    },
                    child: SvgPicture.asset(R.assets.graphics.svgIcons.backArrow),
                  )
                else
                  const SizedBox(width: 24),

                const Spacer(),
                Text(
                  _selectedProvince == null ? 'Select Province' : 'Select City',
                  style: theme.copyWith(color: R.palette.blackColor, fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
          SizedBox(height: 30.h),
          if (_selectedProvince != null)
            CustomSearchBar(
              searchController: _searchController,
              onChanged: (e) {},
              //
            ),
          if (_selectedProvince != null)
          SizedBox(height: 20.h),
          Expanded(child: _buildList()),
        ],
      ),
    );
  }

  Widget _buildList() {
    if (_locations.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_selectedProvince == null) {
      return ListView.separated(
        itemCount: _provinces.length,
        separatorBuilder: (_, __) => Padding(
          padding:  EdgeInsets.symmetric(horizontal: 12.w),
          child: Divider(color: R.palette.gray,height: 1.2.h,),
        ),
        itemBuilder: (_, i) {
          final prov = _provinces[i];
          return ListTile(
            title: Text(prov, style: TextStyle(fontSize: 14.sp)),
            onTap: () {
              setState(() {
                _selectedProvince = prov;
                _filteredCities = List.from(_locations[prov]!);
              });
            },
          );
        },
      );
    }

    // show filtered cities
    if (_filteredCities.isEmpty) {
      return const Center(child: Text('No cities found.'));
    }
    return ListView.separated(
      itemCount: _filteredCities.length,
      separatorBuilder: (_, __) =>  Padding(
        padding:  EdgeInsets.symmetric(horizontal: 12.w),
        child: Divider(color: R.palette.gray,height: 1.2.h,),
      ),
      itemBuilder: (_, i) {
        final city = _filteredCities[i];
        return ListTile(
          title: Text(city, style: TextStyle(fontSize: 14.sp)),
          onTap: () => Navigator.of(context).pop({'province': _selectedProvince!, 'city': city}),
        );
      },
    );
  }
}
