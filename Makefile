CC=gcc
CFLAGS=-Wall -Werror -pedantic -std=c99
LIBNAME=stuff
SRCDIR=src
BUILDDIR=build
TESTDIR=test
BINDIR=bin

# Source files
SRCS=$(wildcard $(SRCDIR)/*.c)

# Object files for library
OBJS=$(patsubst $(SRCDIR)/%.c,$(BUILDDIR)/%.o,$(SRCS))

# Object files for test executable
TEST_SRCS=$(wildcard $(TESTDIR)/*.c)
TEST_OBJS=$(patsubst $(TESTDIR)/%.c,$(BINDIR)/%.o,$(TEST_SRCS))

.PHONY: all clean

all: lib test

lib: $(BUILDDIR)/lib$(LIBNAME).a

# Target for the static library
$(BUILDDIR)/lib$(LIBNAME).a: $(OBJS)
	ar rcs $@ $^

# Rule to build object files for library
$(BUILDDIR)/%.o: $(SRCDIR)/%.c | build
	$(CC) $(CFLAGS) -c -o $@ $<

build:
	mkdir -p build

test: $(BINDIR)/test
	$(info ====== RUNNING TEST ======)
	./$<

# Target for the test executable
$(BINDIR)/test: $(TEST_OBJS) $(BUILDDIR)/lib$(LIBNAME).a
	$(CC) $(CFLAGS) -o $@ $^

# Rule to build object files for test executable
$(BINDIR)/%.o: $(TESTDIR)/%.c | bin
	$(CC) $(CFLAGS) -c -o $@ $< -I$(SRCDIR)

bin:
	mkdir -p bin

clean:
	rm -f $(BUILDDIR)/*.o $(BUILDDIR)/lib$(LIBNAME).a $(BINDIR)/*.o $(BINDIR)/test
