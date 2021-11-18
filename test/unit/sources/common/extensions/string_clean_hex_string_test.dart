import 'package:colored/sources/common/extensions/string_clean_hex_string.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
	group("Given a $String", () {
		group("when calling cleanHex", () {
			test("then the first pound signs are removed from the string", () {
				expect("#fafafa".cleanHex, "fafafa");
			});

			test("then all pound signs are removed from the string", () {
				expect("#f#afafa".cleanHex, "fafafa");
			});

			test("then no other symbols are striped", () {
				expect("1234567890!@\$%^&*()".cleanHex, "1234567890!@\$%^&*()");
			});
		});
	});
}
