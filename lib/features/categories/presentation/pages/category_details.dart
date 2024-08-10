import 'package:events_dashboard/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:events_dashboard/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:events_dashboard/features/categories/presentation/pages/categories_screen.dart';
import 'package:events_dashboard/features/categories/presentation/widgets/add_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({
    super.key,
    required this.id,
  });
  final String id;
  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    super.initState();
    context.read<CategoriesBloc>().add(GetProductsByCategory(catId: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cetagory Details'),
      ),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          return switch (state.productStatus) {
            CubitStatus.success => ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(12),
                          side: const BorderSide(color: Color(0xffA50044))),
                      leading: Container(
                        height: 100,
                        width: 80,
                        margin: const EdgeInsets.all(5),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: Image.network(
                          state.products[index]['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(state.products[index]['name']),
                      subtitle: Text('${state.products[index]['price']} S.P'),
                      trailing: SizedBox(
                        width: 80,
                        child: SliderTheme(
                          data: SliderThemeData(
                              thumbShape: SliderComponentShape.noThumb),
                          child: Slider(
                              value: state.products[index]['rate'] / 5,
                              onChanged: (s) {}),
                        ),
                      ),
                    ),
                  );
                }),
            CubitStatus.failed => MainErrorWidget(onTap: () {
                context
                    .read<CategoriesBloc>()
                    .add(GetProductsByCategory(catId: widget.id));
              }),
            _ => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
          };
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAdaptiveDialog(
              context: context,
              builder: (context) {
                return AddProductDialog(
                  id: widget.id,
                );
              });
        },
        child: const Icon(Icons.sd_card_alert_rounded),
      ),
    );
  }
}
