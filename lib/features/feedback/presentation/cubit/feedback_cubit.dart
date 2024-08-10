import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_dashboard/features/feedback/data/datasources/feedback_data.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit() : super(const FeedbackState());
  getFeedBacks() async {
    emit(state.copyWith(status: CubitStatus.loading));
    try {
      final r = await FeedbackData().getFeedBacks();
      emit(state.copyWith(status: CubitStatus.success, feedBacks: r));
    } catch (e) {
      emit(state.copyWith(status: CubitStatus.failed));
    }
  }
}
