import 'package:events_dashboard/features/categories/presentation/pages/categories_screen.dart';
import 'package:events_dashboard/features/feedback/presentation/cubit/feedback_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FeedbackCubit>().getFeedBacks();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackCubit, FeedbackState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Feedbacks'),
            centerTitle: true,
          ),
          body: switch (state.status) {
            CubitStatus.success => ListView.builder(
                itemCount: state.feedBacks.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xff004D98), Color(0xffA50044)],
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    margin: const EdgeInsets.all(8),
                    child: Theme(
                      data: ThemeData(
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        dividerColor: Colors.transparent,
                        expansionTileTheme: const ExpansionTileThemeData(
                          backgroundColor: Colors.transparent,
                          collapsedBackgroundColor: Colors.transparent,
                        ),
                      ),
                      child: ExpansionTile(
                        title: Text(state.feedBacks[index]['name'],
                            style: const TextStyle(color: Colors.white)),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        tilePadding: const EdgeInsets.all(14),
                        childrenPadding: const EdgeInsets.all(14),
                        children: [
                          Row(
                            children: [
                              const Text('E-mail:\t',
                                  style: TextStyle(color: Colors.white)),
                              Text(state.feedBacks[index]['email'],
                                  style: const TextStyle(color: Colors.white))
                            ],
                          ),
                          Text('Message:\n${state.feedBacks[index]['message']}',
                              style: const TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                  );
                }),
            CubitStatus.failed => MainErrorWidget(onTap: () {
                context.read<FeedbackCubit>().getFeedBacks();
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
