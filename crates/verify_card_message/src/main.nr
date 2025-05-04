use shared::elgamal::{calculate_decrypt_component, encrypt};
use shared::utils::{gen_public_key_and_aggregate_key, poseidon_hash};

fn main(
    deck: pub [[Field; 2]; 10],
    deck_size: pub Field,
    card: [Field; 2],
    decrypt_components: [Field; 10],
    num_decrypt_components: Field,
    expected_messages: pub [Field; 10],
    num_expected_messages: pub Field,
    nullifier_secret: Field,
) -> pub Field {
    let mut occurrences = 0;
    for i in 0..10 {
        if i < deck_size as u32 {
            let same0: bool = deck[i][0] == card[0];
            let same1: bool = deck[i][1] == card[1];
            let match_card = (same0 & same1) as u32;
            occurrences += match_card;
        }
    }
    assert(occurrences >= 1, "card not found in deck");

    let mut m = card[1];
    for i in 0..10 {
        if i < num_decrypt_components as u32 {
            m = m / decrypt_components[i];
        }
    }

    let mut is_match = 0;
    for i in 0..10 {
        if i < num_expected_messages as u32 {
            if m == expected_messages[i] {
                is_match += 1;
            }
        }
    }
    assert(is_match >= 1, "decrypted value not in expected set");

    poseidon_hash([nullifier_secret])
}

#[test]
fn test_main() {
    let g: Field = 3;
    let sk1: Field = 22;
    let sk2: Field = 33;
    let msg: Field = 0x574f4c46; // "WOLF"
    let rand: Field = 77;
    let nullifier_secret: Field = 123456789;

    let (_, mut agg_pk) = gen_public_key_and_aggregate_key(g, sk1, 1);
    let (_, agg_pk_final) = gen_public_key_and_aggregate_key(g, sk2, agg_pk);
    agg_pk = agg_pk_final;

    let card = encrypt(g, agg_pk, [1, msg], rand);

    let decrypt_component_1 = calculate_decrypt_component(card[0], sk1);
    let decrypt_component_2 = calculate_decrypt_component(card[0], sk2);

    let mut decrypt_components = [1; 10];
    decrypt_components[0] = decrypt_component_1;
    decrypt_components[1] = decrypt_component_2;
    let num_decrypt_components: Field = 2;

    let mut expected_messages = [0; 10];
    expected_messages[0] = msg;
    expected_messages[1] = 43;
    expected_messages[2] = 44;
    let num_expected_messages: Field = 3;

    let dummy1: [Field; 2] = [5, 5];
    let dummy2: [Field; 2] = [6, 6];

    let mut deck = [[0; 2]; 10];
    deck[0] = dummy1;
    deck[1] = card;
    deck[2] = dummy2;
    let deck_size: Field = 3;

    let nullifier_hash = main(
        deck,
        deck_size,
        card,
        decrypt_components,
        num_decrypt_components,
        expected_messages,
        num_expected_messages,
        nullifier_secret,
    );

    let expected_hash = poseidon_hash([nullifier_secret]);
    assert(nullifier_hash == expected_hash);
}
