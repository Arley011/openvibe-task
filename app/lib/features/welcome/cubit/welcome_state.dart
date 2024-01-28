part of 'welcome_cubit.dart';

abstract class WelcomeState {
  const WelcomeState();
}

class WelcomeInitial extends WelcomeState {
  const WelcomeInitial();
}

class WelcomeLoading extends WelcomeState {
  const WelcomeLoading();
}

class WelcomeSuccess extends WelcomeState {
  const WelcomeSuccess();
}

class WelcomeError extends WelcomeState {
  const WelcomeError();
}
