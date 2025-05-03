use shared::elgamal::{calculate_decrypt_component, decrypt, encrypt};
use shared::utils::gen_public_key_and_aggregate_key;

/// g            : Field            - generator
/// card         : [Field; 2]       - a single card `[c1, c2]`
/// sk           : Field            - one share of the secret key
fn main(g: Field, card: pub [Field; 2], sk: Field) -> pub ([Field; 2], Field) {
    let (_, decrypted_card) = decrypt(g, card, sk);
    let decrypt_component = calculate_decrypt_component(card[0], sk);
    (decrypted_card, decrypt_component)
}

#[test]
fn test_main() {
    let g: Field = 3;
    let sk: Field = 22;
    let m: Field = 42;
    let r: Field = 77;

    let (_, pk) = gen_public_key_and_aggregate_key(g, sk, 1);
    let card = encrypt(g, pk, [1, m], r);

    let (decrypted, decrypt_component) = main(g, card, sk);

    assert(decrypted[1] == m);
    assert(decrypt_component == calculate_decrypt_component(card[0], sk));
}
