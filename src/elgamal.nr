use crate::algebra::pow;
use crate::utils::gen_public_key_and_aggregate_key;

/// Minimal ElGamal encryption for one card using.
///
/// msg   = [c1, c2]   (fresh card uses [1, m]), public input
/// g     = generator  (Field, e.g. 3)
/// pk    = public key h = g^sk, public input
/// rand  = y in [0,255] (u256 nonce)
/// ret   = [c1, c2]   ciphertext
pub fn encrypt(g: Field, pk: Field, msg: [Field; 2], rand: Field) -> [Field; 2] {
    let g_pow_y: Field = pow(g, rand);
    let h_pow_y: Field = pow(pk, rand);

    let c1: Field = msg[0] * g_pow_y;
    assert(c1 != 0, "C1 must be non-zero");

    let c2: Field = msg[1] * h_pow_y;
    [c1, c2]
}

/// Minimal ElGamal partial-decryption for one card.
///
/// g           = generator  (Field, e.g. 3)
/// ciphertext  = [c1, c2]   ciphertext input, public input
/// sk          = secret key x (Field, u256)
/// ret         = (pk, [c1, m]) where pk = g^x and m = c2 / c1^x
pub fn decrypt(g: Field, ciphertext: [Field; 2], sk: Field) -> (Field, [Field; 2]) {
    // pk  = g^sk
    let pk: Field = pow(g, sk);

    // c1^sk
    let card_exp: Field = pow(ciphertext[0], sk);

    // message[0] stays as c1
    let m1: Field = ciphertext[0];

    // message[1] = c2 / c1^sk
    let m2: Field = ciphertext[1] / card_exp;

    // equality constraint   m2 * card_exp == c2
    assert(m2 * card_exp == ciphertext[1]);

    (pk, [m1, m2])
}

#[test]
fn test_encrypt_single_card() {
    let g: Field = 3;
    let sk: Field = 17;
    let h: Field = pow(g, sk); // public key h = g^sk

    let plain: [Field; 2] = [1, 42];
    let rand: Field = 77.into(); // fresh nonce

    let ct = encrypt(g, h, plain, rand);

    // C1 should equal g^rand
    assert(ct[0] == pow(g, rand));

    // C2 should equal 42 * h^rand
    let expected_c2 = 42 * pow(h, rand);
    assert(ct[1] == expected_c2);
}

#[test]
fn test_encrypt_then_decrypt_once() {
    let g: Field = 3;

    // secret key and derived public key
    let sk: Field = 22.into();
    let pk: Field = pow(g, sk);

    // plaintext card  (fresh card => [1, m])
    let plain: [Field; 2] = [1, 99];

    // encrypt with random y
    let rand: Field = 77.into();
    let ct = encrypt(g, pk, plain, rand);

    // decrypt
    let (recovered_pk, msg) = decrypt(g, ct, sk);

    // pk round-trip check
    assert(recovered_pk == pk);

    // message limb (index 1) should equal original m = 99
    assert(msg[1] == plain[1]);

    // the first limb is still c1 = g^rand, so this holds instead:
    assert(msg[0] == ct[0]);
}

#[test]
pub fn test_2_layered_onion_encryption_decryption() {
    // Generator value and secret keys
    let g: Field = 3; // Example generator
    let sk1: Field = 22.into(); // Player 1's secret key
    let sk2: Field = 33.into(); // Player 2's secret key

    // Initial aggregated key (starts with 1)
    let old_aggk: Field = 1.into();

    // Generate public keys and aggregated key using the new function
    let (pk1, agg_pk1) = gen_public_key_and_aggregate_key(g, sk1, old_aggk); // Player 1's public key and aggregated key
    let (pk2, agg_pk2) = gen_public_key_and_aggregate_key(g, sk2, agg_pk1); // Player 2's public key and aggregated key

    // At this point, agg_pk2 is the final aggregated public key
    let agg_pk: Field = agg_pk2; // The final aggregated public key after both players

    // Initial message (fresh card with 1 and message m)
    let m: Field = 99.into();
    let plain: [Field; 2] = [1.into(), m]; // Initial message is [1, m]

    // Player 1 encrypts the message using the aggregate public key
    let rand1: Field = 77.into(); // Random value for Player 1
    let ct1 = encrypt(g, agg_pk, plain, rand1);
    // println(f"Player 1 encryption (ct1): {ct1}");

    // Player 2 encrypts the ciphertext (ct1) using the aggregate public key
    let rand2: Field = 88.into(); // Random value for Player 2
    let ct2 = encrypt(g, agg_pk, ct1, rand2);
    // println(f"Player 2 encryption (ct2): {ct2}");

    // Player 2 decrypts the ciphertext (ct2) using their secret key sk2
    let (recovered_pk2, msg2) = decrypt(g, ct2, sk2);
    // println(f"Player 2 decryption (msg2): {msg2}");
    // println(f"Recovered public key (Player 2): {recovered_pk2}");

    // Player 1 decrypts the ciphertext (msg2) using their secret key sk1 to get back the original message
    let (recovered_pk1, msg3) = decrypt(g, msg2, sk1);
    // println(f"Player 1 decryption (msg3): {msg3}");
    // println(f"Recovered public key (Player 1): {recovered_pk1}");

    assert(recovered_pk2 == pk2, "Decrypted public key does not match original public key");
    assert(recovered_pk1 == pk1, "Decrypted public key does not match original public key");

    // Verifying that the final decrypted message matches the original plaintext
    assert(msg3[1] == m, "Decrypted message does not match original message");
}

#[test]
pub fn test_3_layered_onion_encryption_decryption() {
    // Generator value and secret keys
    let g: Field = 3; // Example generator
    let sk1: Field = 22.into(); // Player 1's secret key
    let sk2: Field = 33.into(); // Player 2's secret key
    let sk3: Field = 44.into(); // Player 3's secret key

    // Initial aggregated key (starts with 1)
    let old_aggk: Field = 1.into();

    // Generate public keys and aggregated key using the new function
    let (pk1, agg_pk1) = gen_public_key_and_aggregate_key(g, sk1, old_aggk); // Player 1's public key and aggregated key
    let (pk2, agg_pk2) = gen_public_key_and_aggregate_key(g, sk2, agg_pk1); // Player 2's public key and aggregated key
    let (pk3, agg_pk3) = gen_public_key_and_aggregate_key(g, sk3, agg_pk2); // Player 3's public key and aggregated key

    // At this point, agg_pk3 is the final aggregated public key
    let agg_pk: Field = agg_pk3; // The final aggregated public key after all players

    // Initial message (fresh card with 1 and message m)
    let m: Field = 1234567890.into();
    let plain: [Field; 2] = [1.into(), m]; // Initial message is [1, m]

    // Player 1 encrypts the message using the aggregate public key
    let rand1: Field = 77.into(); // Random value for Player 1
    let ct1 = encrypt(g, agg_pk, plain, rand1);
    // println(f"Player 1 encryption (ct1): {ct1}");

    // Player 2 encrypts the ciphertext (ct1) using the aggregate public key
    let rand2: Field = 88.into(); // Random value for Player 2
    let ct2 = encrypt(g, agg_pk, ct1, rand2);
    // println(f"Player 2 encryption (ct2): {ct2}");

    // Player 3 encrypts the ciphertext (ct2) using the aggregate public key
    let rand3: Field = 99.into(); // Random value for Player 3
    let ct3 = encrypt(g, agg_pk, ct2, rand3);
    // println(f"Player 3 encryption (ct3): {ct3}");

    // Player 3 decrypts the ciphertext (ct3) using their secret key sk3
    let (recovered_pk3, msg3) = decrypt(g, ct3, sk3);
    // println(f"Player 3 decryption (msg3): {msg3}");
    // println(f"Recovered public key (Player 3): {recovered_pk3}");

    // Player 2 decrypts the ciphertext (msg3) using their secret key sk2
    let (recovered_pk2, msg2) = decrypt(g, msg3, sk2);
    // println(f"Player 2 decryption (msg2): {msg2}");
    // println(f"Recovered public key (Player 2): {recovered_pk2}");

    // Player 1 decrypts the ciphertext (msg2) using their secret key sk1 to get back the original message
    let (recovered_pk1, msg1) = decrypt(g, msg2, sk1);
    // println(f"Player 1 decryption (msg1): {msg1}");
    // println(f"Recovered public key (Player 1): {recovered_pk1}");

    assert(recovered_pk3 == pk3, "Decrypted public key does not match original public key");
    assert(recovered_pk2 == pk2, "Decrypted public key does not match original public key");
    assert(recovered_pk1 == pk1, "Decrypted public key does not match original public key");

    // Verifying that the final decrypted message matches the original plaintext
    assert(msg1[1] == m, "Decrypted message does not match original message");
}

#[test]
pub fn test_calculate_decrypt_component_matches_direct_decrypt_2_layered_onion_encryption_decryption() {
    let g: Field = 3;
    let sk1: Field = 11.into();
    let sk2: Field = 22.into();

    // Start with aggregate key = 1, then sequentially add each pk
    let old_aggk: Field = 1.into();
    let (_pk1, agg_pk1) = gen_public_key_and_aggregate_key(g, sk1, old_aggk);
    let (_pk2, agg_pk) = gen_public_key_and_aggregate_key(g, sk2, agg_pk1); // Final aggregate pk = g^{sk1 + sk2}

    let m: Field = 64.into();
    let plain: [Field; 2] = [1.into(), m];
    let rand: Field = 77.into();

    let ciphertext = encrypt(g, agg_pk, plain, rand);
    let c1 = ciphertext[0];
    let c2 = ciphertext[1];

    // Each player computes their decrypt component
    let share1 = calculate_decrypt_component(c1, sk1); // c1^sk1
    let share2 = calculate_decrypt_component(c1, sk2); // c1^sk2

    // Combine shares: m = c2 / (share1 * share2)
    let decrypted_msg = c2 / share1 / share2;
    println(f"Decryption Result: got {decrypted_msg}, expected {m}");

    // Check correctness
    assert(decrypted_msg == m, f"Decryption failed: got {decrypted_msg}, expected {m}");
}
