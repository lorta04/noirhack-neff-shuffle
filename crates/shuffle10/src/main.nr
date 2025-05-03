use shared::neff_shuffle::encrypt_and_shuffle_10_cards;

/// g            : Field            - generator
/// deck         : [[Field; 2]; 10]  - 10 cards, each `[c1, c2]`
/// perm         : [[Field; 10]; 10]  - 10 x 10 permutation matrix (0/1)
/// rand         : [Field; 10]       - per-card randomness
/// pk_agg       : Field            - aggregate public key
fn main(
    g: Field,
    pk_agg: pub Field,
    deck: pub [[Field; 2]; 10],
    rand: [Field; 10],
    perm: [[Field; 10]; 10],
) -> pub [[Field; 2]; 10] {
    encrypt_and_shuffle_10_cards(g, pk_agg, deck, rand, perm)
}

#[test]
fn test_main() {
    let g: Field = 3;
    let pk_agg: Field = 17;
    let deck: [[Field; 2];10] = [[1, 10], [1, 20], [1, 30], [1, 40], [1, 50], [1, 60], [1, 70], [1, 80], [1, 90], [1, 100]];
    let rand: [Field; 10] = [77, 88, 99, 111, 222, 333, 444, 555, 666, 777];
    let perm: [[Field; 10]; 10] = [
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

    let out = main(g, pk_agg, deck, rand, perm);

    // quick sanity check
    for i in 0..10 {
        assert(out[i][0] != 0);
        assert(out[i][1] != 0);
    }
}
