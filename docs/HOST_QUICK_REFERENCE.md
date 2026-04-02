# ShopRemote2 Host-Only Build - Quick Reference Card

**Print this and keep it handy during implementation!**

---

## What Are We Building?

```
TeamViewer Host mode for ShopRemote2
├─ Accepts incoming connections ✓
├─ Shows server ID & password ✓
├─ Allows remote control of your machine ✓
├─ Initiates outgoing connections ✗
├─ Shows address book/peer list ✗
└─ Allows connecting to other machines ✗
```

---

## Key Code Locations

### Rust
| Component | File | Lines | Action |
|-----------|------|-------|--------|
| Server functionality | `src/server/` | - | KEEP |
| Client/controller | `src/client.rs` | ~153KB | GATE with `#[cfg(...)]` |
| Config check | `src/common.rs` | ~84KB | USE: `is_incoming_only()` |
| UI interfaces | `src/ui_interface.rs` | ~48KB | SELECTIVE: gate methods |
| Flutter FFI | `src/flutter_ffi.rs` | ~95KB | GATE: RPC calls |
| Port forwarding | `src/port_forward.rs` | ~8KB | GATE: exclude |
| Whiteboard | `src/whiteboard.rs` | ~18KB | GATE: exclude |

### Flutter
| Component | File | Lines | Action |
|-----------|------|-------|--------|
| Entry point | `lib/main.dart` | ~200 | ADD: conditional init |
| Host entry | `lib/main_host.dart` | - | CREATE NEW |
| Home page | `lib/desktop/pages/desktop_home_page.dart` | ~37KB | ENHANCE: show host UI |
| Settings | `lib/desktop/pages/desktop_setting_page.dart` | ~102KB | FILTER: hide client options |
| Server page | `lib/desktop/pages/server_page.dart` | ~48KB | REVIEW: already host-focused |
| Server model | `lib/models/server_model.dart` | ~28KB | REVIEW: check host methods |

---

## Implementation Checklist

### Phase 1: Rust (Week 1)
- [ ] Add `host-only` feature to Cargo.toml (line 24)
- [ ] Gate `src/client.rs` with `#[cfg(not(feature = "host-only"))]`
- [ ] Update `src/lib.rs` module declarations
- [ ] Gate `src/port_forward.rs` and `src/whiteboard.rs`
- [ ] Test: `cargo build --features host-only`
- [ ] Verify: `cargo tree --features host-only | grep client` (should be empty)

### Phase 2: Flutter (Week 2)
- [ ] Create `flutter/lib/main_host.dart`
- [ ] Update `flutter/lib/main.dart` conditional init
- [ ] Enhance `flutter/lib/desktop/pages/desktop_home_page.dart`
- [ ] Create `flutter/lib/desktop/widgets/server_status_widget.dart`
- [ ] Create `flutter/lib/desktop/widgets/connected_clients_list.dart`
- [ ] Filter `flutter/lib/desktop/pages/desktop_setting_page.dart`
- [ ] Test: `flutter run` shows host-only UI

### Phase 3: Build System (Week 2-3)
- [ ] Add `--host-only` to `build.py` (line 100-110)
- [ ] Test: `python3 build.py --flutter --host-only`
- [ ] Update `.github/workflows/flutter-build.yml`
- [ ] Create host-only binary variant

### Phase 4: Testing (Week 3-4)
- [ ] Unit tests for feature gating
- [ ] Integration tests for host functionality
- [ ] Manual testing: Windows, Linux, macOS
- [ ] Performance profiling
- [ ] Documentation updates

---

## Code Patterns

### Gate Rust Code (Feature Flag)
```rust
// Exclude entire module
#[cfg(not(feature = "host-only"))]
mod client;

// Exclude specific method
#[cfg(not(feature = "host-only"))]
fn enable_remote_input(&self) { }

// Exclude imports
#[cfg(not(feature = "host-only"))]
use crate::client::*;
```

### Check at Runtime (Dart)
```dart
// Check if running in host-only mode
if (bind.isIncomingOnly()) {
    // Show host UI
    return buildHostServerPage();
} else {
    // Show controller UI
    return buildControllerPage();
}

// Hide controller buttons
if (!bind.isIncomingOnly()) {
    return connectButton();
}
```

---

## Build Commands

```bash
# Compile Rust
cargo build --release --features host-only

# Verify feature gate
cargo tree --features host-only | grep client | wc -l
# Expected: 0 lines

# Flutter build
flutter build windows --release
flutter build linux --release
flutter build macos --release

# Full build with build.py
python3 build.py --flutter --host-only

# Test the binary
./target/release/shopremote2
# Should show: "Ready to accept connections"
```

---

## Testing Commands

```bash
# Compile-time verification
cargo build --features host-only 2>&1 | grep -i error | wc -l
# Expected: 0 errors

# Size comparison
ls -lh target/release/shopremote2*
# Host-only should be 10-20MB smaller

# Runtime test
./target/release/shopremote2 &
# Check: Server ID displayed
# Check: Password shown
# Check: No address book visible

# Flutter UI test
flutter run
# Check: Home page shows server status
# Check: No "Connect to peer" button
# Check: Settings page hides remote options
```

---

## Troubleshooting

### Compilation Error: `cannot find type 'XYZ'`
**Problem**: Rust code references client types
**Solution**: Check if XYZ is in `src/client.rs` and gate it with `#[cfg(...)]` or move to server-only location

### Flutter: "Undefined 'bind.someClientFunction()'"
**Problem**: Flutter calling non-existent RPC
**Solution**: Check if RPC is gated in `src/flutter_ffi.rs` - needs `#[cfg(...)]` wrapper

### Build size didn't decrease
**Problem**: Client code still being linked
**Solution**:
1. Verify `--features host-only` passed to cargo
2. Check `Cargo.lock` - delete and rebuild
3. Run `cargo clean && cargo build --release --features host-only`

### Host mode UI not showing
**Problem**: Flutter not detecting incoming-only mode
**Solution**:
1. Check Rust side is compiled with host-only feature
2. Verify `bind.isIncomingOnly()` returns true
3. Check config file has `conn-type = incoming`

---

## Key Files to Monitor

### Critical Paths
- `Cargo.toml` - Feature flag definitions
- `src/lib.rs` - Module declarations
- `src/flutter_ffi.rs` - RPC interface (must gate all client calls)
- `flutter/lib/main.dart` - Entry point logic
- `build.py` - Build configuration

### High Complexity
- `src/ui_interface.rs` - Mixed host/client logic (need selective gating)
- `src/flutter_ffi.rs` - Large file with many RPC calls
- `flutter/lib/desktop/pages/desktop_setting_page.dart` - Complex settings UI

### Already Good
- `src/server/` - Complete server implementation
- `src/common.rs` - Has `is_incoming_only()` function
- `flutter/lib/models/server_model.dart` - Host-focused model

---

## Architecture Decision

**Feature Gate Pattern** (chosen approach):
```
Rust:   --features host-only         ← Compile-time exclusion
Flutter: bind.isIncomingOnly()       ← Runtime checking
Result: Single binary with conditional behavior
```

**NOT used:**
- ❌ Separate Flutter flavors (too complex)
- ❌ Forked codebase (maintenance nightmare)
- ❌ Two separate binaries (duplicate maintenance)

---

## Success Metrics

| Metric | Target | How to Measure |
|--------|--------|---|
| **Binary Size** | 10-15MB smaller | `ls -lh target/release/shopremote2*` |
| **Compilation Time** | < 5 min on fast machine | Time `cargo build --features host-only` |
| **Client Code Excluded** | 0 client modules linked | `cargo tree --features host-only \| grep client` |
| **Unit Tests Pass** | 100% | `cargo test --features host-only` |
| **Flutter UI** | No client buttons | Visual inspection |
| **Runtime Performance** | No regression | Benchmark same as full build |
| **Cross-Platform** | Windows, Linux, macOS | Build on each OS |

---

## Handy Aliases

Add to `.bashrc` or `.zshrc`:

```bash
# Quick host build
alias build-host='cargo build --release --features host-only'

# Quick verification
alias verify-host='cargo tree --features host-only | grep client | wc -l'

# Quick test
alias test-host='cargo test --features host-only'

# Full build check
alias check-build='build-host && verify-host && echo "✓ Build OK"'
```

---

## Documentation Map

| Document | Purpose | When to Read |
|----------|---------|---|
| `HOST_BUILD_README.md` | Overview & navigation | First thing |
| `HOST_ANALYSIS_SUMMARY.md` | Executive summary | Planning phase |
| `HOST_DEV_PLAN.md` | Implementation spec | During coding |
| `HOST_TEST_PLAN.md` | Testing strategy | QA phase |
| `HOST_SPEC.md` | Requirements | Design phase |
| `HOST_QUICK_REFERENCE.md` | This card! | Daily reference |

---

## Common Mistakes to Avoid

❌ Forgetting to gate imports
```rust
// WRONG
use crate::client::SomeType;  // Will fail to compile
// RIGHT
#[cfg(not(feature = "host-only"))]
use crate::client::SomeType;
```

❌ Checking feature flag in Dart (can't)
```dart
// WRONG - #[cfg(...)] is Rust-only
if (cfg(feature = "host-only")) { }
// RIGHT - Check at runtime
if (bind.isIncomingOnly()) { }
```

❌ Incomplete client exclusion
```rust
// WRONG - Some client methods still compile
#[cfg(not(feature = "host-only"))]
mod client {
    pub fn client_func1() { }
    // Oops! client_func2 not gated
    pub fn client_func2() { }
}
// RIGHT - Gate all or use .rs file gating
```

❌ Breaking full build
```rust
// WRONG - Doesn't compile without feature
fn some_function() {
    client_only_function();  // ERROR in full build!
}
// RIGHT - Gate the call
#[cfg(not(feature = "host-only"))]
fn some_function() {
    client_only_function();
}
```

---

## Emergency Contacts

- **Rust blockers**: Check `src/lib.rs` and search for uses of excluded modules
- **Flutter blockers**: Check `bind.isIncomingOnly()` implementation in Rust
- **Build issues**: Verify feature flags in `Cargo.toml` and `.github/workflows/`
- **Test failures**: Review `HOST_TEST_PLAN.md` for expected behaviors

---

**Last Updated**: 2026-04-02
**Status**: Ready to Print & Use
**Format**: Single-page reference (print double-sided to save paper)

---

## Legend

✓ = Keep/Already good
✗ = Exclude/Remove
~ = Selective/Partial
← = Reference/Link
