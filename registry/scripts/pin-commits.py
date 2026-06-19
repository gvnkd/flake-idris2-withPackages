#!/usr/bin/env python3
"""Pin branch/tag refs in registry packages to concrete commit hashes."""

import re
import subprocess
import sys
from pathlib import Path

PACKAGES_DIR = Path(__file__).parent.parent / "packages"
REV_RE = re.compile(r'rev\s*=\s*"([^"]+)"')
HASH_RE = re.compile(r'(\s*)hash\s*=\s*"[^"]+"')


def is_commit(ref: str) -> bool:
    return len(ref) == 40 and all(c in "0123456789abcdef" for c in ref)


def resolve_branch(owner: str, repo: str, ref: str) -> str | None:
    url = f"https://github.com/{owner}/{repo}.git"
    try:
        out = subprocess.check_output(
            ["git", "ls-remote", "--heads", "--tags", url, ref],
            text=True,
            stderr=subprocess.DEVNULL,
            timeout=30,
        )
        for line in out.strip().splitlines():
            sha, full_ref = line.split(None, 1)
            if full_ref in (f"refs/heads/{ref}", f"refs/tags/{ref}"):
                return sha
    except Exception as e:
        print(f"  ⚠ git ls-remote failed: {e}", file=sys.stderr)
    return None


def prefetch_hash(owner: str, repo: str, commit: str) -> str | None:
    url = f"https://github.com/{owner}/{repo}/archive/{commit}.tar.gz"
    try:
        raw = subprocess.check_output(
            ["nix-prefetch-url", "--unpack", url],
            text=True,
            stderr=subprocess.DEVNULL,
            timeout=120,
        ).strip()
        sri = subprocess.check_output(
            ["nix", "hash", "to-sri", "--type", "sha256", raw],
            text=True,
            stderr=subprocess.DEVNULL,
        ).strip()
        return sri
    except Exception as e:
        print(f"  ⚠ nix-prefetch-url failed: {e}", file=sys.stderr)
    return None


def process_file(path: Path) -> bool:
    text = path.read_text()
    if "fetchFromGitHub" not in text:
        return False

    rev_match = REV_RE.search(text)
    if not rev_match:
        return False

    rev = rev_match.group(1)
    if is_commit(rev):
        return False

    owner_match = re.search(r'owner\s*=\s*"([^"]+)"', text)
    repo_match = re.search(r'repo\s*=\s*"([^"]+)"', text)
    if not owner_match or not repo_match:
        print(f"⚠ {path.name}: missing owner/repo")
        return False

    owner = owner_match.group(1)
    repo = repo_match.group(1)

    print(f"→ {path.stem}: {rev}")
    commit = resolve_branch(owner, repo, rev)
    if not commit:
        print(f"  ✗ Could not resolve {owner}/{repo}@{rev}")
        return False

    print(f"  commit: {commit}")
    new_hash = prefetch_hash(owner, repo, commit)
    if not new_hash:
        print(f"  ✗ Could not prefetch {owner}/{repo}@{commit}")
        return False

    print(f"  hash: {new_hash}")

    text = text.replace(f'rev = "{rev}";', f'rev = "{commit}";')
    timestamp = subprocess.check_output(["date", "+%Y-%m-%d %H:%M:%S"], text=True).strip()
    text = HASH_RE.sub(
        lambda m: f'{m.group(1)}hash = "{new_hash}";  # hash-updated: {timestamp}',
        text,
    )

    path.write_text(text)
    return True


def main():
    updated = 0
    failed = 0
    for path in sorted(PACKAGES_DIR.glob("*.nix")):
        try:
            if process_file(path):
                updated += 1
        except Exception as e:
            print(f"✗ {path.name}: {e}", file=sys.stderr)
            failed += 1

    print(f"\nUpdated {updated} package(s), {failed} failure(s).")


if __name__ == "__main__":
    main()
