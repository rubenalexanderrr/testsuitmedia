bool isPalindrome(String input) {
final filtered = input
.toLowerCase()
.replaceAll(RegExp(r"[^a-z0-9]"), '');
final reversed = filtered.split('').reversed.join();
return filtered.isNotEmpty && filtered == reversed;
}