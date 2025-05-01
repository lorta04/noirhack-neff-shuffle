pub mod matrix;

// -----------------------------------------------------------------------------
// pow_u8 - 8-bit exponent   (0 .. 255)
// -----------------------------------------------------------------------------
pub fn pow_u8(base: Field, exponent: u8) -> Field {
    let mut result = 1;
    let mut power = base;

    for i in 0..8 {
        let bit = (exponent >> i) & 1;
        let term = if bit == 1 { power } else { 1 };
        result *= term;
        power *= power;
    }

    result
}

// -----------------------------------------------------------------------------
// pow_u32 - 32-bit exponent   (0 .. 2^32-1)
// -----------------------------------------------------------------------------
pub fn pow_u32(base: Field, exponent: u32) -> Field {
    let mut result = 1;
    let mut power = base;

    for i in 0..32 {
        let bit = ((exponent >> i) & 1) as u32;
        let term = if bit == 1 { power } else { 1 };
        result *= term;
        power *= power;
    }
    result
}

// -----------------------------------------------------------------------------
// pow_u64 - 64-bit exponent   (0 .. 2^64-1)
// -----------------------------------------------------------------------------
pub fn pow_u64(base: Field, exponent: u64) -> Field {
    let mut result = 1;
    let mut power = base;

    for i in 0..64 {
        let bit = ((exponent >> i) & 1) as u64;
        let term = if bit == 1 { power } else { 1 };
        result *= term;
        power *= power;
    }
    result
}

// -----------------------------------------------------------------------------
// pow_u128 - 128-bit exponent stored in a Field
//           (assert exp < 2^128, then use the first 128 bits)
// -----------------------------------------------------------------------------
pub fn pow_u128(base: Field, exponent: u128) -> Field {
    let mut result = 1;
    let mut power = base;

    for i in 0..128 {
        let bit = ((exponent >> i) & 1) as u128;
        let term = if bit == 1 { power } else { 1 };
        result *= term;
        power *= power;
    }
    result
}

// -----------------------------------------------------------------------------
// pow_u256 - full 254-bit exponent (Field) - "up to 2^254-1"
// Noir's Field is 254 bits so we loop all 254 positions.
// -----------------------------------------------------------------------------
pub fn pow_u256(base: Field, exponent: Field) -> Field {
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

// -----------------------------------------------------------------------------
// permutation-matrix check for any n <= 10
// matrix is always 10x10; only the top-left n x n window is active
// -----------------------------------------------------------------------------
pub fn enforce_perm_n10(mat: [[Field; 10]; 10], n: u8) {
    // --- sanity on n ---------------------------------------------------------
    let n32: u32 = n as u32;
    assert(n32 >= 2, "n must be at least 2");
    assert(n32 <= 10, "n must be <= 10");

    // --- 1. Boolean cells and zero padding ----------------------------------
    for i in 0..10 {
        for j in 0..10 {
            let c = mat[i][j];

            if (i < n32) & (j < n32) {
                // inside active block -> must be 0 or 1
                assert(c * (c - 1) == 0);
            } else {
                // padding -> must be 0
                assert(c == 0);
            }
        }
    }

    // --- 2. row sums ---------------------------------------------------------
    for i in 0..10 {
        let mut row_sum = 0;
        for j in 0..10 {
            if j < n32 {
                row_sum += mat[i][j];
            }
        }
        if i < n32 {
            assert(row_sum == 1); // active row
        } else {
            assert(row_sum == 0); // padded row
        }
    }

    // --- 3. column sums ------------------------------------------------------
    for j in 0..10 {
        let mut col_sum = 0;
        for i in 0..10 {
            if i < n32 {
                col_sum += mat[i][j];
            }
        }
        if j < n32 {
            assert(col_sum == 1); // active col
        } else {
            assert(col_sum == 0); // padded col
        }
    }
}

#[test]
fn test_pow_u8() {
    assert(pow_u8(3, 5 as u8) == 243);
    assert(pow_u8(2, 3 as u8) == 8);

    let mut expected = 1;
    for _ in 0..127 {
        expected *= 2;
    }

    assert(pow_u8(2, 127 as u8) == expected);
}

#[test]
fn test_pow_u32() {
    // 3^5 = 243
    assert(pow_u32(3, 5 as u32) == 243);

    // 2^31  (check high bit works)
    let r = pow_u32(2, 31 as u32);
    let mut exp: Field = 1;
    for _ in 0..31 {
        exp *= 2;
    }
    assert(r == exp);
}

#[test]
fn test_pow_u64() {
    // 7^11 = 1977326743
    assert(pow_u64(7, 11 as u64) == 1977326743);

    // 2^40  (exercise upper range of u64 loop)
    let r = pow_u64(2, 64 as u64);
    let mut exp: Field = 1;
    for _ in 0..64 {
        exp *= 2;
    }
    assert(r == exp);
}

#[test]
fn test_pow_u128() {
    // 5^20  using 128-bit exponent
    let r = pow_u128(5, 20 as u128);
    let mut exp: Field = 1;
    for _ in 0..20 {
        exp *= 5;
    }
    assert(r == exp);
}

#[test]
fn test_pow_u256() {
    // 10^9  where exponent is passed as Field
    let exp_field: Field = 9;
    let r = pow_u256(10, exp_field);

    let mut exp: Field = 1;
    for _ in 0..9 {
        exp *= 10;
    }
    assert(r == exp);

    // max exponent
    let base: Field = 7;
    let e: Field = (-1 as i64) as Field;
    let r: Field = pow_u256(base, e);
    let r_next_left = pow_u256(base, e + 1);
    let r_next_right = r * base;
    assert(r_next_left == r_next_right);
}

#[test]
fn test_pow_u256_max_exponent() {
    let base: Field = 7;

    let e: Field = (-1 as i64) as Field;

    let r: Field = pow_u256(base, e);

    let r_next_left = pow_u256(base, e + 1);
    let r_next_right = r * base;

    assert(r_next_left == r_next_right);
}

#[test]
fn test_enforce_perm_u10_perm_4_ok() {
    // 4x4 permutation padded to 10x10
    let zero: [Field; 10] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    let p: [[Field; 10]; 10] = [
        [0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 1, 0, 0, 0, 0, 0, 0, 0],
        zero,
        zero,
        zero,
        zero,
        zero,
        zero,
    ];
    enforce_perm_n10(p, 4 as u8); // should pass
}

#[test(should_fail)]
fn test_enforce_perm_u10_perm_5_bad() {
    // duplicate 1s -> should fail
    let zero: [Field; 10] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    let bad: [[Field; 10]; 10] = [
        [1, 1, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 1, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
        [0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
        zero,
        zero,
        zero,
        zero,
        zero,
    ];
    // uncomment next line to see the test fail
    enforce_perm_n10(bad, 5 as u8);
}
