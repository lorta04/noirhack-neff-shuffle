# 🧪 noirhack-neff-shuffle

```bash
 ####### #    #       #     #
      #  #   #        #  #  # ###### #####  ###### #    #  ####  #      ######
     #   #  #         #  #  # #      #    # #      #    # #    # #      #
    #    ###    ##### #  #  # #####  #    # #####  #    # #    # #      #####
   #     #  #         #  #  # #      #####  #      # ## # #    # #      #
  #      #   #        #  #  # #      #   #  #      ##  ## #    # #      #
 ####### #    #        ## ##  ###### #    # ###### #    #  ####  ###### #
```

> 🔐 A privacy-preserving, collaborative, verifiable secret shuffle system in Noir — inspired by [Neff (2001)](https://web.cs.ucdavis.edu/~franklin/ecs228/2013/neff_2001.pdf) and [ZK-Werewolf at ETHGlobal Waterloo](https://ethglobal.com/showcase/zk-werewolf-ce61c). Built by a team of programmers (and ChatGPT) who had barely touched Noir or ZK before — fueled by curiosity, ambition, and good old hopes and dreams.

## 💡 Why This Exists

Because we want to **win**, explore new technologies like Noir and zero-knowledge proofs, and build something chaotic, multiplayer, and way more fun than the usual toy examples.

## 🧭 TL;DR

This project explores how to **shuffle and decrypt hidden roles** in a fair, verifiable way — without a game master or trust assumptions.

Players **rerandomize and permute** an encrypted deck, prove each shuffle in zero-knowledge, then decrypt their own card **layer by layer** — learning **only their own role**.

**🔁 Encrypted deck → rerandomization + permutation → ZK proof → private reveal**

Next up: turning this into a full **ZK-Werewolf** game — with private, verifiable actions like peeking (🕵️) and killing (💀) that don’t leak identities or meta info.

## 🔀 Overview

### ♠️ Shuffling

In our demo, the game begins with a plaintext deck sent to Player 1.

Each player, in turn:

- Takes the encrypted deck
- Applies their own rerandomization and permutation
- Proves in ZK that they performed a valid shuffle
- Passes the output to the next player

Once all shuffle layers are applied, players decrypt their card **one layer at a time**, requesting partial decryptions from others and applying their own secret at the end — ensuring that **only they** can view the final result.

#### 🔐 Trust Model

- The protocol remains fair and private **as long as at least one player is honest** and keeps their shuffle secret — even if others collude.
- It can be deployed on-chain, though the UX would be rough due to the number of transactions required.  
  ➤ This could be improved with batching and relayers, but coordination would be complex.

### 🧙 Role Actions (Early Prototype)

After roles are assigned, players can prove certain actions to a server using ZK:

- 🧙‍♂️ **Seer**: Proves they are a Seer, then specifies a target. The server queries the target and responds.
- 🐺 **Wolf**: Proves they are a Wolf, then submits a target to the server.
- 🗳️ **Vote**: Proves they are a Villager, Seer, or Wolf, and submits a vote and target.

The **vote flow is private and verifiable**.  
Seer and Wolf actions currently rely on the server, but this repository will explore a fully trustless version — even if inefficient. The ideas work; now it’s a matter of refinement.

## 🚀 How This Ties to ZK-Werewolf

Imagine playing **Werewolf** — but fully on-chain.

- Roles are encrypted and shuffled using zero-knowledge proofs
- No game master
- No trust assumptions
- You can _prove_ you’re a Seer or Villager — without revealing anything else
- This repo tackles the hardest part: **fair role assignment** and **verifiable in-game actions**

It’s the cryptographic backbone for hiding roles while proving the randomness (and decisions) were real.

> In the future, as layer 2s improve and ZK proving becomes more efficient, a fully on-chain ZK-Werewolf — with no backend and good UX — could become reality.  
> And this doesn’t stop at Werewolf: other games, especially those involving **randomness and hidden state**, could be **fully implemented in ZK** too.

## ⚙️ Example Usage

### Run all steps for a specific circuit

```bash
make all-shuffle4
```

This runs:

- `compile`: compile the Noir circuit
- `execute`: generate witness from input
- `prove`: create the proof
- `write_vk`: export the verification key
- `verify`: verify the proof

### Run only specific steps

```bash
make execute-shuffle4   # Just run the circuit
make prove-shuffle4     # Just generate the proof
make verify-shuffle4    # Just verify it
```

### Format all circuits

```bash
make format
```

### Run everything for all circuits

```bash
make all
```

### Run all tests

```bash
make test
```

## 📦 Project Structure

```bash
.
├── crates/
│   ├── shared/                  # Common logic: ElGamal, matrix algebra, Neff shuffle
│   ├── shuffle4..10/            # Fixed-size shuffle circuits
│   ├── decrypt_one_layer/       # For layered card reveal
│   ├── verify_card_message/     # Verifies specific actions or claims
│   ├── aggregate_public_keys/   # For distributed key setup
│   └── gen_elgamal_key_pair/    # Generates ElGamal key pairs
├── target/                      # Compiled circuits, witnesses, proofs, and VKeys
├── Makefile                     # Run all workflows (build, prove, verify)
└── Nargo.toml                   # Workspace manifest
```

## 🔬 What’s Next

### 🔧 Features We’ll Explore

- 🔍 **Seer Mechanic**  
  Allow peeking exactly once per night — without exposing or notifying either party.
- 🐺 **Wolf Kills**  
  Encode kills so that attackers remain anonymous.

### ❗ Open Problems (Out of Scope)

- 🤔 **Player Dropout in Trustless Games**  
  In a fully private, game-masterless system, what happens if a player quits mid-game?  
  For example, the player who drops out **might be a Wolf**, but because the system doesn’t know their role, it can’t decide how the game should proceed.
- 🧍‍♂️ **Uncooperative or Colluding Players**  
  If some players **refuse to cooperate or act maliciously together**, the protocol may be unable to proceed — blocking progress in shuffling or revealing.
