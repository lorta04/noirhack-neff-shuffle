### On Seer Privacy in ZK Werewolf

[`The current command model`](../../crates/verify_card_message/README.md) exposes the identity of **seers** to the server and reveals which players were **peeked**. While the latter may be acceptable in some Werewolf variants, we argue that in a zero-knowledge (ZK) setting, even the peeked players should not be aware they were targeted. Relying on a trustworthy server is not a valid defense—it ignores real, solvable privacy concerns.

This file proposes a conceptual design to address both issues, along with related challenges that arise from solving them. While the design is not optimized for efficiency, it demonstrates what’s possible and may become practical as ZK technology continues to improve.

---

#### Problem 1: Seer's Identity Leaks

**Why it happens:**  
To learn another player’s role, a seer must directly query the target—since only the target knows their own role. This requires sending a message. If only seers send such messages, their identity becomes obvious.

**Solution:**  
To obfuscate the seer, every player sends a message to a target of their choice via the server. Each message contains:

- a freshly generated public key (used to receive a response), encrypted with the target’s public key so only the target can decrypt it.

When a player receives messages, they must respond—also via the server—by encrypting their own role as "WOLF" or "NON_WOLF" using each decrypted return key. The return key is included as a public input in the zero-knowledge proof that generates the response. This enables verifiers to confirm that the player used the correct return key and responded to all messages, without learning anything about senders.

However, because the original message does **not** include the sender’s role, a new vulnerability emerges: **non-seer players can impersonate seers**. We address this in **Problem 3**.

---

#### Problem 2: Peeked Player Identity Leaks

**Why it happens:**  
If multiple players send messages to the same target, it's possible to infer that this player was peeked.

**Solution:**  
Ensure uniform targeting behavior. Each player sends `n-1` messages—one to every other player. This results in a total of `n*(n-1)` messages per round. While inefficient, this guarantees indistinguishability across messages, preventing any inference about who was peeked.

---

#### Problem 3: Limiting Seer to One Peek

**Challenge:**  
If every player sends `n-1` messages, how do we prevent a seer from making multiple valid peeks?

**Solution:**  
Enforce the constraint using a zero-knowledge circuit. Each player generates `n-1` messages within a circuit. The circuit ensures that:

- **Seers** embed exactly one valid message; the rest are random noise.
- **Non-seers** embed only invalid (non-decryptable) messages.

This mechanism guarantees that only seers can perform a single valid peek, without revealing who they are or whom they peeked at.

---

#### Problem 4: Automation & Response Timing

**Observation:**  
If responses are automated, non-seers may respond faster than a seer can manually choose a target. This could leak indirect timing information.

**Note:**  
The author believes this is beyond the scope of the repository. Nevertheless, the overall model remains zero-knowledge and can be adapted for on-chain deployment, as the server functions purely as a public bulletin board.

---

While not implemented in our demo due to time constraints, we hope this design inspires others to explore and extend it—turning what was once a fantasy into reality.
