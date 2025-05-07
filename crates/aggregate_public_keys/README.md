# 🧮 aggregate_public_keys

This circuit computes the **aggregate ElGamal public key** from a list of individual public keys. It's useful for distributed key generation, where multiple participants contribute to a shared public key without revealing their private keys.

## 🔧 How It Works

Given:

- `pks: [Field; 10]` — A fixed-size array of public keys
- `num_pks: Field` — The number of keys to include in aggregation (starting from index 0)

The circuit outputs:

-   `agg_pk: Field` — The aggregate public key, calculated as the product of the first `num_pks` entries in `pks`

```
agg_pk = pks[0] * pks[1] * ... * pks[num_pks - 1]
```

## ✅ Example Inputs

```
pks = [
  "10460353203",
  "4052555153018976267",
  "1570042899082081611640534563",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
]
num_pks = "3"
```

## ➡️ Flow

```mermaid

sequenceDiagram

participant P1 as Player 1

participant P2 as Player 2

participant Pn as Player n

participant S as Server

participant A as All



P1->>P1: Run gen_elgamal_key_pair

P2->>P2: Run gen_elgamal_key_pair

Pn->>Pn: Run gen_elgamal_key_pair



P1->>S: Send pk1

P2->>S: Send pk2

Pn->>S: Send pkn



S->>S: Run aggregate_public_keys

S->>A: Share **agg_pk** for encryption

```
