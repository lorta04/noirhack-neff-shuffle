use shared::algebra::pow;
use shared::utils::gen_public_key_and_aggregate_key;

fn main(pks: [Field; 10], num_pks: Field) -> pub Field {
    let mut agg_pk: Field = 1;
    for i in 0..10 {
        if i < num_pks as u32 {
            agg_pk *= pks[i];
        }
    }
    agg_pk
}

#[test]
fn test_main() {
    let generator: Field = 3;
    let sks: [Field; 3] = [22.into(), 33.into(), 44.into()];
    let mut pks: [Field; 10] = [0.into(); 10];

    for i in 0..3 {
        let (pk, _) = gen_public_key_and_aggregate_key(generator, sks[i], 1);
        pks[i] = pk;
    }

    let expected_aggk: Field =
        pow(generator, sks[0]) * pow(generator, sks[1]) * pow(generator, sks[2]);
    let result = main(pks, 3.into());

    assert(result == expected_aggk, "Aggregated key from main() does not match expected.");
}
