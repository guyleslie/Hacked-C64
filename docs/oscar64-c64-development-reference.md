# Oscar64 C Compiler and C64 Hardware Programming Reference

This comprehensive technical reference provides detailed information for professional C64 development using the Oscar64 C compiler, specifically tailored for memory-constrained procedural generation applications targeting ~7KB executable and ~3KB data constraints.

## Oscar64 compiler overview and optimization strategy

Oscar64 represents a revolutionary advancement in 6502 C compilation, achieving both **high code density and fast execution speed** while supporting modern C99 standards. Developed by Dr. Mortal Wombat, it consistently produces **2.5-7x faster code than cc65** with **30-50% smaller binaries**, making it ideal for memory-constrained applications like procedural dungeon generators.

### Command line optimization for memory-constrained applications

For projects targeting 7KB executable and 3KB data limits, the optimal Oscar64 configuration combines aggressive size optimization with strategic performance enhancements:

```bash
# Maximum size optimization for tight memory constraints
oscar64 -Os -Oo -Oz -tf=prg -tm=c64 -n source.c

# Debug build with symbols for development
oscar64 -g -O0 -e source.c
```

**Critical optimization flags:**
- **-Os**: Optimize for size over speed (essential for memory constraints)
- **-Oo**: Enable "outliner" to extract repeated code sequences into functions
- **-Oz**: Auto-placement of global variables in zero page for faster access
- **-Oi**: Auto-inline small functions (use judiciously with size constraints)
- **-Ox**: Optimize pointer arithmetic by preventing array boundary crossings

### Static stack implementation advantage

Oscar64's **static stack analysis** eliminates the expensive overhead of 6502's limited 256-byte hardware stack. By analyzing call graphs at compile time, it creates optimized static allocations that avoid zero-page indirect addressing for local variables, providing significant performance gains over traditional 6502 C compilers.

**Memory management capabilities:**
- Zero-page optimization for frequently accessed variables
- Bank switching support for expanded memory access
- Overlay system for applications exceeding available RAM
- Configurable memory regions (main, ROM, overlay banks)

### Compiler limitations and practical workarounds

**Recursion constraints:** Static call graph analysis prevents deep recursion. Convert recursive algorithms to iterative implementations or use explicit stack management for procedural generation algorithms.

**Function pointer complications:** Dynamic calls prevent optimization. Use switch statements instead of function pointers when implementing different dungeon generation algorithms.

**16-bit arithmetic overhead:** All 16-bit operations are expensive on 8-bit processors. Prefer 8-bit arithmetic, use unsigned types, and leverage lookup tables for complex calculations.

## Complete C64 hardware programming reference

### Memory layout optimization for constrained applications

**Recommended memory layout for 7KB executable + 3KB data:**

```
$0000-$00FF: Zero page (256 bytes) - Critical variables and pointers
$0100-$01FF: Hardware stack (256 bytes) - Preserved for system use
$0200-$03FF: System workspace (512 bytes) - BASIC/KERNAL variables
$0400-$07FF: Screen memory (1KB) - Relocatable via VIC-II
$0801-$2000: Main executable (7KB) - Program code
$2000-$2C00: Data area (3KB) - Game data, lookup tables
$2C00-$4000: Available buffer space - Sprites, charsets, generation buffers
$C000-$D000: High memory (4KB) - Additional space when ROM banked out
```

### VIC-II programming essentials

**Critical registers for procedural generation:**
- **$D011 (Control Register 1)**: Display control, bitmap mode switching
- **$D016 (Control Register 2)**: Multicolor mode, horizontal scrolling
- **$D018 (Memory Control)**: Screen and character memory location
- **$D020-$D024**: Color registers for procedural color schemes

**Graphics modes for dungeon rendering:**
- **Standard text mode (40×25)**: Efficient for character-based dungeons
- **Multicolor text mode**: Four colors per character for detailed tiles
- **Standard bitmap mode (320×200)**: High resolution for complex graphics

### CIA chip integration for input and timing

**CIA #1 ($DC00-$DC0F) - Keyboard and joystick:**
```c
// Efficient keyboard scanning for player input
uint8_t scan_keyboard(void) {
    *((uint8_t*)0xDC00) = 0xFE;  // Select column 0
    return ~(*((uint8_t*)0xDC01)) & 0xFF;  // Read rows
}
```

**Timer programming for procedural generation:**
CIA timers provide microsecond precision for seeded random generation and timing-critical dungeon updates. Timer A can count PHI2 cycles for precise frame timing, while Timer B handles longer intervals for generation phases.

### Hardware timing constraints for real-time generation

**Critical timing considerations:**
- **Bad lines** occur every 8th raster line, stealing 40-43 CPU cycles
- **Sprite DMA** reduces available CPU time based on active sprites
- **PAL timing**: 312 lines × 63 cycles = 19,656 cycles per frame
- **NTSC timing**: 262 lines × 65 cycles = 17,030 cycles per frame

For real-time procedural generation, budget generation algorithms to complete within available cycles, using techniques like **time-sliced generation** across multiple frames.

## Advanced memory optimization techniques

### Zero page utilization strategy

Zero page provides **1-cycle faster access** and **1-byte smaller instructions** compared to absolute addressing. For procedural generation, prioritize zero page allocation for:

**Most critical variables ($02-$06):**
```c
// Place generation state in zero page
__zeropage uint8_t gen_x_pos;      // Current generation X coordinate
__zeropage uint8_t gen_y_pos;      // Current generation Y coordinate  
__zeropage uint16_t dungeon_ptr;   // Pointer to current dungeon data
__zeropage uint8_t room_type;      // Current room type being generated
```

**Pointer storage ($FB-$FE):**
Essential for indirect addressing modes required for efficient memory operations and data structure traversal during generation.

### Static vs dynamic allocation for constrained systems

**Static allocation advantages** for 7KB/3KB constraints:
- **Zero fragmentation**: Predictable memory layout prevents runtime failures
- **Deterministic timing**: No allocation overhead during generation
- **Simplified implementation**: Direct memory addressing without management overhead

**Memory banking for expanded access:**
```c
// Access RAM under BASIC ROM for additional storage
void bank_out_basic(void) {
    *((uint8_t*)0x01) &= ~0x01;  // Bank out BASIC ROM at $A000-$BFFF
}

void restore_basic(void) {
    *((uint8_t*)0x01) |= 0x01;   // Restore BASIC ROM
}
```

### Efficient data structures for 8-bit constraints

**Structure design principles:**
- **Maximum 256 bytes per structure** (8-bit index register limit)
- **Fixed-size instances** for indexed access efficiency
- **Strategic member ordering** by access frequency

```c
// Dungeon room structure optimized for generation
typedef struct {
    uint8_t room_type;        // Most frequently accessed
    uint8_t connections;      // 4-bit flags for N/S/E/W exits
    uint8_t monster_count;    // Number of monsters to generate
    uint8_t treasure_flags;   // Bit flags for treasure types
    uint16_t special_data;    // Pointer to special room data
} DungeonRoom;  // Total: 6 bytes per room
```

## Algorithm implementation for 6502 constraints

### Performance optimization techniques for procedural generation

**Lookup table strategy** for complex calculations:
```c
// Pre-calculated sine table for smooth movement/generation curves  
const uint8_t sine_table[64] = {
    128, 131, 134, 137, 140, 143, 146, 149, 152, 155, 158, 161,
    // ... full sine wave values
};

uint8_t fast_sine(uint8_t angle) {
    return sine_table[angle & 0x3F];  // Mask to 0-63 range
}
```

**Bit manipulation for efficient algorithms:**
```c
// Fast random number generation using Linear Congruential Generator
uint16_t prng_state = 1;

uint8_t fast_random(void) {
    prng_state = (prng_state * 37) + 1;  // Optimized multiplier
    return (uint8_t)(prng_state >> 8);   // Use high byte for better distribution
}
```

### Real-time constraints and time-slicing

**Procedural generation time-slicing:**
```c
// Generate dungeon over multiple frames to avoid frame drops
typedef struct {
    uint8_t current_x, current_y;    // Current generation position
    uint8_t phase;                   // Generation phase (rooms, corridors, details)
    uint8_t cycles_remaining;        // Cycles available this frame
} GenerationState;

void time_sliced_generation(GenerationState* state) {
    state->cycles_remaining = 1000;  // Budget cycles per frame
    
    while (state->cycles_remaining > 50) {  // Reserve cycles for other tasks
        switch (state->phase) {
            case PHASE_ROOMS:
                generate_room(state);
                break;
            case PHASE_CORRIDORS:  
                generate_corridor(state);
                break;
            case PHASE_DETAILS:
                add_room_details(state);
                break;
        }
        state->cycles_remaining -= estimate_cycles_used();
    }
}
```

### Efficient mathematical operations

**16-bit arithmetic optimization:**
```c
// Efficient 16-bit addition avoiding carry propagation when possible
uint16_t fast_add16(uint16_t a, uint16_t b) {
    uint8_t low = (uint8_t)a + (uint8_t)b;
    uint8_t high = (uint8_t)(a >> 8) + (uint8_t)(b >> 8);
    if (low < (uint8_t)a) high++;  // Handle carry
    return ((uint16_t)high << 8) | low;
}
```

**Multiplication by constants:**
```asm
; Multiply by 5 efficiently
asl a     ; *2
asl a     ; *4  
adc original_value  ; +1 = *5
```

## Professional development best practices

### Coding conventions for Oscar64 projects

**Variable naming and type selection:**
```c
// Use descriptive but concise names to minimize symbol overhead
uint8_t dng_x, dng_y;           // Dungeon coordinates
uint16_t room_ptr;              // Room data pointer
char* text_buf;                 // Text buffer pointer

// Prefer unsigned types for better 6502 performance
uint8_t player_health;          // 0-255 range sufficient
uint8_t room_count;             // Always positive count
```

**Function organization for optimization:**
```c
// Place related functions in same file for inlining opportunities
static inline void __fastcall__ set_pixel(uint8_t x, uint8_t y, uint8_t color) {
    // Inline for performance-critical graphics operations
}

// Mark const data for ROM placement
const uint8_t room_templates[16][8] = { /* room data */ };
```

### Hardware-specific programming patterns

**VIC-II bank switching for memory expansion:**
```c
// Switch VIC-II to bank 1 ($4000-$7FFF) to free up low memory
void switch_vic_bank1(void) {
    *((uint8_t*)0xDD00) = (*((uint8_t*)0xDD00) & 0xFC) | 0x02;
}
```

**Sprite management for dynamic objects:**
```c
typedef struct {
    uint8_t x, y;                // Position
    uint8_t sprite_ptr;          // Sprite data pointer
    uint8_t color;               // Sprite color
    uint8_t flags;               // Collision, multicolor, expansion flags
} GameObject;

void update_sprite_hardware(uint8_t sprite_num, GameObject* obj) {
    *((uint8_t*)(0xD000 + sprite_num * 2)) = obj->x;      // X position
    *((uint8_t*)(0xD001 + sprite_num * 2)) = obj->y;      // Y position
    *((uint8_t*)(0xD027 + sprite_num)) = obj->color;      // Color
}
```

### Real-time programming constraints

**Interrupt-safe generation algorithms:**
```c
volatile uint8_t generation_active = 0;

void raster_interrupt(void) {
    if (!generation_active) {
        // Safe to perform generation during vertical blank
        continue_generation();
    }
    // Acknowledge interrupt and return
}
```

**Memory access optimization:**
```c
// Avoid page boundary crossings in time-critical code
// Align frequently accessed arrays to page boundaries
uint8_t __aligned(256) sprite_positions[8];
uint8_t __aligned(256) room_data[64];
```

## Modern project structure and build integration

### CMake integration for professional workflows

**Basic CMakeLists.txt for Oscar64:**
```cmake
cmake_minimum_required(VERSION 3.10)
project(C64DungeonGenerator)

# Find Oscar64 compiler
find_program(OSCAR64_COMPILER oscar64 REQUIRED)

# Add custom target for C64 compilation
add_custom_target(c64_build
    COMMAND ${OSCAR64_COMPILER} -Os -Oo -Oz -tf=prg -tm=c64 
            -o ${CMAKE_BINARY_DIR}/dungeon.prg
            ${CMAKE_SOURCE_DIR}/src/main.c
    DEPENDS ${CMAKE_SOURCE_DIR}/src/main.c
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMENT "Building C64 program"
)
```

### Cross-platform development environment

**VS Code configuration with VS64 extension:**
```json
{
    "name": "C64_Dungeon_Generator",
    "description": "Procedural dungeon generator for C64",
    "toolkit": "oscar64", 
    "sources": [
        "src/main.c",
        "src/generator.c", 
        "src/renderer.c"
    ],
    "build": "release",
    "includes": ["src/include"],
    "definitions": ["RELEASE_BUILD=1"],
    "optimization": "-Os -Oo -Oz"
}
```

### File format integration and deployment

**Automated build pipeline:**
```bash
#!/bin/bash
# Build script for automated deployment

# Compile main program
oscar64 -Os -Oo -Oz -tf=prg -tm=c64 -o build/dungeon.prg src/main.c

# Create disk image with c1541
c1541 -format "dungeon,dd" d64 build/dungeon.d64 \
      -write build/dungeon.prg "dungeon" \
      -write resources/sprites.dat "sprites" \
      -write resources/music.sid "music"

# Generate VICE-compatible labels for debugging  
oscar64 -g -O0 src/main.c -o build/debug.prg
```

**GitHub Actions CI/CD integration:**
```yaml
name: C64 Build
on: [push, pull_request]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Install dependencies
        run: |
          sudo apt-get update
          sudo apt-get install -y vice-dev
      - name: Build C64 program
        run: |
          oscar64 -Os -Oo -Oz -tf=prg src/main.c -o dungeon.prg
      - name: Test in VICE
        run: |
          x64sc -console -autostartprgmode 1 dungeon.prg
```

## Memory optimization for 7KB/3KB constraints

### Practical implementation strategy

**Code organization for size optimization:**
```c
// Place initialization code in overlay or separate segment
__attribute__((section("init"))) void initialize_system(void) {
    // One-time setup code - can be overlaid after execution
    init_vic();
    init_sprites(); 
    init_sound();
}

// Main game loop optimized for minimal memory footprint
void main_loop(void) {
    while (1) {
        process_input();           // ~200 bytes
        update_generation();       // ~800 bytes  
        render_dungeon();          // ~400 bytes
        wait_frame();              // ~50 bytes
    }
}
```

**Data structure optimization:**
```c
// Pack multiple data elements efficiently
typedef struct {
    uint8_t room_data;    // bits 0-3: room type, bits 4-7: connections
    uint8_t contents;     // bits 0-2: monster type, bits 3-7: treasure flags  
} PackedRoom;           // Only 2 bytes per room vs 6+ bytes unpacked

// Use bit manipulation for access
#define ROOM_TYPE(room)        ((room).room_data & 0x0F)
#define ROOM_CONNECTIONS(room) ((room).room_data >> 4)
#define SET_ROOM_TYPE(room, type) ((room).room_data = ((room).room_data & 0xF0) | (type))
```

### Advanced memory techniques

**Self-modifying code for space efficiency:**
```c
// Modify jump table entries to avoid storing function pointers
void setup_room_generator(uint8_t room_type) {
    uint16_t generator_addr;
    switch (room_type) {
        case ROOM_CORRIDOR: generator_addr = (uint16_t)generate_corridor; break;
        case ROOM_CHAMBER:  generator_addr = (uint16_t)generate_chamber; break;
        default: generator_addr = (uint16_t)generate_default; break;
    }
    
    // Modify JSR instruction target  
    *((uint16_t*)0x1234) = generator_addr;  // Self-modify jump target
}
```

**Overlay system for large generation algorithms:**
```c
// Load generation algorithms on-demand
void load_generation_overlay(uint8_t algorithm) {
    switch (algorithm) {
        case GEN_BSP_TREE:
            load_file("bsp.ovl", (void*)0x3000);
            break;
        case GEN_CELLULAR:
            load_file("cellular.ovl", (void*)0x3000);  
            break;
    }
    // Call overlay function at fixed address
    ((void(*)())0x3000)();
}
```