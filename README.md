# Personal repo for my dotfiles

## Usage:
`stow -vt ~ *` To stow everything or `stow -vt ~ <folder>` to stow only the specified folder

## Newsboat
### Getting count of unread items:
One solution is using `newsboat -x print-unread` but that will fail when there is more than one instance of newsboat running.
Instead, a better solution is to simple run a query on the `~/.newsboat/cache.db`. For example: `select count(*) from rss_item where unread=1;`

## XMonad
XMonad is built using stack instead. Arch haskell packages are a mess.
