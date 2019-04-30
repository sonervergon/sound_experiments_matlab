class Complex {
  constructor(real, imag) {
    this.real = real;
    this.imag = imag;
  }

  static abs(a, b) {
    return Math.hypot(a, b);
  }
}

class Analyser {
  constructor(stream) {
    this.stream = stream;
  }
}

const num = new Complex(2, 2);
console.log(Complex.abs(num.imag, num.real));
