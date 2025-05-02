use crate::algebra::pow;

pub fn gen_public_key_and_aggregate_key(
    generator: Field,
    sk: Field,
    old_aggk: Field,
) -> (Field, Field) {
    let pk = pow(generator, sk);
    let new_aggk = old_aggk * pk;
    (pk, new_aggk)
}

#[test]
fn test_onion_aggregation() {
    let generator: Field = 3; // Generator value
    let sk1: Field = 22.into(); // Player 1's secret key
    let sk2: Field = 33.into(); // Player 2's secret key
    let sk3: Field = 44.into(); // Player 3's secret key

    let old_aggk: Field = 1.into(); // Starting aggregated key

    // Player 1 generates their public key and aggregates
    let (_, aggk1) = gen_public_key_and_aggregate_key(generator, sk1, old_aggk);
    // println(f"Player 1 public key: {pk1}, Aggregated key: {aggk1}");

    // Player 2 generates their public key and aggregates with the previous one
    let (_, aggk2) = gen_public_key_and_aggregate_key(generator, sk2, aggk1);
    // println(f"Player 2 public key: {pk2}, Aggregated key: {aggk2}");

    // Player 3 generates their public key and aggregates with the previous one
    let (_, aggk3) = gen_public_key_and_aggregate_key(generator, sk3, aggk2);
    // println(f"Player 3 public key: {pk3}, Aggregated key: {aggk3}");

    // Final aggregated key after all players
    let expected_aggk: Field = pow(generator, sk1) * pow(generator, sk2) * pow(generator, sk3);
    assert(aggk3 == expected_aggk, "Final aggregated key does not match expected value.");

    // Verify the correctness of the aggregation
    // let debug_final = f"Final aggregated key: {aggk3}, Expected aggregated key: {expected_aggk}";
    // println(debug_final);
}
