use crate::algebra::enforce_perm_n10;
use crate::algebra::matrix::{
    mul_10x10_by_10x2, mul_4x4_by_4x2, mul_5x5_by_5x2, mul_6x6_by_6x2, mul_7x7_by_7x2,
    mul_8x8_by_8x2, mul_9x9_by_9x2,
};
use crate::elgamal::{calculate_decrypt_component, decrypt, encrypt};
use crate::utils::gen_public_key_and_aggregate_key;

pub fn encrypt_and_shuffle_4_cards(
    g: Field,
    agg_pk: Field, // public input
    deck: [[Field; 2]; 4], // public input
    randomness: [Field; 4],
    permutation_matrix: [[Field; 4]; 4],
) -> [[Field; 2]; 4] {
    assert(g != 0, "generator g must be non‑zero");
    assert(agg_pk != 0, "aggregate public key must be non‑zero");

    let mut extended_permutation_matrix: [[Field; 10]; 10] = [[0; 10]; 10];
    for i in 0..4 {
        for j in 0..4 {
            extended_permutation_matrix[i][j] = permutation_matrix[i][j];
        }
    }

    enforce_perm_n10(extended_permutation_matrix, 4);

    let mut encrypted_deck: [[Field; 2]; 4] = [[0, 0]; 4];
    for i in 0..4 {
        let encrypted_card = encrypt(g, agg_pk, [deck[i][0], deck[i][1]], randomness[i]);
        encrypted_deck[i][0] = encrypted_card[0];
        encrypted_deck[i][1] = encrypted_card[1];
    }

    let shuffled_deck = mul_4x4_by_4x2(permutation_matrix, encrypted_deck);

    shuffled_deck
}

pub fn encrypt_and_shuffle_5_cards(
    g: Field,
    agg_pk: Field, // public input
    deck: [[Field; 2]; 5], // public input
    randomness: [Field; 5],
    permutation_matrix: [[Field; 5]; 5],
) -> [[Field; 2]; 5] {
    assert(g != 0, "generator g must be non‑zero");
    assert(agg_pk != 0, "aggregate public key must be non‑zero");

    let mut extended_permutation_matrix: [[Field; 10]; 10] = [[0; 10]; 10];
    for i in 0..5 {
        for j in 0..5 {
            extended_permutation_matrix[i][j] = permutation_matrix[i][j];
        }
    }

    enforce_perm_n10(extended_permutation_matrix, 5);

    let mut encrypted_deck: [[Field; 2]; 5] = [[0, 0]; 5];
    for i in 0..5 {
        let encrypted_card = encrypt(g, agg_pk, [deck[i][0], deck[i][1]], randomness[i]);
        encrypted_deck[i][0] = encrypted_card[0];
        encrypted_deck[i][1] = encrypted_card[1];
    }

    let shuffled_deck = mul_5x5_by_5x2(permutation_matrix, encrypted_deck);

    shuffled_deck
}

pub fn encrypt_and_shuffle_6_cards(
    g: Field,
    agg_pk: Field, // public input
    deck: [[Field; 2]; 6], // public input
    randomness: [Field; 6],
    permutation_matrix: [[Field; 6]; 6],
) -> [[Field; 2]; 6] {
    assert(g != 0, "generator g must be non‑zero");
    assert(agg_pk != 0, "aggregate public key must be non‑zero");

    let mut extended_permutation_matrix: [[Field; 10]; 10] = [[0; 10]; 10];
    for i in 0..6 {
        for j in 0..6 {
            extended_permutation_matrix[i][j] = permutation_matrix[i][j];
        }
    }

    enforce_perm_n10(extended_permutation_matrix, 6);

    let mut encrypted_deck: [[Field; 2]; 6] = [[0, 0]; 6];
    for i in 0..6 {
        let encrypted_card = encrypt(g, agg_pk, [deck[i][0], deck[i][1]], randomness[i]);
        encrypted_deck[i][0] = encrypted_card[0];
        encrypted_deck[i][1] = encrypted_card[1];
    }

    let shuffled_deck = mul_6x6_by_6x2(permutation_matrix, encrypted_deck);

    shuffled_deck
}

pub fn encrypt_and_shuffle_7_cards(
    g: Field,
    agg_pk: Field, // public input
    deck: [[Field; 2]; 7], // public input
    randomness: [Field; 7],
    permutation_matrix: [[Field; 7]; 7],
) -> [[Field; 2]; 7] {
    assert(g != 0, "generator g must be non‑zero");
    assert(agg_pk != 0, "aggregate public key must be non‑zero");

    let mut extended_permutation_matrix: [[Field; 10]; 10] = [[0; 10]; 10];
    for i in 0..7 {
        for j in 0..7 {
            extended_permutation_matrix[i][j] = permutation_matrix[i][j];
        }
    }

    enforce_perm_n10(extended_permutation_matrix, 7);

    let mut encrypted_deck: [[Field; 2]; 7] = [[0, 0]; 7];
    for i in 0..7 {
        let encrypted_card = encrypt(g, agg_pk, [deck[i][0], deck[i][1]], randomness[i]);
        encrypted_deck[i][0] = encrypted_card[0];
        encrypted_deck[i][1] = encrypted_card[1];
    }

    let shuffled_deck = mul_7x7_by_7x2(permutation_matrix, encrypted_deck);

    shuffled_deck
}

pub fn encrypt_and_shuffle_8_cards(
    g: Field,
    agg_pk: Field, // public input
    deck: [[Field; 2]; 8], // public input
    randomness: [Field; 8],
    permutation_matrix: [[Field; 8]; 8],
) -> [[Field; 2]; 8] {
    assert(g != 0, "generator g must be non‑zero");
    assert(agg_pk != 0, "aggregate public key must be non‑zero");

    let mut extended_permutation_matrix: [[Field; 10]; 10] = [[0; 10]; 10];
    for i in 0..8 {
        for j in 0..8 {
            extended_permutation_matrix[i][j] = permutation_matrix[i][j];
        }
    }

    enforce_perm_n10(extended_permutation_matrix, 8);

    let mut encrypted_deck: [[Field; 2]; 8] = [[0, 0]; 8];
    for i in 0..8 {
        let encrypted_card = encrypt(g, agg_pk, [deck[i][0], deck[i][1]], randomness[i]);
        encrypted_deck[i][0] = encrypted_card[0];
        encrypted_deck[i][1] = encrypted_card[1];
    }

    let shuffled_deck = mul_8x8_by_8x2(permutation_matrix, encrypted_deck);

    shuffled_deck
}

pub fn encrypt_and_shuffle_9_cards(
    g: Field,
    agg_pk: Field, // public input
    deck: [[Field; 2]; 9], // public input
    randomness: [Field; 9],
    permutation_matrix: [[Field; 9]; 9],
) -> [[Field; 2]; 9] {
    assert(g != 0, "generator g must be non‑zero");
    assert(agg_pk != 0, "aggregate public key must be non‑zero");

    let mut extended_permutation_matrix: [[Field; 10]; 10] = [[0; 10]; 10];
    for i in 0..9 {
        for j in 0..9 {
            extended_permutation_matrix[i][j] = permutation_matrix[i][j];
        }
    }

    enforce_perm_n10(extended_permutation_matrix, 9);

    let mut encrypted_deck: [[Field; 2]; 9] = [[0, 0]; 9];
    for i in 0..9 {
        let encrypted_card = encrypt(g, agg_pk, [deck[i][0], deck[i][1]], randomness[i]);
        encrypted_deck[i][0] = encrypted_card[0];
        encrypted_deck[i][1] = encrypted_card[1];
    }

    let shuffled_deck = mul_9x9_by_9x2(permutation_matrix, encrypted_deck);

    shuffled_deck
}

pub fn encrypt_and_shuffle_10_cards(
    g: Field,
    agg_pk: Field, // public input
    deck: [[Field; 2]; 10], // public input
    randomness: [Field; 10],
    permutation_matrix: [[Field; 10]; 10],
) -> [[Field; 2]; 10] {
    assert(g != 0, "generator g must be non‑zero");
    assert(agg_pk != 0, "aggregate public key must be non‑zero");

    let mut extended_permutation_matrix: [[Field; 10]; 10] = [[0; 10]; 10];
    for i in 0..10 {
        for j in 0..10 {
            extended_permutation_matrix[i][j] = permutation_matrix[i][j];
        }
    }

    enforce_perm_n10(extended_permutation_matrix, 10);

    let mut encrypted_deck: [[Field; 2]; 10] = [[0, 0]; 10];
    for i in 0..10 {
        let encrypted_card = encrypt(g, agg_pk, [deck[i][0], deck[i][1]], randomness[i]);
        encrypted_deck[i][0] = encrypted_card[0];
        encrypted_deck[i][1] = encrypted_card[1];
    }

    let shuffled_deck = mul_10x10_by_10x2(permutation_matrix, encrypted_deck);

    shuffled_deck
}

pub fn decrypt_4_cards(
    generator: Field,
    deck_to_unmask: [[Field; 2]; 4], // public input
    sk: Field,
) -> ([[Field; 2]; 4], Field) {
    let mut unmasked_deck: [[Field; 2]; 4] = [[0; 2]; 4];
    let mut pk: Field = 0;

    for i in 0..4 {
        let (card_pk, decrypted_card) = decrypt(generator, deck_to_unmask[i], sk);
        unmasked_deck[i][0] = decrypted_card[0];
        unmasked_deck[i][1] = decrypted_card[1];

        // Set the public key from the first card
        if i == 0 {
            pk = card_pk;
        }
    }

    (unmasked_deck, pk)
}

pub fn decrypt_5_cards(
    generator: Field,
    deck_to_unmask: [[Field; 2]; 5], // public input
    sk: Field,
) -> ([[Field; 2]; 5], Field) {
    let mut unmasked_deck: [[Field; 2]; 5] = [[0; 2]; 5];
    let mut pk: Field = 0;

    for i in 0..5 {
        let (card_pk, decrypted_card) = decrypt(generator, deck_to_unmask[i], sk);
        unmasked_deck[i][0] = decrypted_card[0];
        unmasked_deck[i][1] = decrypted_card[1];

        // Set the public key from the first card
        if i == 0 {
            pk = card_pk;
        }
    }

    (unmasked_deck, pk)
}

pub fn decrypt_6_cards(
    generator: Field,
    deck_to_unmask: [[Field; 2]; 6], // public input
    sk: Field,
) -> ([[Field; 2]; 6], Field) {
    let mut unmasked_deck: [[Field; 2]; 6] = [[0; 2]; 6];
    let mut pk: Field = 0;

    for i in 0..6 {
        let (card_pk, decrypted_card) = decrypt(generator, deck_to_unmask[i], sk);
        unmasked_deck[i][0] = decrypted_card[0];
        unmasked_deck[i][1] = decrypted_card[1];

        // Set the public key from the first card
        if i == 0 {
            pk = card_pk;
        }
    }

    (unmasked_deck, pk)
}

pub fn decrypt_7_cards(
    generator: Field,
    deck_to_unmask: [[Field; 2]; 7], // public input
    sk: Field,
) -> ([[Field; 2]; 7], Field) {
    let mut unmasked_deck: [[Field; 2]; 7] = [[0; 2]; 7];
    let mut pk: Field = 0;

    for i in 0..7 {
        let (card_pk, decrypted_card) = decrypt(generator, deck_to_unmask[i], sk);
        unmasked_deck[i][0] = decrypted_card[0];
        unmasked_deck[i][1] = decrypted_card[1];

        // Set the public key from the first card
        if i == 0 {
            pk = card_pk;
        }
    }

    (unmasked_deck, pk)
}

pub fn decrypt_8_cards(
    generator: Field,
    deck_to_unmask: [[Field; 2]; 8], // public input
    sk: Field,
) -> ([[Field; 2]; 8], Field) {
    let mut unmasked_deck: [[Field; 2]; 8] = [[0; 2]; 8];
    let mut pk: Field = 0;

    for i in 0..8 {
        let (card_pk, decrypted_card) = decrypt(generator, deck_to_unmask[i], sk);
        unmasked_deck[i][0] = decrypted_card[0];
        unmasked_deck[i][1] = decrypted_card[1];

        // Set the public key from the first card
        if i == 0 {
            pk = card_pk;
        }
    }

    (unmasked_deck, pk)
}

pub fn decrypt_9_cards(
    generator: Field,
    deck_to_unmask: [[Field; 2]; 9], // public input
    sk: Field,
) -> ([[Field; 2]; 9], Field) {
    let mut unmasked_deck: [[Field; 2]; 9] = [[0; 2]; 9];
    let mut pk: Field = 0;

    for i in 0..9 {
        let (card_pk, decrypted_card) = decrypt(generator, deck_to_unmask[i], sk);
        unmasked_deck[i][0] = decrypted_card[0];
        unmasked_deck[i][1] = decrypted_card[1];

        // Set the public key from the first card
        if i == 0 {
            pk = card_pk;
        }
    }

    (unmasked_deck, pk)
}

pub fn decrypt_10_cards(
    generator: Field,
    deck_to_unmask: [[Field; 2]; 10], // public input
    sk: Field,
) -> ([[Field; 2]; 10], Field) {
    let mut unmasked_deck: [[Field; 2]; 10] = [[0; 2]; 10];
    let mut pk: Field = 0;

    for i in 0..10 {
        let (card_pk, decrypted_card) = decrypt(generator, deck_to_unmask[i], sk);
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
    let sk: Field = 22; // Secret key for decryption

    // Example deck (4 cards) with initial values [1, m]
    let deck: [[Field; 2]; 4] = [[1, 10], [1, 20], [1, 30], [1, 40]];

    // Randomness values for encryption
    let randomness: [Field; 4] = [77, 88, 99, 111];

    let permutation_matrix: [[Field; 4]; 4] =
        [[1, 0, 0, 0], [0, 0, 0, 1], [0, 1, 0, 0], [0, 0, 1, 0]];

    // Generate public key and aggregated key using the new function
    let (_, agg_pk) = gen_public_key_and_aggregate_key(g, sk, 1); // Aggregate public key

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
pub fn test_1_layered_encrypt_and_shuffle_5_cards() {
    // Generator value and secret keys
    let g: Field = 3; // Example generator
    let sk: Field = 22; // Secret key for decryption

    // Example deck (5 cards) with initial values [1, m]
    let deck: [[Field; 2]; 5] = [[1, 10], [1, 20], [1, 30], [1, 40], [1, 50]];

    // Randomness values for encryption
    let randomness: [Field; 5] = [77, 88, 99, 111, 222];

    let permutation_matrix: [[Field; 5]; 5] =
        [[1, 0, 0, 0, 0], [0, 0, 0, 1, 0], [0, 1, 0, 0, 0], [0, 0, 1, 0, 0], [0, 0, 0, 0, 1]];

    // Generate public key and aggregated key using the new function
    let (_, agg_pk) = gen_public_key_and_aggregate_key(g, sk, 1); // Aggregate public key

    // Encrypt and shuffle the deck
    let shuffled_encrypted_deck =
        encrypt_and_shuffle_5_cards(g, agg_pk, deck, randomness, permutation_matrix);
    // println(f"Shuffled and Encrypted Deck: {shuffled_encrypted_deck}");

    // Decrypt the shuffled deck using the secret key
    let (unmasked_deck, _) = decrypt_5_cards(g, shuffled_encrypted_deck, sk);
    // println(f"Unmasked Deck after Decryption: {unmasked_deck}");

    // Debugging output to track values at each step
    for i in 0..5 {
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
    assert(unmasked_deck[4][1] == deck[4][1]);
}

#[test]
pub fn test_1_layered_encrypt_and_shuffle_6_cards() {
    // Generator value and secret keys
    let g: Field = 3; // Example generator
    let sk: Field = 22; // Secret key for decryption

    // Example deck (5 cards) with initial values [1, m]
    let deck: [[Field; 2]; 6] = [[1, 10], [1, 20], [1, 30], [1, 40], [1, 50], [1, 60]];

    // Randomness values for encryption
    let randomness: [Field; 6] = [77, 88, 99, 111, 222, 333];

    let permutation_matrix: [[Field; 6]; 6] = [
        [0, 1, 0, 0, 0, 0],
        [0, 0, 0, 1, 0, 0],
        [1, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 1],
        [0, 0, 1, 0, 0, 0],
        [0, 0, 0, 0, 1, 0],
    ];

    // Generate public key and aggregated key using the new function
    let (_, agg_pk) = gen_public_key_and_aggregate_key(g, sk, 1); // Aggregate public key

    // Encrypt and shuffle the deck
    let shuffled_encrypted_deck =
        encrypt_and_shuffle_6_cards(g, agg_pk, deck, randomness, permutation_matrix);
    // println(f"Shuffled and Encrypted Deck: {shuffled_encrypted_deck}");

    // Decrypt the shuffled deck using the secret key
    let (unmasked_deck, _) = decrypt_6_cards(g, shuffled_encrypted_deck, sk);
    // println(f"Unmasked Deck after Decryption: {unmasked_deck}");

    // Debugging output to track values at each step
    for i in 0..6 {
        let deck_i_second = deck[i][1];
        let unmasked_deck_i_second = unmasked_deck[i][1];
        let i_plus_1 = i + 1;
        println(
            f"Original card {i_plus_1}: {deck_i_second}, Decrypted card {i_plus_1}: {unmasked_deck_i_second}",
        );
    }

    assert(unmasked_deck[0][1] == deck[1][1]);
    assert(unmasked_deck[1][1] == deck[3][1]);
    assert(unmasked_deck[2][1] == deck[0][1]);
    assert(unmasked_deck[3][1] == deck[5][1]);
    assert(unmasked_deck[4][1] == deck[2][1]);
    assert(unmasked_deck[5][1] == deck[4][1]);
}

#[test]
pub fn test_1_layered_encrypt_and_shuffle_7_cards() {
    // Generator value and secret keys
    let g: Field = 3; // Example generator
    let sk: Field = 22; // Secret key for decryption

    // Example deck (5 cards) with initial values [1, m]
    let deck: [[Field; 2]; 7] = [[1, 10], [1, 20], [1, 30], [1, 40], [1, 50], [1, 60], [1, 70]];

    // Randomness values for encryption
    let randomness: [Field; 7] = [77, 88, 99, 111, 222, 333, 444];

    let permutation_matrix: [[Field; 7]; 7] = [
        [0, 0, 0, 0, 1, 0, 0],
        [1, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 1, 0],
        [0, 0, 0, 0, 0, 0, 1],
        [0, 0, 1, 0, 0, 0, 0],
        [0, 1, 0, 0, 0, 0, 0],
        [0, 0, 0, 1, 0, 0, 0],
    ];

    // Generate public key and aggregated key using the new function
    let (_, agg_pk) = gen_public_key_and_aggregate_key(g, sk, 1); // Aggregate public key

    // Encrypt and shuffle the deck
    let shuffled_encrypted_deck =
        encrypt_and_shuffle_7_cards(g, agg_pk, deck, randomness, permutation_matrix);
    // println(f"Shuffled and Encrypted Deck: {shuffled_encrypted_deck}");

    // Decrypt the shuffled deck using the secret key
    let (unmasked_deck, _) = decrypt_7_cards(g, shuffled_encrypted_deck, sk);
    // println(f"Unmasked Deck after Decryption: {unmasked_deck}");

    // Debugging output to track values at each step
    for i in 0..7 {
        let deck_i_second = deck[i][1];
        let unmasked_deck_i_second = unmasked_deck[i][1];
        let i_plus_1 = i + 1;
        println(
            f"Original card {i_plus_1}: {deck_i_second}, Decrypted card {i_plus_1}: {unmasked_deck_i_second}",
        );
    }

    assert(unmasked_deck[0][1] == deck[4][1]);
    assert(unmasked_deck[1][1] == deck[0][1]);
    assert(unmasked_deck[2][1] == deck[5][1]);
    assert(unmasked_deck[3][1] == deck[6][1]);
    assert(unmasked_deck[4][1] == deck[2][1]);
    assert(unmasked_deck[5][1] == deck[1][1]);
    assert(unmasked_deck[6][1] == deck[3][1]);
}

#[test]
pub fn test_1_layered_encrypt_and_shuffle_8_cards() {
    // Generator value and secret keys
    let g: Field = 3; // Example generator
    let sk: Field = 22; // Secret key for decryption

    // Example deck (5 cards) with initial values [1, m]
    let deck: [[Field; 2]; 8] =
        [[1, 10], [1, 20], [1, 30], [1, 40], [1, 50], [1, 60], [1, 70], [1, 80]];

    // Randomness values for encryption
    let randomness: [Field; 8] = [77, 88, 99, 111, 222, 333, 444, 555];

    let permutation_matrix: [[Field; 8]; 8] = [
        [0, 0, 1, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 1, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 1, 0, 0, 0, 0],
        [0, 0, 0, 0, 1, 0, 0, 0],
        [0, 1, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 1, 0],
    ];

    // Generate public key and aggregated key using the new function
    let (_, agg_pk) = gen_public_key_and_aggregate_key(g, sk, 1); // Aggregate public key

    // Encrypt and shuffle the deck
    let shuffled_encrypted_deck =
        encrypt_and_shuffle_8_cards(g, agg_pk, deck, randomness, permutation_matrix);
    // println(f"Shuffled and Encrypted Deck: {shuffled_encrypted_deck}");

    // Decrypt the shuffled deck using the secret key
    let (unmasked_deck, _) = decrypt_8_cards(g, shuffled_encrypted_deck, sk);
    // println(f"Unmasked Deck after Decryption: {unmasked_deck}");

    // Debugging output to track values at each step
    for i in 0..8 {
        let deck_i_second = deck[i][1];
        let unmasked_deck_i_second = unmasked_deck[i][1];
        let i_plus_1 = i + 1;
        println(
            f"Original card {i_plus_1}: {deck_i_second}, Decrypted card {i_plus_1}: {unmasked_deck_i_second}",
        );
    }

    assert(unmasked_deck[0][1] == deck[2][1]);
    assert(unmasked_deck[1][1] == deck[5][1]);
    assert(unmasked_deck[2][1] == deck[7][1]);
    assert(unmasked_deck[3][1] == deck[0][1]);
    assert(unmasked_deck[4][1] == deck[3][1]);
    assert(unmasked_deck[5][1] == deck[4][1]);
    assert(unmasked_deck[6][1] == deck[1][1]);
    assert(unmasked_deck[7][1] == deck[6][1]);
}

#[test]
pub fn test_1_layered_encrypt_and_shuffle_9_cards() {
    // Generator value and secret keys
    let g: Field = 3; // Example generator
    let sk: Field = 22; // Secret key for decryption

    // Example deck (5 cards) with initial values [1, m]
    let deck: [[Field; 2]; 9] =
        [[1, 10], [1, 20], [1, 30], [1, 40], [1, 50], [1, 60], [1, 70], [1, 80], [1, 90]];

    // Randomness values for encryption
    let randomness: [Field; 9] = [77, 88, 99, 111, 222, 333, 444, 555, 666];

    let permutation_matrix: [[Field; 9]; 9] = [
        [0, 0, 0, 1, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 1, 0, 0, 0],
        [1, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 1, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 1, 0, 0],
        [0, 0, 1, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 1, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 1],
        [0, 0, 0, 0, 0, 0, 0, 1, 0],
    ];

    // Generate public key and aggregated key using the new function
    let (_, agg_pk) = gen_public_key_and_aggregate_key(g, sk, 1); // Aggregate public key

    // Encrypt and shuffle the deck
    let shuffled_encrypted_deck =
        encrypt_and_shuffle_9_cards(g, agg_pk, deck, randomness, permutation_matrix);
    // println(f"Shuffled and Encrypted Deck: {shuffled_encrypted_deck}");

    // Decrypt the shuffled deck using the secret key
    let (unmasked_deck, _) = decrypt_9_cards(g, shuffled_encrypted_deck, sk);
    // println(f"Unmasked Deck after Decryption: {unmasked_deck}");

    // Debugging output to track values at each step
    for i in 0..9 {
        let deck_i_second = deck[i][1];
        let unmasked_deck_i_second = unmasked_deck[i][1];
        let i_plus_1 = i + 1;
        println(
            f"Original card {i_plus_1}: {deck_i_second}, Decrypted card {i_plus_1}: {unmasked_deck_i_second}",
        );
    }

    assert(unmasked_deck[0][1] == deck[3][1]);
    assert(unmasked_deck[1][1] == deck[5][1]);
    assert(unmasked_deck[2][1] == deck[0][1]);
    assert(unmasked_deck[3][1] == deck[1][1]);
    assert(unmasked_deck[4][1] == deck[6][1]);
    assert(unmasked_deck[5][1] == deck[2][1]);
    assert(unmasked_deck[6][1] == deck[4][1]);
    assert(unmasked_deck[7][1] == deck[8][1]);
    assert(unmasked_deck[8][1] == deck[7][1]);
}

#[test]
pub fn test_1_layered_encrypt_and_shuffle_10_cards() {
    // Generator value and secret keys
    let g: Field = 3; // Example generator
    let sk: Field = 22; // Secret key for decryption

    // Example deck (5 cards) with initial values [1, m]
    let deck: [[Field; 2]; 10] =
        [[1, 10], [1, 20], [1, 30], [1, 40], [1, 50], [1, 60], [1, 70], [1, 80], [1, 90], [1, 100]];

    // Randomness values for encryption
    let randomness: [Field; 10] = [77, 88, 99, 111, 222, 333, 444, 555, 666, 777];

    let permutation_matrix: [[Field; 10]; 10] = [
        [0, 0, 0, 0, 0, 0, 1, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 1, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
        [0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
        [0, 0, 0, 0, 0, 1, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
    ];

    // Generate public key and aggregated key using the new function
    let (_, agg_pk) = gen_public_key_and_aggregate_key(g, sk, 1); // Aggregate public key

    // Encrypt and shuffle the deck
    let shuffled_encrypted_deck =
        encrypt_and_shuffle_10_cards(g, agg_pk, deck, randomness, permutation_matrix);
    // println(f"Shuffled and Encrypted Deck: {shuffled_encrypted_deck}");

    // Decrypt the shuffled deck using the secret key
    let (unmasked_deck, _) = decrypt_10_cards(g, shuffled_encrypted_deck, sk);
    // println(f"Unmasked Deck after Decryption: {unmasked_deck}");

    // Debugging output to track values at each step
    for i in 0..10 {
        let deck_i_second = deck[i][1];
        let unmasked_deck_i_second = unmasked_deck[i][1];
        let i_plus_1 = i + 1;
        println(
            f"Original card {i_plus_1}: {deck_i_second}, Decrypted card {i_plus_1}: {unmasked_deck_i_second}",
        );
    }

    assert(unmasked_deck[0][1] == deck[6][1]);
    assert(unmasked_deck[1][1] == deck[9][1]);
    assert(unmasked_deck[2][1] == deck[0][1]);
    assert(unmasked_deck[3][1] == deck[2][1]);
    assert(unmasked_deck[4][1] == deck[4][1]);
    assert(unmasked_deck[5][1] == deck[1][1]);
    assert(unmasked_deck[6][1] == deck[3][1]);
    assert(unmasked_deck[7][1] == deck[7][1]);
    assert(unmasked_deck[8][1] == deck[5][1]);
    assert(unmasked_deck[9][1] == deck[8][1]);
}

#[test]
pub fn test_4_layered_encrypt_and_shuffle_4_cards() {
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

#[test]
pub fn test_decrypt_each_card_by_peeling_layers_with_decrypt_function() {
    // ---------- setup - same parameters used in the onion-encryption test ----------
    let g: Field = 3;
    let sk1: Field = 22.into();
    let sk2: Field = 33.into();
    let sk3: Field = 44.into();
    let sk4: Field = 55.into();

    // original deck: card values 1,2,3,4   (each card is [1, m])
    let deck: [[Field; 2]; 4] =
        [[1.into(), 1.into()], [1.into(), 2.into()], [1.into(), 3.into()], [1.into(), 4.into()]];

    // randomness and permutation matrices exactly as in
    // `test_4_layered_encrypt_and_shuffle_4_cards`
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

    let perm1: [[Field; 4]; 4] = [[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]];
    let perm2: [[Field; 4]; 4] = [[0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1], [1, 0, 0, 0]];
    let perm3: [[Field; 4]; 4] = [[0, 0, 0, 1], [0, 0, 1, 0], [0, 1, 0, 0], [1, 0, 0, 0]];
    let perm4: [[Field; 4]; 4] = [[0, 0, 1, 0], [0, 0, 0, 1], [0, 1, 0, 0], [1, 0, 0, 0]];

    // aggregate public-key g^(sk1+sk2+sk3+sk4)
    let (_, agg1) = gen_public_key_and_aggregate_key(g, sk1, 1.into());
    let (_, agg2) = gen_public_key_and_aggregate_key(g, sk2, agg1);
    let (_, agg3) = gen_public_key_and_aggregate_key(g, sk3, agg2);
    let (_, agg_pk) = gen_public_key_and_aggregate_key(g, sk4, agg3);

    // ---------- four-layer onion encryption & shuffling (same as before) ----------
    let enc1 = encrypt_and_shuffle_4_cards(g, agg_pk, deck, randomness1, perm1);
    let enc2 = encrypt_and_shuffle_4_cards(g, agg_pk, enc1, randomness2, perm2);
    let enc3 = encrypt_and_shuffle_4_cards(g, agg_pk, enc2, randomness3, perm3);
    let enc4 = encrypt_and_shuffle_4_cards(g, agg_pk, enc3, randomness4, perm4);
    let final_encrypted_deck = enc4; // what every player sees

    // ---------- reference cleartext using the original "peel layers with full sk" ----------
    // (so we know the ground-truth card values after all four decryptions)
    let (d4, _) = decrypt_4_cards(g, final_encrypted_deck, sk4);
    // println(f"d4: {d4}");
    let (d3, _) = decrypt_4_cards(g, d4, sk3);
    // println(f"d3: {d3}");
    let (d2, _) = decrypt_4_cards(g, d3, sk2);
    // println(f"d2: {d2}");
    let (clear_deck, _) = decrypt_4_cards(g, d2, sk1); // ground truth

    println(f"clear_deck: {clear_deck}");

    // -----------------------------------------------------------------------------
    // Individually decrypt each final ciphertext by peeling the four layers
    // with the appropriate secret-key share order for that card.
    // -----------------------------------------------------------------------------

    // ----- Card 1: ask shares in order sk4 -> sk3 -> sk2 -> sk1 ----------------------
    let (_, dc_1_4) = decrypt(g, final_encrypted_deck[0], sk4);
    let (_, dc_1_3) = decrypt(g, dc_1_4, sk3);
    let (_, dc_1_2) = decrypt(g, dc_1_3, sk2);
    let (_, dc_1_1) = decrypt(g, dc_1_2, sk1); // player-1's own share last
    let decrypted_card_1 = dc_1_1[1];
    println(f"decrypted card 1: {decrypted_card_1}");
    assert(clear_deck[0][1] == decrypted_card_1);

    // ----- Card 2: shares sk4 -> sk3 -> sk1 -> sk2 ----------------------------------
    let (_, dc_2_4) = decrypt(g, final_encrypted_deck[1], sk4);
    let (_, dc_2_3) = decrypt(g, dc_2_4, sk3);
    let (_, dc_2_2) = decrypt(g, dc_2_3, sk1);
    let (_, dc_2_1) = decrypt(g, dc_2_2, sk2); // player-2's own share last
    let decrypted_card_2 = dc_2_1[1];
    println(f"decrypted card 2: {decrypted_card_2}");
    assert(clear_deck[1][1] == decrypted_card_2);

    // ----- Card 3: shares sk4 -> sk2 -> sk1 -> sk3 ----------------------------------
    let (_, dc_3_4) = decrypt(g, final_encrypted_deck[2], sk4);
    let (_, dc_3_3) = decrypt(g, dc_3_4, sk2);
    let (_, dc_3_2) = decrypt(g, dc_3_3, sk1);
    let (_, dc_3_1) = decrypt(g, dc_3_2, sk3); // player-3's own share last
    let decrypted_card_3 = dc_3_1[1];
    println(f"decrypted card 3: {decrypted_card_3}");
    assert(clear_deck[2][1] == decrypted_card_3);

    // ----- Card 4: shares sk3 -> sk2 -> sk1 -> sk4 ----------------------------------
    let (_, dc_4_4) = decrypt(g, final_encrypted_deck[3], sk3);
    let (_, dc_4_3) = decrypt(g, dc_4_4, sk2);
    let (_, dc_4_2) = decrypt(g, dc_4_3, sk1);
    let (_, dc_4_1) = decrypt(g, dc_4_2, sk4); // player-4's own share last
    let decrypted_card_4 = dc_4_1[1];
    println(f"decrypted card 4: {decrypted_card_4}");
    assert(clear_deck[3][1] == decrypted_card_4);
}

#[test]
pub fn test_decrypt_each_card_with_decrypt_components() {
    // ---------- setup - same parameters used in the onion-encryption test ----------
    let g: Field = 3;
    let sk1: Field = 22.into();
    let sk2: Field = 33.into();
    let sk3: Field = 44.into();
    let sk4: Field = 55.into();

    // original deck: card values 1,2,3,4   (each card is [1, m])
    let deck: [[Field; 2]; 4] =
        [[1.into(), 1.into()], [1.into(), 2.into()], [1.into(), 3.into()], [1.into(), 4.into()]];

    // randomness and permutation matrices exactly as in
    // `test_4_layered_encrypt_and_shuffle_4_cards`
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

    let perm1: [[Field; 4]; 4] = [[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]];
    let perm2: [[Field; 4]; 4] = [[0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1], [1, 0, 0, 0]];
    let perm3: [[Field; 4]; 4] = [[0, 0, 0, 1], [0, 0, 1, 0], [0, 1, 0, 0], [1, 0, 0, 0]];
    let perm4: [[Field; 4]; 4] = [[0, 0, 1, 0], [0, 0, 0, 1], [0, 1, 0, 0], [1, 0, 0, 0]];

    // aggregate public-key g^(sk1+sk2+sk3+sk4)
    let (_, agg1) = gen_public_key_and_aggregate_key(g, sk1, 1.into());
    let (_, agg2) = gen_public_key_and_aggregate_key(g, sk2, agg1);
    let (_, agg3) = gen_public_key_and_aggregate_key(g, sk3, agg2);
    let (_, agg_pk) = gen_public_key_and_aggregate_key(g, sk4, agg3);

    // ---------- four-layer onion encryption & shuffling (same as before) ----------
    let enc1 = encrypt_and_shuffle_4_cards(g, agg_pk, deck, randomness1, perm1);
    let enc2 = encrypt_and_shuffle_4_cards(g, agg_pk, enc1, randomness2, perm2);
    let enc3 = encrypt_and_shuffle_4_cards(g, agg_pk, enc2, randomness3, perm3);
    let enc4 = encrypt_and_shuffle_4_cards(g, agg_pk, enc3, randomness4, perm4);
    let final_encrypted_deck = enc4; // what every player sees

    // ---------- reference cleartext using the original "peel layers with full sk" ----------
    // (so we know the ground-truth card values after all four decryptions)
    let (d4, _) = decrypt_4_cards(g, final_encrypted_deck, sk4);
    // println(f"d4: {d4}");
    let (d3, _) = decrypt_4_cards(g, d4, sk3);
    // println(f"d3: {d3}");
    let (d2, _) = decrypt_4_cards(g, d3, sk2);
    // println(f"d2: {d2}");
    let (clear_deck, _) = decrypt_4_cards(g, d2, sk1); // ground truth

    println(f"clear_deck: {clear_deck}");

    // -----------------------------------------------------------------------------
    // Individually decrypt each final ciphertext by peeling the four layers
    // with the appropriate secret-key share order for that card.
    // -----------------------------------------------------------------------------

    // ----- Card 1: ask shares in order sk4 -> sk3 -> sk2 -> sk1 ----------------------
    let decrypted_card_1 = final_encrypted_deck[0][1]
        / calculate_decrypt_component(final_encrypted_deck[0][0], sk4)
        / calculate_decrypt_component(final_encrypted_deck[0][0], sk3)
        / calculate_decrypt_component(final_encrypted_deck[0][0], sk2)
        / calculate_decrypt_component(final_encrypted_deck[0][0], sk1);
    println(f"decrypted card 1: {decrypted_card_1}");
    assert(clear_deck[0][1] == decrypted_card_1);

    // ----- Card 2: shares sk4 -> sk3 -> sk1 -> sk2 ----------------------------------
    let decrypted_card_2 = final_encrypted_deck[1][1]
        / calculate_decrypt_component(final_encrypted_deck[1][0], sk4)
        / calculate_decrypt_component(final_encrypted_deck[1][0], sk3)
        / calculate_decrypt_component(final_encrypted_deck[1][0], sk1)
        / calculate_decrypt_component(final_encrypted_deck[1][0], sk2);
    println(f"decrypted card 2: {decrypted_card_2}");
    assert(clear_deck[1][1] == decrypted_card_2);

    // ----- Card 3: shares sk4 -> sk2 -> sk1 -> sk3 ----------------------------------
    let decrypted_card_3 = final_encrypted_deck[2][1]
        / calculate_decrypt_component(final_encrypted_deck[2][0], sk4)
        / calculate_decrypt_component(final_encrypted_deck[2][0], sk2)
        / calculate_decrypt_component(final_encrypted_deck[2][0], sk1)
        / calculate_decrypt_component(final_encrypted_deck[2][0], sk3);
    println(f"decrypted card 3: {decrypted_card_3}");
    assert(clear_deck[2][1] == decrypted_card_3);

    // ----- Card 4: shares sk3 -> sk2 -> sk1 -> sk4 ----------------------------------
    let decrypted_card_4 = final_encrypted_deck[3][1]
        / calculate_decrypt_component(final_encrypted_deck[3][0], sk3)
        / calculate_decrypt_component(final_encrypted_deck[3][0], sk2)
        / calculate_decrypt_component(final_encrypted_deck[3][0], sk1)
        / calculate_decrypt_component(final_encrypted_deck[3][0], sk4);
    println(f"decrypted card 4: {decrypted_card_4}");
    assert(clear_deck[3][1] == decrypted_card_4);
}
