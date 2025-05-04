use shared::utils::{gen_public_key_and_aggregate_key, poseidon_hash};

/// g  : Field - group generator
/// r  : Field - user-supplied randomness
/// returns: ( sk , pk )
fn main(g: Field, r: Field) -> pub (Field, Field) {
    let sk = poseidon_hash(
        [r, 0x20644e72e121a029b84045b68180585c2833e84879b9709143e1f593f0000000],
    );
    let (_, pk) = gen_public_key_and_aggregate_key(g, sk, 1);
    (sk, pk)
}

#[test]
fn test_main() {
    let g: Field = 3;
    let rand: Field = 77;

    let expected_sk = poseidon_hash([
        rand,
        0x20644e72e121a029b84045b68180585c2833e84879b9709143e1f593f0000000,
    ]);
    let (_, expected_pk) = gen_public_key_and_aggregate_key(g, expected_sk, 1);

    let (sk, pk) = main(g, rand);

    assert(sk == expected_sk);
    assert(pk == expected_pk);
}
