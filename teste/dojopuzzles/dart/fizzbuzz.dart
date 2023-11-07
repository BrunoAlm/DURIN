void main() {
  // numeros.forEach((i) {
  //   if (i % 3 == 0 && i % 5 == 0) {
  //     print('FizzBuzz');
  //   } else if (i % 3 == 0) {
  //     print('Fizz');
  //   } else if (i % 5 == 0) {
  //     print('Buzz');
  //   } else {
  //     print(i);
  //   }
  // });
  // print(numeros);
  // numeros.reversed.forEach(
  //   (element) => print(element),
  // );
  List<int> numeros = List.generate(101, (int elemento) => elemento);

  List<int> numeros3 = numeros.where((i) => i % 3 == 0).toList();
  List<int> numeros5 = numeros.where((i) => i % 5 == 0).toList();
  List<int> numeros3e5 =
      numeros.where((i) => i % 5 == 0 && i % 3 == 0).toList();
  
  print(numeros3.where((element) => numeros5.contains(element)));
}
