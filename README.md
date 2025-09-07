
````markdown
# homebrew-org (tap)

This is the Homebrew **tap** for installing the `org` VM orchestrator CLI (`orgctl`).

- **Users**: `brew tap tjamescouch/org && brew install org`
- **What you get**: a tiny, auditable Bash CLI (`orgctl`). It does **not** create VMs during `brew install`.
- **When side-effects happen**: only when you run `orgctl` commands (e.g., `orgctl vm init`), visible in your terminal.

---

## Quick start (users)

```bash
brew tap tjamescouch/org
brew install org
brew install --cask virtualbox     # VM provider (install once, approve kext if macOS asks)
orgctl vm init                     # creates a minimal Ubuntu VM and sets up basics
orgctl app install --from host     # sync your current repo into the VM & run install.sh
# Alternatives:
#   orgctl app install --from git --ssh-agent
#   orgctl app install --from tar --tar-url https://.../org-X.Y.Z.tgz --tar-sha256 <sha256>
````

**Why this is “trusted”:** the formula only installs `orgctl`. All VM work happens when you explicitly run `orgctl`, and the script is small enough to read before use.

---

## What’s installed

* `orgctl` (Bash). It can:

  * create a VirtualBox VM (`orgctl vm init`, `vm up|stop|destroy|ssh|export`)
  * install the app into the VM via:

    * `--from host` (rsync your local checkout; **no credentials in the VM**)
    * `--from git` (clone inside VM; use `--ssh-agent` to avoid storing secrets)
    * `--from tar` (verified release tarball + SHA256)

---

## Requirements

* Homebrew on macOS or Linux
* VirtualBox (`brew install --cask virtualbox`)
* An SSH public key in `~/.ssh` (ed25519 preferred)

---

## Troubleshooting

* **VirtualBox fails to load (macOS):** open *System Settings → Privacy & Security* and approve the Oracle extension; then reboot.
* **`VBoxManage` not found:** reinstall the cask: `brew reinstall --cask virtualbox`.
* **SSH to VM times out:** `orgctl vm up` then retry; or `orgctl vm destroy && orgctl vm init` to rebuild.

---

## Verify integrity

Homebrew checks the tarball hash in the formula. You can verify manually too:

```bash
shasum -a 256 /path/to/orgctl-<version>.tar.gz
# compare with the sha256 field in Formula/org.rb
```

---

## Uninstall

```bash
brew uninstall org
brew untap tjamescouch/org
# Optional: remove the VM
orgctl vm destroy
```

---

## Maintainers (release process)

1. **Build the tarball**

   ```bash
   VERSION=0.1.0
   mkdir -p dist/orgctl-$VERSION && cp orgctl dist/orgctl-$VERSION/
   tar -C dist -czf dist/orgctl-$VERSION.tar.gz orgctl-$VERSION
   shasum -a 256 dist/orgctl-$VERSION.tar.gz
   ```
2. **Publish** `orgctl-$VERSION.tar.gz` on a GitHub Release (any repo you prefer).
3. **Update the formula** `Formula/org.rb`:

   * bump `version`
   * set `url` to the new tarball
   * paste the new `sha256`
4. **Self-test**

   ```bash
   brew tap tjamescouch/org https://github.com/tjamescouch/homebrew-org
   brew install --build-from-source tjamescouch/org/org
   orgctl version
   ```
5. **Style & audit (optional)**

   ```bash
   brew style --fix tjamescouch/org
   brew audit --new --strict tjamescouch/org/org
   ```

---

## Security model (high level)

* `brew install org` only installs `orgctl` (no hidden changes).
* Default app install is **host → VM sync** (no credentials inside the VM).
* Git clone path can use **SSH agent-forwarding** so private keys stay on the host.
* Tarball installs can be **hash-verified** for reproducibility.

---

## Links

* Main project: [https://github.com/tjamescouch/org](https://github.com/tjamescouch/org)
* Issues: please file in the main project repo.

---

## License

MIT. See the main project’s LICENSE.

```
