PROJECT_NAME = neff_shuffle
TARGET_DIR = ./target
CIRCUIT_JSON = $(TARGET_DIR)/$(PROJECT_NAME).json
WITNESS = $(TARGET_DIR)/$(PROJECT_NAME).gz
PROOF = $(TARGET_DIR)/proof
VK = $(TARGET_DIR)/vk

.PHONY: all clean prove verify

all: execute prove write_vk verify

execute:
	nargo execute

prove:
	bb prove -b $(CIRCUIT_JSON) -w $(WITNESS) -o $(TARGET_DIR)

write_vk:
	bb write_vk -b $(CIRCUIT_JSON) -o $(TARGET_DIR)

verify:
	bb verify -k $(VK) -p $(PROOF)

clean:
	rm -rf $(TARGET_DIR)
