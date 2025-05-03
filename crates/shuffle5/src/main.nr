use shared::neff_shuffle::encrypt_and_shuffle_5_cards;

/// g            : Field            - generator
/// deck         : [[Field; 2]; 5]  - 5 cards, each `[c1, c2]`
/// perm         : [[Field; 5]; 5]  - 5 x 5 permutation matrix (0/1)
/// rand         : [Field; 5]       - per-card randomness
/// pk_agg       : Field            - aggregate public key
fn main(
    g: Field,
    pk_agg: pub Field,
    deck: pub [[Field; 2]; 5],
    rand: [Field; 5],
    perm: [[Field; 5]; 5],
) -> pub [[Field; 2]; 5] {
    encrypt_and_shuffle_5_cards(g, pk_agg, deck, rand, perm)
}

#[test]
fn test_main() {
    let g: Field = 3;
    let pk_agg: Field = 17;
    let deck: [[Field; 2]; 5] = [[1, 10], [1, 20], [1, 30], [1, 40], [1, 50]];
    let rand: [Field; 5] = [77, 88, 99, 111, 222];
    let perm: [[Field; 5]; 5] =
        [[1, 0, 0, 0, 0], [0, 0, 0, 1, 0], [0, 1, 0, 0, 0], [0, 0, 1, 0, 0], [0, 0, 0, 0, 1]];

    let out = main(g, pk_agg, deck, rand, perm);

    // quick sanity check
    for i in 0..5 {
        assert(out[i][0] != 0);
        assert(out[i][1] != 0);
    }
}
