CC := $(CC)
CXX := $(CXX)
CXXFLAGS := $(CXXFLAGS) -Iinclude -Imason_packages/.link/include -std=c++11
RELEASE_FLAGS := -O3 -DNDEBUG
WARNING_FLAGS := -Wall -Wextra -Werror -Wsign-compare -Wfloat-equal -Wfloat-conversion -Wshadow -Wno-unsequenced
DEBUG_FLAGS := -g -O0 -DDEBUG -fno-inline-functions -fno-omit-frame-pointer
MASON ?= .mason/mason

default: test

clean:
	rm -rf mason_packages

$(MASON):
	git submodule update --init

mason_packages: $(MASON)
	$(MASON) install hpp_skel 0.0.1

cli: mason_packages
	# $(CXX) cli.cpp -o cli -isystem$(MASON_HOME)/include -L$(MASON_HOME)/lib $(CXXFLAGS) $(FINAL_FLAGS) $(LDFLAGS);