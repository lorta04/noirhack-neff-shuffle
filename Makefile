# -----------------------------
# Configuration
# -----------------------------

# List of all crate names (edit if you add more)
CRATES = shuffle4 shuffle5 shuffle6 shuffle7 shuffle8 shuffle9 shuffle10

.PHONY: all clean format test tree \
        all-% clean-% compile-% execute-% prove-% write_vk-% verify-% test-%

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

format:
	nargo fmt

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
# Usage: make all-a, make prove-b, etc.
# -----------------------------

all-%:
	$(MAKE) compile-$*
	$(MAKE) execute-$*
	$(MAKE) prove-$*
	$(MAKE) write_vk-$*
	$(MAKE) verify-$*

compile-%:
	nargo compile --package $*
	mkdir -p ./target/$*
	mv ./target/$*.json ./target/$*/$*.json

execute-%:
	cd crates/$* && nargo compile && nargo execute
	mv ./target/$*.gz ./target/$*/$*.gz
	rm -f ./target/$*.json

prove-%:
	bb prove -b ./target/$*/$*.json -w ./target/$*/$*.gz -o ./target/$*

write_vk-%:
	bb write_vk -b ./target/$*/$*.json -o ./target/$*

verify-%:
	bb verify -k ./target/$*/vk -p ./target/$*/proof

test-%:
	nargo test --package $*

clean-%:
	rm -rf ./target/$*
