use shared::neff_shuffle::encrypt_and_shuffle_cards;

/// g            : Field            - generator
/// deck         : [[Field; 2]; 4]  - 4 cards, each `[c1, c2]`
/// perm         : [[Field; 4]; 4]  - 4 x 4 permutation matrix (0/1)
/// rand         : [Field; 4]       - per-card randomness
/// pk_agg       : Field            - aggregate public key
fn main(
    g: Field,
    pk_agg: pub Field,
    deck: pub [[Field; 2]; 4],
    rand: [Field; 4],
    perm: [[Field; 4]; 4],
) -> pub [[Field; 2]; 4] {
    encrypt_and_shuffle_cards(g, pk_agg, deck, rand, perm)
}

#[test]
fn test_main() {
    let g: Field = 3;
    let pk_agg: Field = 17;
    let deck: [[Field; 2]; 4] = [[1, 10], [1, 20], [1, 30], [1, 40]];
    let rand: [Field; 4] = [77, 88, 99, 111];
    let perm: [[Field; 4]; 4] = [[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]];

    let out = main(g, pk_agg, deck, rand, perm);

    // quick sanity check
    for i in 0..4 {
        assert(out[i][0] != 0);
        assert(out[i][1] != 0);
    }
}
