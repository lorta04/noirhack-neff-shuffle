# -----------------------------
# Configuration
# -----------------------------

# List of all crate names (edit if you add more)
CRATES = decrypt_one_layer gen_elgamal_key_pair shuffle4 shuffle5 shuffle6 shuffle7 shuffle8 shuffle9 shuffle10 verify_card_message

.PHONY: all clean format fmt test tree \
        all_% clean_% compile_% execute_% prove_% write_vk_% verify_% test_%

# -----------------------------
# High-level commands
# -----------------------------

# Build all crates
all:
	@for crate in $(CRATES); do \
		$(MAKE) all-$$crate || exit 1; \
	done

# Format all circuits
fmt:
	nargo fmt

format: fmt

# Run tests in all packages
test:
	nargo test

# Clean everything
clean:
	rm -rf ./target/*

# Show directory structure
tree:
	tree -I '.git'

# -----------------------------
# Pattern rules per crate
# Usage: make all-shuffle5, make prove-shuffle6, etc.
# -----------------------------

all_%:
	$(MAKE) compile_$*
	$(MAKE) execute_$*
	$(MAKE) prove_$*
	$(MAKE) write_vk_$*
	$(MAKE) verify_$*

compile_%:
	nargo compile --package $*
	mkdir -p ./target/$*
	mv ./target/$*.json ./target/$*/$*.json

execute_%:
	cd crates/$* && nargo compile && nargo execute
	mv ./target/$*.gz ./target/$*/$*.gz
	rm -f ./target/$*.json

prove_%:
	bb prove -b ./target/$*/$*.json -w ./target/$*/$*.gz -o ./target/$*

write_vk_%:
	bb write_vk -b ./target/$*/$*.json -o ./target/$*

verify_%:
	bb verify -k ./target/$*/vk -p ./target/$*/proof

test_%:
	nargo test --package $*

clean_%:
	rm -rf ./target/$*
