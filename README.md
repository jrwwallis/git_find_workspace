# git_find_workspace
Quickly find all git workspaces in a filesystem

### Skip:
- foreign mounts
- non-directories
- non-accessible directories
- .dot directories (other than . and ..)

Once a git workspace is found, it is not traversed any deeper.

The above policies help make this find expression complete in as little time as possible
