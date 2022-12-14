class EllipticCurvePoint
{
  BigInt x;
  BigInt y;

  EllipticCurvePoint(this.x,this.y);
}
class M511
{
  BigInt hugeMagicalPrimeNumber = BigInt.parse("6703903964971298549787012499102923063739682910296196688861780721860882015036773488400937149083451713845015929093243025426876941405973284973216824503041861");
  EllipticCurvePoint secureBasePoint = new EllipticCurvePoint(
      BigInt.from(5),
      BigInt.parse("2500410645565072423368981149139213252211568685173608590070979264248275228603899706950518127817176591878667784247582124505430745177116625808811349787373477"));
  BigInt A = BigInt.from(530438);
  BigInt three = BigInt.from(3);

  EllipticCurvePoint add(EllipticCurvePoint a, EllipticCurvePoint b)
  {
    BigInt lambda;
    if ( a.x == b.x )
    {
      lambda = ((three*(a.x*a.x)+A)*(BigInt.two*a.y).modInverse(hugeMagicalPrimeNumber))%hugeMagicalPrimeNumber;
    } else {
      lambda = ((b.y-a.y) * (b.x-a.x).modInverse(hugeMagicalPrimeNumber))%hugeMagicalPrimeNumber;
    }
    BigInt xr = (lambda*lambda - a.x - b.x)%hugeMagicalPrimeNumber;
    return EllipticCurvePoint(xr, (lambda*(a.x-xr)-a.y)%hugeMagicalPrimeNumber);
  }

  EllipticCurvePoint multiply(EllipticCurvePoint ellipticCurvePoint, BigInt n)
  {
    BigInt done_additions = BigInt.zero;
    EllipticCurvePoint result = ellipticCurvePoint;
    while(done_additions < n)
    {
      if ((n-done_additions).isEven )
      {
        result = add(result,result);
        done_additions += ((n-done_additions)~/BigInt.two);
      } else {
        result = add(result,ellipticCurvePoint);
        done_additions+= BigInt.one;
      }
    }
    return result;
  }
}
