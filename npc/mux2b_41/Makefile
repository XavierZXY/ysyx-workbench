TOPNAME = mux2b41
NXDC_FILES = constr/mux2b41.nxdc
INC_PATH ?=

BUILD_DIR = ./build
OBJ_DIR = $(BUILD_DIR)/obj_dir
BIN = $(BUILD_DIR)/$(TOPNAME)

# verilator config mainly for wavefrom
VERILATOR = verilator
VERILATOR_CFLAGS += -MMD --build -cc  \
				-O3 --x-assign fast --x-initial fast --noassert
VERILATOR_ARGUMENTS += --cc --build --Wall  --trace --Mdir $(OBJ_DIR) --exe
VERILATOR_TOP += --top-module $(TOPNAME)
VERILATOR_INPUT += $(shell find $(abspath ./vsrc) -name "*.v")
VERILATOR_INPUT += $(shell find $(abspath ./csrc) -name "*_ator.cpp" -or -name "*_ator.cc" -or -name "*_ator.cpp")

default: $(BIN)

$(call git_commit, "sim RTL") # commit hash
$(shell mkdir -p $(BUILD_DIR))

# constraint file
SRC_AUTO_BIND = $(abspath $(BUILD_DIR)/auto_bind.cpp)
$(SRC_AUTO_BIND): $(NXDC_FILES)
	python3 $(NVBOARD_HOME)/scripts/auto_pin_bind.py $^ $@

# project source mainly for nvboard
VSRCS = $(shell find $(abspath ./vsrc) -name "*.v")
CSRCS = $(shell find $(abspath ./csrc) -name "*.c" -or -name "*.cc" -or -name "*.cpp" ! -regex ".*_ator\..*")
CSRCS += $(SRC_AUTO_BIND)

# rules for NVBoard
include $(NVBOARD_HOME)/scripts/nvboard.mk

# rules for verilator
INCFLAGS = $(addprefix -I, $(INC_PATH))
CXXFLAGS += $(INCFLAGS) -DTOP_NAME="\"V$(TOPNAME)\""

$(BIN): $(VSRCS) $(CSRCS) $(NVBOARD_ARCHIVE)
	@rm -rf $(OBJ_DIR)
	$(VERILATOR) $(VERILATOR_CFLAGS) \
		--top-module $(TOPNAME) $^ \
		$(addprefix -CFLAGS , $(CXXFLAGS)) $(addprefix -LDFLAGS , $(LDFLAGS)) \
		--Mdir $(OBJ_DIR) --exe -o $(abspath $(BIN))

all: default

# nvboard run
nvb: $(BIN)
	@$^

# verilator run
ver: $(VERILATOR_INPUT)
	@rm -rf $(OBJ_DIR)
	@echo "---------------------Start---------------------"
	$(VERILATOR) $(VERILATOR_TOP) $(VERILATOR_ARGUMENTS) $(VERILATOR_INPUT)
	@cd $(OBJ_DIR) && ./V$(TOPNAME) +trace
	@echo
	@echo "---------------------Done---------------------"
	@echo "You can make GTKwave to see the wavefroms." 

run: $(BIN)
	@$^

test:
	@echo "TOPNAME: $(TOPNAME)"
	@echo "CSRCS: $(CSRCS)"
	@echo "VERILATOR_CFLAGS: $(VERILATOR_CFLAGS)"

waveV:
	@gtkwave $(OBJ_DIR)/logs/*.vcd

clean:
	rm -rf $(BUILD_DIR)

.PHONY: default all clean run
