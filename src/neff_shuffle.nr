use crate::algebra::enforce_perm_n10;
use crate::algebra::matrix::mul_4x4_by_4x2;
use crate::elgamal::{decrypt_u256, encrypt_u256};

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

// pub fn test_shuffling_cards() {
//     // Example generator, public key, and secret key
//     let g: Field = 3; // Example generator for ElGamal
//     let agg_pk: Field = 123456789; // Example aggregated public key
//     let sk: Field = 987654321; // Example secret key

//     // Define 4 cards with dummy values (4x2 matrix)
//     let deck: [[Field; 2]; 4] = [[1, 2], [3, 4], [5, 6], [7, 8]];

//     // Define randomness (4 random values)
//     let randomness: [Field; 4] = [10, 20, 30, 40];

//     // Define a 4x4 permutation matrix (example shuffle)
//     let permutation_matrix: [[Field; 4]; 4] =
//         [[0, 1, 0, 0], [1, 0, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]];

//     // Print deck before shuffling
//     std::println(f"Original Deck: {deck}");

//     // Call the shuffle function
//     let shuffled_deck =
//         encrypt_and_shuffle_4_cards(g, agg_pk, deck, randomness, permutation_matrix);

//     // Print the shuffled deck
//     std::println(f"Shuffled Deck: {shuffled_deck}");

//     // Now decrypt the shuffled deck
//     let (unmasked_deck, pk) = decrypt_4_cards(g, shuffled_deck, sk);

//     // Print the decrypted deck
//     std::println(f"Unmasked Deck: {unmasked_deck}");

//     // Compare the deck element by element with approximate equality
//     // for i in 0..4 {
//     // assert(is_approx_equal(deck[i], unmasked_deck[i]));
//     // }
// }
