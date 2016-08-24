CC := $(CC)
CXX := $(CXX)
CXXFLAGS := $(CXXFLAGS) -Iinclude -Imason_packages/.link/include -std=c++11
LDFLAGS := $(LDFLAGS) -lboost_program_options -lboost_system

MASON ?= .mason/mason
MASON_HOME := ./mason_packages/.link

RELEASE_FLAGS := -O3 -DNDEBUG
WARNING_FLAGS := -Wall -Wextra -Werror -Wsign-compare -Wfloat-equal -Wfloat-conversion -Wshadow -Wno-unsequenced
DEBUG_FLAGS := -g -O0 -DDEBUG -fno-inline-functions -fno-omit-frame-pointer

ifeq ($(BUILDTYPE),Release)
	FINAL_FLAGS := -g $(WARNING_FLAGS) $(RELEASE_FLAGS)
else
	FINAL_FLAGS := -g $(WARNING_FLAGS) $(DEBUG_FLAGS)
endif

default: cli

cli: mason_packages clean
	$(CXX) cli.cpp -o cli -isystem$(MASON_HOME)/include/include $(CXXFLAGS) $(FINAL_FLAGS) $(LDFLAGS)

test: cli
	./tests/cli.test.sh

$(MASON):
	git submodule update --init

mason_packages: $(MASON)
	$(MASON) install hpp_skel 0.0.1 && $(MASON) link hpp_skel 0.0.1
	$(MASON) install boost_libprogram_options 1.61.0 && $(MASON) link boost_libprogram_options 1.61.0

clean:
	rm -f cli
	rm -f *.o

clean-mason:
	rm -rf mason_packages