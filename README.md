# M511
An implementation of curve M-511 in Flutter

M-511 is a secure 512-bit-elliptic curve that can be used for Diffie-Hellman Key-Exchange.

Example for testing purposes:

  void test(){
    BigInt alice_secret = BigInt.from(Random().nextInt(10000000));
    BigInt bob_secret = BigInt.from(Random().nextInt(10000000));

    EllipticCurvePoint alicePublicKey = multiply(secureBasePoint, alice_secret);
    EllipticCurvePoint bobPublicKey = multiply(secureBasePoint, bob_secret);

    print("ALICE PUBLIC KEY: "+alicePublicKey.x.toRadixString(10)+"/"+alicePublicKey.y.toRadixString(10));
    print("BOB PUBLIC KEY: "+bobPublicKey.x.toRadixString(10)+"/"+bobPublicKey.y.toRadixString(10));

    EllipticCurvePoint aliceComputesSharedSecret = multiply(bobPublicKey, alice_secret);
    EllipticCurvePoint bobComputesSharedSecret = multiply(alicePublicKey, bob_secret);

    print("ALICE COMPUTES SECRET: "+aliceComputesSharedSecret.x.toRadixString(16));
    print("BOB COMPUTES SECRET: "+bobComputesSharedSecret.x.toRadixString(16));
  }

NOTE: This can be implemented with the Montgomery-Ladder to prevent Side-channel-attacks.
This is not secure against side-channel-attacks.
Thus, if an attacker could measure the power consumption of your program, he might be able to reverse-engineer Alice's Secret.
