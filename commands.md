## Commands

### Accidentally dropped a stash

This will show you all the commits at the tips of your commit graph which are no longer referenced from any branch or tag – every lost commit, including every stash commit you’ve ever created, will be somewhere in that graph.

For more information on recovering a dropped stash in Git, you can refer to this [Stack Overflow post](https://stackoverflow.com/questions/89332/how-do-i-recover-a-dropped-stash-in-git).

```bash
gitk --all $( git fsck --no-reflog | awk '/dangling commit/ {print $3}' )
