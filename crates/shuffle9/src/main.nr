use shared::neff_shuffle::encrypt_and_shuffle_cards;

/// g            : Field            - generator
/// deck         : [[Field; 2]; 9]  - 9 cards, each `[c1, c2]`
/// perm         : [[Field; 9]; 9]  - 9 x 9 permutation matrix (0/1)
/// rand         : [Field; 9]       - per-card randomness
/// pk_agg       : Field            - aggregate public key
fn main(
    g: Field,
    pk_agg: pub Field,
    deck: pub [[Field; 2]; 9],
    rand: [Field; 9],
    perm: [[Field; 9]; 9],
) -> pub [[Field; 2]; 9] {
    encrypt_and_shuffle_cards(g, pk_agg, deck, rand, perm)
}

#[test]
fn test_main() {
    let g: Field = 3;
    let pk_agg: Field = 17;
    let deck: [[Field; 2]; 9] =
        [[1, 10], [1, 20], [1, 30], [1, 40], [1, 50], [1, 60], [1, 70], [1, 80], [1, 90]];
    let rand: [Field; 9] = [77, 88, 99, 111, 222, 333, 444, 555, 666];
    let perm: [[Field; 9]; 9] = [
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

    let out = main(g, pk_agg, deck, rand, perm);

    // quick sanity check
    for i in 0..9 {
        assert(out[i][0] != 0);
        assert(out[i][1] != 0);
    }
}
