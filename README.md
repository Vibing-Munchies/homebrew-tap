# homebrew-tap

Homebrew tap of the Vibing Munchies org. Formulae build from private repositories; installing needs an SSH key with access to them.

## Install

```sh
brew tap vibing-munchies/tap git@github.com:Vibing-Munchies/homebrew-tap.git
brew trust --tap vibing-munchies/tap
brew install kehrwoche mydealz           # or just one of them
```

Update with `brew update && brew upgrade`.

> **Tapped before 2026-11-21?** The tap history was replaced. Reset your clone once:
>
> ```sh
> git -C "$(brew --repository vibing-munchies/tap)" fetch origin
> git -C "$(brew --repository vibing-munchies/tap)" reset --hard origin/main
> ```

## Releasing a tool

Every change to `main` needs a pull request approved by a second member. Nobody can push to `main` directly, admins included.

1. In the tool's repository: bump the version, commit, `git tag -a vX.Y.Z -m "<tool> X.Y.Z"`, `git push origin main vX.Y.Z`.
2. Here: on a branch `release/<tool>-vX.Y.Z`, set `tag` and `revision` (`git rev-parse 'vX.Y.Z^{commit}'` in the tool's repository) in `Formula/<tool>.rb`, commit "Point <tool> at vX.Y.Z", push the branch.
3. `gh pr create --title "Point <tool> at vX.Y.Z" --body "<old revision>..<new revision>"`.
4. A second member reviews (below), runs `gh pr review --approve`, then `gh pr merge --squash`.

## Reviewing a release

The tool repositories are open to every member, so the review covers the tool's code, not only the formula:

1. `git ls-remote git@github.com:Vibing-Munchies/<repo>.git 'refs/tags/vX.Y.Z^{}'` prints the `revision` in the PR.
2. In your clone of the tool: `git fetch --tags`, then read `git log --format='%h %an %s' <old>..<new>` and `git diff <old> <new>`. Every commit must be one you expect.
3. The formula diff changes only `tag` and `revision`, unless the PR description explains more. Formulae are Ruby that runs on every member's Mac.

New pushes to a PR dismiss earlier approvals, and the last pusher cannot approve.

## Development

```sh
pre-commit install             # once per clone
```

The hooks check every formula with the system Ruby (`ruby -c`), refuse whitespace errors and conflict markers, and refuse commits whose author email is not a GitHub noreply address (this repo is public). Set yours once per clone: `git config user.email <id>+<login>@users.noreply.github.com` (shown at github.com/settings/emails). They are local commands; nothing is downloaded. Do not use `brew style`: it may install gems.
