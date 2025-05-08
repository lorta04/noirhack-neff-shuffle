### On Wolf Anonymity in ZK Werewolf

In the classic Werewolf game, wolves coordinate at night to choose a victim. However, in a privacy-preserving or zero-knowledge (ZK) setting, implementing [`this mechanic`](../../crates/verify_card_message/README.md) naively leaks the identity of the wolf to the server or to others through indirect patterns.

This file proposes a conceptual design to solve this challenge by allowing every player to submit encrypted "kill messages" indistinguishably. These messages are shuffled and decrypted publicly, revealing only the final result (i.e. who dies), without exposing which player submitted the actual killing command.

---

#### Problem 1: Wolf Identity Leaks

**Why it happens:**  
Only wolves are allowed to issue real kill commands. If only wolves send a valid message (e.g. `["WOLF", target]`), their identity becomes obvious. A server observing message patterns or quantity can trivially distinguish them from villagers.

**Solution:**  
Every player sends a message encrypted using the shared **aggregate public key**. The message has the format:

- `["WOLF", target_index]` — only the actual wolf submits this.
- `["NON_WOLF", fake_index]` — everyone else submits a decoy.

These messages should be indistinguishable prior to decryption. All players send one, so the server cannot tell who the real wolf is.

---

#### Problem 2: Message Origin Leaks

**Why it happens:**  
Even if everyone sends a message, it’s possible to correlate ciphertexts to player identities unless additional steps are taken.

**Solution:**  
After all messages are submitted, they are collaboratively **shuffled** using a ZK verifiable shuffle (e.g., Neff Shuffle). This ensures the final decrypted list of commands is unlinkable to the original sender. Then, all players collaboratively decrypt the shuffled deck and **reveal it publicly**.

The decrypted deck will contain one real `["WOLF", target_index]` and the rest as decoys. The server (or players) simply announces the target without knowing who submitted the command.

---

#### Problem 3: Wolves Don’t Know Each Other

**Challenge:**  
In this ZK variant, wolves do not know each other’s identities. This breaks from the classic game model where coordination is expected and allowed.

**Note:**  
This design choice enhances privacy but introduces new challenges in coordinating a kill or avoiding friendly fire. The implications and resolution mechanisms for this constraint are **to be explored further**.

---

#### Optional Enhancement: Role Proof on Death

If game design allows or requires, the victim may later submit a **zero-knowledge proof** of their role (e.g., proving they were `VILLAGER`, `SEER`, etc.) based on their original role commitment. This enables flexibility in death announcements—e.g., public role reveal, delayed reveal, or never.

---

#### What does this translate to?

Complete privacy-preserving announcements on a public bulletin board.

---

Same as the [seer peek design](../seer_peek/README.md), this approach to wolf anonymity is **not implemented in the demo due to time constraints**.
