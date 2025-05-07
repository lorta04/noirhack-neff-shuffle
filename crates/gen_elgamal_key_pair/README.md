# 🗝️ gen_elgamal_key_pair

This utility circuit generates an ElGamal **key pair** `(sk, pk)` using a user-provided random seed. It is typically used at the **beginning of the protocol** by each participant to establish their private and public keys.

## 🔧 How It Works

Given:

- `g: Field` — Generator of the group
- `r: Field` — User-provided randomness

The circuit outputs:

- `sk` — The secret key, derived via a Poseidon hash of `r` and a fixed salt
- `pk` — The public key, computed as `g^sk`

```
let sk = poseidon_hash([
    r,
    0x20644e72e121a029b84045b68180585c2833e84879b9709143e1f593f0000000, // fixed salt chosen by the author
]);
let (_, pk) = gen_public_key_and_aggregate_key(g, sk, 1);
```

This circuit is deterministic given the same `r`.

## ✅ Example Inputs

```
g = "3"
r = "77"
```

## 📝 Usage

Each player runs this circuit independently at the **start of the protocol** to generate their own key pair. The public key `pk` will later be submitted to the server and aggregated using `aggregate_public_keys` to form a shared encryption key.
