import 'package:flutter_test/flutter_test.dart';

import 'package:firelab/main.dart';

void main() {
   testWidgets('App builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(isLoggedIn: false));
    expect(find.text('Login'), findsWidgets);
  });


}
