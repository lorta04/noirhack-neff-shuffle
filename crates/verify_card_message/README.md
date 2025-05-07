# 🃏 verify_card_message

This circuit proves that a player holds a specific card (without revealing which one), and that when decrypted, the card’s message matches one of a predefined set of expected messages. It’s used to **verify claims** like being a certain role (e.g., WOLF or SEER), or performing actions like **vote**, **peek**, or **kill**, all without leaking the actual card.

## 🔧 How It Works

Given:

- `deck: [[Field; 2]; 10]` — The encrypted deck of cards
- `deck_size: Field` — Number of active cards in the deck
- `card: [Field; 2]` — The encrypted card the prover claims to own
- `decrypt_components: [Field; 10]` — Partial decryption shares from players
- `num_decrypt_components: Field` — How many decrypt components are provided
- `expected_messages: [Field; 10]` — A list of valid expected messages
- `num_expected_messages: Field` — Number of valid entries in the expected list
- `nullifier_secret: Field` — A private secret used to prevent double usage

The circuit:

1.  Ensures the claimed `card` exists in the `deck`
2.  Applies all `decrypt_components` to compute the decrypted message:

```
m = card[1] / (decrypt_component₁ × ... × decrypt_componentₙ)
```

3.  Ensures the result matches at least one `expected_message`

The circuit outputs:

- `poseidon_hash([nullifier_secret])` — a **nullifier**

## ✅ Example Inputs

```
deck = [
  ["0x05", "0x05"],
  ["0x041e54cffbab943f...", "0x047f5403..."],
  ["0x06", "0x06"],
  [0, 0], ..., [0, 0]
]
deck_size = 3
card = ["0x041e54cffbab943f...", "0x047f5403..."]
decrypt_components = ["0x20cf...", "0x06fc...", 1, ..., 1]
num_decrypt_components = 2
expected_messages = [42, 43, 44, 0, 0, 0, 0, 0, 0, 0]
num_expected_messages = 3
nullifier_secret = 123456789
```

## 📝 Use Cases

This circuit can prove that a player:

- **Is one of several roles** (e.g., [WOLF, SEER, VILLAGER])  
  _→ claim "I’m a player"_
- **Is not a WOLF**  
  _→ use expected_messages = [SEER, VILLAGER]_
- **Is a WOLF**  
  _→ use expected_messages = [WOLF]_

### 🏷️ Attached Action Tags

You can extend the `expected_messages` array to include metadata like actions:

#### ✅ Example: Voting

```
expected_messages = [WOLF, SEER, VILLAGER, VOTE, target_index]
num_expected_messages = 5
```

Only the first 3 entries are real role values; the rest are **attached tags** for verifying intent (e.g., voting against someone).

#### 🧪 Demo: Peeking / Killing

These aren’t secure flows and should be definitely improved but used in the demo to show intent.

- **Peek:**

```
expected_messages = [SEER, PEEK, target_index]
num_expected_messages = 3
```

- **Kill:**

```
expected_messages = [WOLF, KILL, target_index]
num_expected_messages = 3
```
