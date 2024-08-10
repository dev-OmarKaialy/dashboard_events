import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_dashboard/features/categories/presentation/pages/categories_screen.dart';
import 'package:events_dashboard/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersCubit>().getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        var list2 = state.orders.where((e) {
          return e['status'] == 1;
        }).toList();
        return Scaffold(
          appBar: AppBar(title: const Text('Orders'), centerTitle: true),
          body: switch (state.status) {
            CubitStatus.success => DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    const TabBar(tabs: [
                      Text('Completed Orders'),
                      Text('Pending Orders'),
                    ]),
                    Expanded(
                      child: TabBarView(children: [
                        ListView.builder(
                            itemCount: state.orders
                                .where((e) {
                                  return e['status'] != 1;
                                })
                                .toList()
                                .length,
                            itemBuilder: (context, index) {
                              var list = state.orders.where((e) {
                                return e['status'] != 1;
                              }).toList();
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ExpansionTile(
                                    collapsedBackgroundColor:
                                        list[index]['status'] == 0
                                            ? Colors.redAccent
                                            : Colors.greenAccent,
                                    title: Text(
                                        (list[index]['date'] as Timestamp)
                                            .toDate()
                                            .toString()
                                            .substring(0, 10)),
                                    children: const []),
                              );
                            }),
                        ListView.builder(
                            itemCount: list2.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ExpansionTile(
                                    title: Text((state.orders.where((e) {
                                      return e['status'] == 1;
                                    }).toList()[index]['date'] as Timestamp)
                                        .toDate()
                                        .toString()
                                        .substring(0, 10)),
                                    children: [
                                      Row(
                                        children: [
                                          IconButton.filled(
                                              onPressed: () {
                                                context
                                                    .read<OrdersCubit>()
                                                    .toggleOrder(
                                                        list2[index].id, true);
                                              },
                                              icon: const Icon(
                                                  Icons.check_box_rounded,
                                                  color: Colors.greenAccent)),
                                          IconButton.filled(
                                              onPressed: () {
                                                context
                                                    .read<OrdersCubit>()
                                                    .toggleOrder(
                                                        list2[index].id, false);
                                              },
                                              icon: const Icon(
                                                Icons.close,
                                                color: Colors.red,
                                              )),
                                        ],
                                      ),
                                      FutureBuilder(
                                        future: Future(() async {
                                          List products = [];
                                          for (var e in list2[index]
                                              ['products']) {
                                            final r = await FirebaseFirestore
                                                .instance
                                                .collection('packages')
                                                .doc(e.id)
                                                .get();
                                            products.add(r);
                                          }
                                          return products;
                                        }),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return SizedBox(
                                              height: .8.sw,
                                              child: Wrap(
                                                children: [
                                                  for (int i = 0;
                                                      i < snapshot.data!.length;
                                                      i++)
                                                    Column(
                                                      children: [
                                                        Text(snapshot.data![i]
                                                                ['name']
                                                            .toString()),
                                                        Image.network(
                                                          snapshot.data![i]
                                                              ['image'],
                                                          width: 120,
                                                          height: 120,
                                                        )
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            );
                                          }
                                          return const SizedBox();
                                        },
                                      )
                                    ]),
                              );
                            })
                      ]),
                    ),
                  ],
                )),
            CubitStatus.failed => MainErrorWidget(onTap: () {
                context.read<OrdersCubit>().getOrders();
              }),
            _ => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
          },
        );
      },
    );
  }
}
