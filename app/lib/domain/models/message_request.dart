import 'dart:async';

import 'package:equatable/equatable.dart';

class MessagesRequest extends Equatable {
  const MessagesRequest({
    required this.requestId,
    required this.desiredCount,
    required this.timeoutTimer,
    this.receivedCount = 0,
  });

  final String requestId;
  final int desiredCount;
  final Timer timeoutTimer;
  final int receivedCount;

  MessagesRequest incrementReceivedCount() {
    final updatedRequest = MessagesRequest(
      requestId: requestId,
      desiredCount: desiredCount,
      timeoutTimer: timeoutTimer,
      receivedCount: receivedCount + 1,
    );
    if (updatedRequest.isComplete) {
      timeoutTimer.cancel();
    }

    return updatedRequest;
  }

  bool get isComplete => receivedCount == desiredCount;

  @override
  List<Object?> get props => [
        requestId,
        desiredCount,
        timeoutTimer,
        receivedCount,
      ];
}
