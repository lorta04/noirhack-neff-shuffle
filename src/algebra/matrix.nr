pub fn mul_4x4_by_4x2(a: [[Field; 4]; 4], b: [[Field; 2]; 4]) -> [[Field; 2]; 4] {
    let mut c: [[Field; 2]; 4] = [[0; 2]; 4];
    for i in 0..4 {
        for j in 0..2 {
            let mut sum = 0;
            for k in 0..4 {
                sum += a[i][k] * b[k][j];
            }
            c[i][j] = sum;
        }
    }
    c
}

#[test]
fn test_mul_4x4_by_4x2() {
    let a: [[Field; 4]; 4] = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]];

    let b: [[Field; 2]; 4] = [[1, 2], [3, 4], [5, 6], [7, 8]];

    let result = mul_4x4_by_4x2(a, b);

    let expected: [[Field; 2]; 4] = [[50, 60], [114, 140], [178, 220], [242, 300]];

    // Check if the result matches the expected output
    for i in 0..4 {
        for j in 0..2 {
            assert(result[i][j] == expected[i][j]);
        }
    }
}
