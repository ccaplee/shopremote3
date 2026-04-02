# ShopRemote2 Host-Only Build - Analysis Summary

**Executive Summary for Development Team**

---

## What We're Building

A **Host-only version of ShopRemote2** that acts like TeamViewer Host:
- ✓ Accepts incoming remote connections
- ✓ Allows others to control your machine
- ✓ Displays your device ID, password, connection status
- ✗ Does NOT allow you to connect to other machines
- ✗ Does NOT show the address book/peer list for outgoing connections

**Key Insight**: The codebase already has partial support for this via `conn-type = incoming` configuration. Our job is to wire it end-to-end and exclude unnecessary client code.

---

## Codebase Structure

### Rust (LibShopRemote2)
```
src/
├── server/          ✓ KEEP (all host functionality)
│   ├── connection.rs
│   ├── service.rs
│   ├── video_service.rs (screen capture)
│   ├── audio_service.rs
│   ├── input_service.rs (receive remote input)
│   └── ... more services ...
│
├── client/          ✗ EXCLUDE (remote control functionality)
│   ├── file_trait.rs
│   ├── helper.rs
│   └── io_loop.rs
│
├── common.rs        ✓ KEEP (shared utilities)
├── platform/        ✓ KEEP (platform-specific host code)
├── ui_interface.rs  ~ SELECTIVE (both host and client methods)
├── flutter.rs       ✓ KEEP (FFI bindings)
├── port_forward.rs  ✗ EXCLUDE (client-only feature)
└── whiteboard.rs    ✗ EXCLUDE (client-only feature)
```

**Codebase size**: ~4.5MB Rust code
- **Host-only components**: ~3.5MB
- **Client-only to exclude**: ~600KB
- **Shared**: ~400KB

### Flutter (Desktop UI)
```
flutter/lib/
├── desktop/pages/
│   ├── server_page.dart           ✓ KEEP (show connected clients)
│   ├── desktop_home_page.dart     ✓ KEEP (but hide right pane)
│   ├── desktop_setting_page.dart  ~ FILTER (hide client settings)
│   ├── remote_page.dart           ✗ EXCLUDE (remote desktop view)
│   ├── file_manager_page.dart     ✗ EXCLUDE (remote file manager)
│   ├── port_forward_page.dart     ✗ EXCLUDE (client feature)
│   └── view_camera_page.dart      ✗ EXCLUDE (client feature)
│
└── models/
    ├── server_model.dart           ✓ KEEP (host management)
    ├── model.dart                  ~ SELECTIVE (FFI model)
    ├── input_model.dart            ✗ EXCLUDE (remote input)
    └── relative_mouse_model.dart   ✗ EXCLUDE (remote mouse)
```

---

## Recommended Architecture

### Hybrid Approach: Feature Flag + Conditional Compilation

**NOT separate binaries, NOT forked codebase** - Keep unified source!

1. **Rust Feature Flag**: `--features host-only`
   - Excludes client code at compile time
   - Saves ~600KB binary size
   - Prevents client modules from being linked

2. **Dart Conditional Logic**: Runtime `bind.isIncomingOnly()` checks
   - Show/hide UI sections
   - Conditional widget trees
   - No compile-time flag needed (runs same code, different UI)

3. **Single Binary with Hardcoded Behavior**
   - `shopremote2-host.exe` is built with `host-only` feature
   - Reads `conn-type = incoming` from config
   - Binary size: ~50-60MB (full: ~60-70MB)

**Why this?**
- ✓ Single codebase to maintain
- ✓ Bug fixes apply to both builds
- ✓ Clear separation of concerns
- ✓ No complex build matrix
- ✗ Can't have both host+client in same binary (acceptable)

---

## Key Implementation Points

### Rust Changes (Priority Order)

1. **Add feature flag** (2 hours)
   - Edit `Cargo.toml`
   - Add `host-only = []`

2. **Gate client modules** (8 hours)
   - Wrap `src/client.rs` with `#[cfg(not(feature = "host-only"))]`
   - Wrap `src/port_forward.rs`, `src/whiteboard.rs`
   - Update `src/lib.rs` mod declarations

3. **Filter UI interfaces** (12 hours)
   - `src/ui_interface.rs` - remove client-only methods
   - `src/flutter_ffi.rs` - gate RPC calls (keyboard, mouse, file)
   - Test compilation still works

### Flutter Changes (Priority Order)

1. **Create host-only entry point** (4 hours)
   - New `lib/main_host.dart`
   - Specialized initialization for host mode

2. **Update home page** (8 hours)
   - `desktop_home_page.dart` - enhance host UI
   - Create `server_status_widget.dart` (ID, password, encryption)
   - Create `connected_clients_widget.dart` (client list)

3. **Filter settings page** (6 hours)
   - `desktop_setting_page.dart` - hide controller settings
   - Show only host-relevant options (passwords, services, permissions)

### Build System Changes (Priority Order)

1. **Update build.py** (4 hours)
   - Add `--host-only` argument
   - Adjust feature flags
   - Create `shopremote2-host` binary variant

2. **GitHub Actions** (3 hours)
   - Add matrix for full + host-only builds
   - Create separate artifacts for each

---

## Effort & Timeline

| Phase | Component | Effort | Timeline |
|-------|-----------|--------|----------|
| 1 | Rust foundation | 30 hrs | Week 1 (M-W) |
| 2 | Flutter UI | 25 hrs | Week 1-2 (Th-F, M-Tu) |
| 3 | Build system | 15 hrs | Week 2 (W-F) |
| 4 | Testing & docs | 20 hrs | Week 3-4 |
| **Total** | **All** | **90 hrs** | **3-4 weeks** |

**Actual developer time**: 120-160 hours with:
- Thorough testing
- Documentation
- Code review cycles
- Bug fixes

---

## What Already Exists (Don't Reinvent!)

### Incoming-Only Support
Already in codebase, just needs to be connected:

```rust
// In libs/hbb_common/src/config.rs (already exists!)
pub fn is_incoming_only() -> bool {
    HARD_SETTINGS.read().unwrap()
        .get("conn-type")
        .map_or(false, |x| x == ("incoming"))
}
```

### Flutter Conditional Logic
Already in place:

```dart
// In desktop_home_page.dart line 62-69 (already exists!)
final isIncomingOnly = bind.isIncomingOnly();
if (!isIncomingOnly) {
    // Show right pane (controller features)
}
```

### Server Functionality
Complete:
- `src/server/` directory with all host services
- Video, audio, input, clipboard, terminal services
- Connection management and client handling

---

## Critical Success Factors

### Must Have
1. ✓ Client code completely excluded (no linking)
2. ✓ Host can accept and handle incoming connections
3. ✓ Flutter UI hides all controller features
4. ✓ Binary runs standalone (no dependencies on client modules)
5. ✓ Build system creates separate binary variant

### Should Have
1. ✓ Windows service mode for host (existing framework)
2. ✓ Size reduction of 10-15MB vs full build
3. ✓ Separate CI/CD artifacts for host-only

### Nice to Have
1. ✓ Branding/icon customization
2. ✓ Silent installation mode
3. ✓ Installation wizard for store deployment

---

## Testing Strategy

### Compile-Time Tests
```bash
# Verify client code not included
cargo tree --features host-only | grep client
# Should return: (nothing)

cargo tree | grep client
# Should return: (client modules listed)
```

### Runtime Tests
```
1. Start host-only binary
   - Should show server ID, password
   - Should show "Ready to accept connections"

2. Connect from controller (different machine)
   - Should establish connection
   - Should transmit screen
   - Should receive input

3. Verify host isolation
   - No address book visible
   - No "connect to peer" button
   - No file browser to remote machines
```

### Integration Tests
- Host-only binary launches
- Server starts and listens
- Remote controller connects successfully
- Screen capture works
- Input is received and executed
- File transfer works (host to controller)
- Chat works (host to controller)

---

## Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|-----------|
| Client code has hidden host dependencies | Medium | High | Comprehensive grep+test for cross-dependencies |
| Flutter conditional UI breaks | Medium | Medium | Manual testing on all platforms |
| Binary size increases instead of decreases | Low | Low | Monitor with `ls -lh` on each build |
| Feature breaks full (non-host) build | Medium | High | Run full build tests before release |
| Deployment on store machines fails | Low | High | Test on retail environment hardware |

---

## Next Steps

1. **Create implementation tasks** from Phase 1-4 breakdown
2. **Assign developers** to Rust vs Flutter streams
3. **Set up feature branch**: `feature/host-only-build`
4. **Daily standup** to sync between Rust/Flutter work
5. **Sprint review** at end of each week

---

## Files Generated

- **`HOST_DEV_PLAN.md`** (946 lines)
  - Complete technical specification
  - File-by-file change list
  - Detailed implementation steps
  - Success criteria

- **This summary** (this file)
  - High-level overview
  - Key insights
  - Quick reference
  - Executive summary

---

## Questions & Clarifications Needed

Before starting implementation, confirm:

1. **Binary naming**: Should host-only be `shopremote2-host.exe` or `shopremote2.exe` (with flag)?
   - Recommendation: `shopremote2-host.exe` for clarity

2. **Minimum deployment**: Which platforms are critical for MVP?
   - Windows (probably yes for retail stores)
   - Linux (probably yes for servers)
   - macOS (probably lower priority)

3. **Service mode**: Should host run as Windows Service out of box?
   - Would require additional packaging/installer work
   - Can be post-MVP enhancement

4. **Branding**: Any custom splash screen/icons needed?
   - Not critical for MVP, can be added later

5. **Distribution**: How will stores get binaries?
   - MSI installer for Windows?
   - Direct binary download?
   - Auto-update from server?

---

**Analysis completed by**: Development Team Lead
**Date**: 2026-04-02
**Status**: Ready for implementation
