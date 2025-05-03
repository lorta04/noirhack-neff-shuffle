pub mod matrix;

pub fn pow(base: Field, exponent: Field) -> Field {
    let bits: [u1; 254] = exponent.to_le_bits();
    let mut result = 1;
    let mut power = base;

    for i in 0..254 {
        let bit = bits[i];
        let term = if bit == 1 { power } else { 1 };
        result *= term;
        power *= power;
    }
    result
}

pub fn enforce_permutation<let N: u32>(mat: [[Field; N]; N]) {
    for i in 0..N {
        for j in 0..N {
            let c = mat[i][j];
            assert(c * (c - 1) == 0);
        }
    }

    for i in 0..N {
        let mut row_sum = 0;
        for j in 0..N {
            row_sum += mat[i][j];
        }
        assert(row_sum == 1);
    }

    for j in 0..N {
        let mut col_sum = 0;
        for i in 0..N {
            col_sum += mat[i][j];
        }
        assert(col_sum == 1);
    }
}

#[test]
fn test_pow() {
    // 10^9  where exponent is passed as Field
    let exp_field: Field = 9;
    let r = pow(10, exp_field);

    let mut exp: Field = 1;
    for _ in 0..9 {
        exp *= 10;
    }
    assert(r == exp);

    // max exponent
    let base: Field = 7;
    let e: Field = (-1 as i64) as Field;
    let r: Field = pow(base, e);
    let r_next_left = pow(base, e + 1);
    let r_next_right = r * base;
    assert(r_next_left == r_next_right);
}

#[test]
fn test_pow_max_exponent() {
    let base: Field = 7;

    let e: Field = (-1 as i64) as Field;

    let r: Field = pow(base, e);

    let r_next_left = pow(base, e + 1);
    let r_next_right = r * base;

    assert(r_next_left == r_next_right);
}

#[test]
fn test_enforce_perm_u10_perm_4_ok() {
    let p: [[Field; 4]; 4] = [[0, 1, 0, 0], [0, 0, 0, 1], [1, 0, 0, 0], [0, 0, 1, 0]];
    enforce_permutation(p);
}

#[test(should_fail)]
fn test_enforce_perm_u10_perm_5_bad() {
    let bad: [[Field; 5]; 5] =
        [[1, 1, 0, 0, 0], [0, 0, 1, 0, 0], [0, 0, 0, 1, 0], [0, 0, 0, 0, 1], [0, 1, 0, 0, 0]];
    enforce_permutation(bad);
}
