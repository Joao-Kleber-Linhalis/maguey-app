import 'package:flutter/material.dart';
import 'package:magueyapp/custom_app_bar.dart';
import 'package:magueyapp/entity/mezcal_product.dart';
import 'package:provider/provider.dart';

import '../../../../provider/dashboard_provider.dart';
import '../../../../theme/my_colors.dart';
import '../../events/add_a_event.dart';
import '../product_select/ui/product_select_screen.dart';

class ProductListScreen extends StatefulWidget {
  final String brandId;
  final String categoryName;
  static const String route = 'product-list-screen';

  const ProductListScreen({super.key, required this.brandId, required this.categoryName});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  TextEditingController controller = TextEditingController();
  late List<Product> products;
  late List<Product> filteredProducts;

  late DashboardProvider dashboardProvider;

  @override
  void initState() {
    dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    products = dashboardProvider.products.where((element) => element.brandId == widget.brandId).toList();
    print(widget.brandId);
    for (var product in products) {
      print(product.brandId);
    }
    filteredProducts = products;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        backgroundColor: const Color(0xFF2B2B2B),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextFormField(
                hintText: 'Search within, let the Spirits speak to you',
                controller: controller,
                validator: (value) {
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    filteredProducts = products.where((product) {
                      return product.productName.toLowerCase().contains(value.toLowerCase());
                    }).toList();
                  });
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredProducts.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return _productItemList(filteredProducts[index], context, widget.categoryName);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  double _grausParaRadianos(double graus) {
    return graus * 3.1415927 / 180;
  }
}

Widget _productItemList(Product product, BuildContext context, String categoryName) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ProductSelectScreen(
            product: product,
            categoryName: categoryName,
          ),
        ),
      );
    },
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 126,
                  child: Text(
                    product.productName,
                    style: const TextStyle(
                      color: MyColors.greenE3FF0A,
                      fontFamily: "CircularAirPro",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(
                        product.productImageUrl,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(color: MyColors.greenE3FF0A, thickness: 1.15),
      ],
    ),
  );
}
