use crate::algebra::enforce_perm_n10;
use crate::algebra::matrix::mul_4x4_by_4x2;
use crate::elgamal::{decrypt_u256, encrypt_u256};
use crate::utils::gen_public_key_and_aggregate_key;

pub fn encrypt_and_shuffle_4_cards(
    g: Field,
    agg_pk: Field,
    deck: [[Field; 2]; 4],
    randomness: [Field; 4],
    permutation_matrix: [[Field; 4]; 4],
) -> [[Field; 2]; 4] {
    let mut extended_permutation_matrix: [[Field; 10]; 10] = [[0; 10]; 10];
    for i in 0..4 {
        for j in 0..4 {
            extended_permutation_matrix[i][j] = permutation_matrix[i][j];
        }
    }

    enforce_perm_n10(extended_permutation_matrix, 4);

    let mut encrypted_deck: [[Field; 2]; 4] = [[0, 0]; 4];
    for i in 0..4 {
        let encrypted_card = encrypt_u256(g, agg_pk, [deck[i][0], deck[i][1]], randomness[i]);
        encrypted_deck[i][0] = encrypted_card[0];
        encrypted_deck[i][1] = encrypted_card[1];
    }

    let shuffled_deck = mul_4x4_by_4x2(permutation_matrix, encrypted_deck);

    shuffled_deck
}

pub fn decrypt_4_cards(
    generator: Field,
    deck_to_unmask: [[Field; 2]; 4],
    sk: Field,
) -> ([[Field; 2]; 4], Field) {
    let mut unmasked_deck: [[Field; 2]; 4] = [[0; 2]; 4];
    let mut pk: Field = 0;

    for i in 0..4 {
        let (card_pk, decrypted_card) = decrypt_u256(generator, deck_to_unmask[i], sk);
        unmasked_deck[i][0] = decrypted_card[0];
        unmasked_deck[i][1] = decrypted_card[1];

        // Set the public key from the first card
        if i == 0 {
            pk = card_pk;
        }
    }

    (unmasked_deck, pk)
}

#[test]
pub fn test_1_layered_encrypt_and_shuffle_4_cards() {
    // Generator value and secret keys
    let g: Field = 3; // Example generator
    let sk: Field = 22.into(); // Secret key for decryption

    // Example deck (4 cards) with initial values [1, m]
    let deck: [[Field; 2]; 4] = [
        [1.into(), 10.into()],
        [1.into(), 20.into()],
        [1.into(), 30.into()],
        [1.into(), 40.into()],
    ];

    // Randomness values for encryption
    let randomness: [Field; 4] = [77.into(), 88.into(), 99.into(), 111.into()];

    // Identity permutation matrix (4x4) for simplicity
    let permutation_matrix: [[Field; 4]; 4] = [
        [1.into(), 0.into(), 0.into(), 0.into()],
        [0.into(), 0.into(), 0.into(), 1.into()],
        [0.into(), 1.into(), 0.into(), 0.into()],
        [0.into(), 0.into(), 1.into(), 0.into()],
    ];

    // Generate public key and aggregated key using the new function
    let (_, agg_pk) = gen_public_key_and_aggregate_key(g, sk, 1.into()); // Aggregate public key

    // Encrypt and shuffle the deck
    let shuffled_encrypted_deck =
        encrypt_and_shuffle_4_cards(g, agg_pk, deck, randomness, permutation_matrix);
    // println(f"Shuffled and Encrypted Deck: {shuffled_encrypted_deck}");

    // Decrypt the shuffled deck using the secret key
    let (unmasked_deck, _) = decrypt_4_cards(g, shuffled_encrypted_deck, sk);
    // println(f"Unmasked Deck after Decryption: {unmasked_deck}");

    // Debugging output to track values at each step
    for i in 0..4 {
        let deck_i_second = deck[i][1];
        let unmasked_deck_i_second = unmasked_deck[i][1];
        let i_plus_1 = i + 1;
        println(
            f"Original card {i_plus_1}: {deck_i_second}, Decrypted card {i_plus_1}: {unmasked_deck_i_second}",
        );
    }

    assert(unmasked_deck[0][1] == deck[0][1]);
    assert(unmasked_deck[1][1] == deck[3][1]);
    assert(unmasked_deck[2][1] == deck[1][1]);
    assert(unmasked_deck[3][1] == deck[2][1]);
}

#[test]
pub fn test_4_layered_encrypt_and_shuffle_4_cards_with_multiple_shuffles() {
    // Generator value and secret keys
    let g: Field = 3; // Example generator
    let sk1: Field = 22.into(); // Player 1's secret key
    let sk2: Field = 33.into(); // Player 2's secret key
    let sk3: Field = 44.into(); // Player 3's secret key
    let sk4: Field = 55.into(); // Player 4's secret key

    // Example deck (4 cards) with initial values [1, m]
    let deck: [[Field; 2]; 4] =
        [[1.into(), 1.into()], [1.into(), 2.into()], [1.into(), 3.into()], [1.into(), 4.into()]];

    // Randomness values for encryption
    let randomness1: [Field; 4] = [
        53487589437593485734.into(),
        54353456564565645345.into(),
        543534553656456456.into(),
        5465654634543534534453345.into(),
    ];
    let randomness2: [Field; 4] = [
        667567456534645.into(),
        543534565665465545645645665645345.into(),
        5435345656456353656456456.into(),
        5465654654534534534543534534453345.into(),
    ];
    let randomness3: [Field; 4] = [
        6456455634543534.into(),
        625436356536.into(),
        674567466345634534.into(),
        76745634556345345346.into(),
    ];
    let randomness4: [Field; 4] = [
        78658456753463456.into(),
        7864575464352345.into(),
        35425465745676467.into(),
        675467456656456456.into(),
    ];

    // Identity permutation matrix (4x4) for simplicity
    let permutation_matrix1: [[Field; 4]; 4] =
        [[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]];
    let permutation_matrix2: [[Field; 4]; 4] =
        [[0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1], [1, 0, 0, 0]];
    let permutation_matrix3: [[Field; 4]; 4] =
        [[0, 0, 0, 1], [0, 0, 1, 0], [0, 1, 0, 0], [1, 0, 0, 0]];
    let permutation_matrix4: [[Field; 4]; 4] =
        [[0, 0, 1, 0], [0, 0, 0, 1], [0, 1, 0, 0], [1, 0, 0, 0]];

    // Generate public keys and aggregated key for four players
    let (_, agg_pk1) = gen_public_key_and_aggregate_key(g, sk1, 1.into()); // Player 1's public key and aggregated key
    let (_, agg_pk2) = gen_public_key_and_aggregate_key(g, sk2, agg_pk1); // Player 2's public key and aggregated key
    let (_, agg_pk3) = gen_public_key_and_aggregate_key(g, sk3, agg_pk2); // Player 3's public key and aggregated key
    let (_, agg_pk4) = gen_public_key_and_aggregate_key(g, sk4, agg_pk3); // Player 4's public key and aggregated key

    // The final aggregate public key after all players
    let agg_pk: Field = agg_pk4; // Aggregate public key

    // Encrypt and shuffle the deck with 4 layers, shuffle the deck between each layer
    let shuffled_encrypted_deck1 =
        encrypt_and_shuffle_4_cards(g, agg_pk, deck, randomness1, permutation_matrix1);
    // println(
    //     f"Shuffled and Encrypted Deck after Player 1 Encryption: {shuffled_encrypted_deck1}",
    // );

    // Player 2 encrypts the shuffled deck (with a re-shuffle)
    let shuffled_encrypted_deck2 = encrypt_and_shuffle_4_cards(
        g,
        agg_pk,
        shuffled_encrypted_deck1,
        randomness2,
        permutation_matrix2,
    );
    // println(
    //     f"Shuffled and Encrypted Deck after Player 2 Encryption: {shuffled_encrypted_deck2}",
    // );

    // Player 3 encrypts the shuffled deck (with a re-shuffle)
    let shuffled_encrypted_deck3 = encrypt_and_shuffle_4_cards(
        g,
        agg_pk,
        shuffled_encrypted_deck2,
        randomness3,
        permutation_matrix3,
    );
    // println(
    //     f"Shuffled and Encrypted Deck after Player 3 Encryption: {shuffled_encrypted_deck3}",
    // );

    // Player 4 encrypts the shuffled deck (with a re-shuffle)
    let shuffled_encrypted_deck4 = encrypt_and_shuffle_4_cards(
        g,
        agg_pk,
        shuffled_encrypted_deck3,
        randomness4,
        permutation_matrix4,
    );
    // println(
    //     f"Shuffled and Encrypted Deck after Player 4 Encryption: {shuffled_encrypted_deck4}",
    // );

    // Player 4 decrypts the shuffled deck using their secret key
    let (unmasked_deck4, _) = decrypt_4_cards(g, shuffled_encrypted_deck4, sk4);
    // println(f"Unmasked Deck after Player 4 Decryption: {unmasked_deck4}");

    // Player 3 decrypts the deck after Player 4's decryption using Player 3's secret key
    let (unmasked_deck3, _) = decrypt_4_cards(g, unmasked_deck4, sk3);
    // println(f"Unmasked Deck after Player 3 Decryption: {unmasked_deck3}");

    // Player 2 decrypts the deck after Player 3's decryption using Player 2's secret key
    let (unmasked_deck2, _) = decrypt_4_cards(g, unmasked_deck3, sk2);
    // println(f"Unmasked Deck after Player 2 Decryption: {unmasked_deck2}");

    // Player 1 decrypts the deck after Player 2's decryption using Player 1's secret key
    let (unmasked_deck1, _) = decrypt_4_cards(g, unmasked_deck2, sk1);
    // println(f"Unmasked Deck after Player 1 Decryption: {unmasked_deck1}");

    // Debugging output to track values at each step
    for i in 0..4 {
        let deck_i_second = deck[i][1];
        let unmasked_deck_i_second = unmasked_deck1[i][1];
        let i_plus_1 = i + 1;
        println(
            f"Original card {i_plus_1}: {deck_i_second}, Decrypted card {i_plus_1}: {unmasked_deck_i_second}",
        );
    }

    assert(unmasked_deck1[0][1] == deck[2][1]);
    assert(unmasked_deck1[1][1] == deck[1][1]);
    assert(unmasked_deck1[2][1] == deck[3][1]);
    assert(unmasked_deck1[3][1] == deck[0][1]);
}
