use shared::neff_shuffle::encrypt_and_shuffle_cards;

/// g            : Field            - generator
/// deck         : [[Field; 2]; 7]  - 7 cards, each `[c1, c2]`
/// perm         : [[Field; 7]; 7]  - 7 x 7 permutation matrix (0/1)
/// rand         : [Field; 7]       - per-card randomness
/// pk_agg       : Field            - aggregate public key
fn main(
    g: Field,
    pk_agg: pub Field,
    deck: pub [[Field; 2]; 7],
    rand: [Field; 7],
    perm: [[Field; 7]; 7],
) -> pub [[Field; 2]; 7] {
    encrypt_and_shuffle_cards(g, pk_agg, deck, rand, perm)
}

#[test]
fn test_main() {
    let g: Field = 3;
    let pk_agg: Field = 17;
    let deck: [[Field; 2]; 7] = [[1, 10], [1, 20], [1, 30], [1, 40], [1, 50], [1, 60], [1, 70]];
    let rand: [Field; 7] = [77, 88, 99, 111, 222, 333, 444];
    let perm: [[Field; 7]; 7] = [
        [0, 0, 0, 0, 1, 0, 0],
        [1, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 1, 0],
        [0, 0, 0, 0, 0, 0, 1],
        [0, 0, 1, 0, 0, 0, 0],
        [0, 1, 0, 0, 0, 0, 0],
        [0, 0, 0, 1, 0, 0, 0],
    ];

    let out = main(g, pk_agg, deck, rand, perm);

    // quick sanity check
    for i in 0..7 {
        assert(out[i][0] != 0);
        assert(out[i][1] != 0);
    }
}
