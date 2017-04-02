# Target
BIN_DIR = bin
BIN = $(BIN_DIR)/app

# Match all sources in src direcotry
SRCS_DIR = src
SRCS = $(wildcard $(SRCS_DIR)/**/*.cc $(SRCS_DIR)/*.cc)

# Builds object list from sources, substitues .cc for .o
OBJS_DIR = obj
OBJS = $(patsubst $(SRCS_DIR)/%.cc,$(OBJS_DIR)/%.o,$(SRCS))

# Include headers files
INCLUDE_DIRS = include
INCLUDE = $(foreach includedir,$(INCLUDE_DIRS),-I$(includedir))

# Search libraries in following directories
INCLUDE_LIB_DIRS = 
INCLUDE_LIB = $(foreach includedir,$(INCLUDE_LIB_DIRS),-L$(includedir))

# Set compiler, preprocesor and linker flags
CXXFLAGS += -g -O3 -Wall -std=c++11 $(INCLUDE)
CPPFLAGS +=
LDFLAGS += $(INCLUDE_LIB)
LDLIBS += 

# Set other tools
MKDIR = mkdir -p

# Avoid filename conflicts
.PHONY: all clean

# Rules
all: $(BIN)

$(OBJS_DIR)/%.o: $(SRCS_DIR)/%.cc
	@$(MKDIR) $(dir $@)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

$(BIN): $(OBJS)
	@$(MKDIR) $(dir $@)
	$(CXX) $(LDFLAGS) $^ $(LDLIBS) -o $@

clean:
	@$(RM) $(BIN)
	@$(RM) $(OBJS)
