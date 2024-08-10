part of 'feedback_cubit.dart';

class FeedbackState {
  final CubitStatus status;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> feedBacks;
  const FeedbackState({
    this.status = CubitStatus.initial,
    this.feedBacks = const [],
  });

  FeedbackState copyWith({
    CubitStatus? status,
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? feedBacks,
  }) {
    return FeedbackState(
      status: status ?? this.status,
      feedBacks: feedBacks ?? this.feedBacks,
    );
  }
}
