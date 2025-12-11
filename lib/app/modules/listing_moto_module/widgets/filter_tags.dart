import 'package:biker_app/app/modules/listing_moto_module/listing_moto_controller.dart';
import 'package:biker_app/app/modules/listing_moto_module/widgets/filter_chip.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterTags extends GetWidget<ListingMotoController> {
  const FilterTags({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final chips = <Widget>[];

      final f = controller.fController;

      // Brand
      if (f.selectedBrand.value != null &&
          f.selectedBrand.value!.isNotEmpty &&
          !f.selectedBrand.value!.contains('TOUTES')) {
        chips.add(
          FilterChipWidget(
            label: f.selectedBrand.value!,
            onDelete: () {
              f.onSelectBrand(null);
              controller.onRefresh();
            },
          ),
        );
      }

      // Model
      if (f.model.value.isNotEmpty) {
        chips.add(
          FilterChipWidget(
            label: f.model.value,
            onDelete: () {
              f.setModel('');
              controller.onRefresh();
            },
          ),
        );
      }

      // Category
      if (f.selectedCategory.value != null &&
          f.selectedCategory.value!.isNotEmpty) {
        chips.add(
          FilterChipWidget(
            label: f.selectedCategory.value!,
            onDelete: () {
              f.onSelectCategory(null);
              controller.onRefresh();
            },
          ),
        );
      }

      // Cylindre
      if (f.cylendre.value != null) {
        chips.add(
          FilterChipWidget(
            label: f.cylendre.value!.value,
            onDelete: () {
              f.onSelectCylindre(null);
              controller.onRefresh();
            },
          ),
        );
      }

      // Kilometrage
      if (f.kilometrageRange.value.start > 0 ||
          f.kilometrageRange.value.end < filterMaxKm) {
        chips.add(
          FilterChipWidget(
            label:
                '${f.kilometrageRange.value.start.round()} -  ${f.kilometrageRange.value.end == filterMaxKm ? 'Plus de ${filterMaxKm.round()}' : f.kilometrageRange.value.end.round()} Km',
            onDelete: () {
              f.setkilometrageRange(RangeValues(0, filterMaxKm));
              controller.onRefresh();
            },
          ),
        );
      }

      // Price
      if (f.priceRange.value.start > 0 ||
          f.priceRange.value.end < filterMaxPrice) {
        chips.add(
          FilterChipWidget(
            label:
                '${f.priceRange.value.start.toInt()} - ${f.priceRange.value.end == filterMaxPrice ? 'Plus de ${filterMaxPrice.round()}' : f.priceRange.value.end.round().toString()} DH',
            onDelete: () {
              f.setPriceRange(RangeValues(0, filterMaxPrice));
              controller.onRefresh();
            },
          ),
        );
      }

      // City
      if (f.selectedCity.value != null && f.selectedCity.value!.isNotEmpty) {
        chips.add(
          FilterChipWidget(
            label: f.selectedCity.value!,
            onDelete: () {
              f.onSelectCity(null);
              controller.onRefresh();
            },
          ),
        );
      }

      // If no chips, return empty widget
      if (chips.isEmpty) {
        return const SliverToBoxAdapter(child: SizedBox.shrink()); // ✅ Fixed
      }

      // Otherwise return horizontal ListView
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: SizedBox(
            height: 30,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: chips.length,
              itemBuilder: (context, index) => chips[index],
              separatorBuilder: (context, index) => const SizedBox(width: 10),
            ),
          ),
        ),
      );
    });
  }
}
