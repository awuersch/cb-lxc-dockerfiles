Scripts to simplify calling containers.

Scripts with underscores run local registry containers.
Volumes are accessed via a table mapping labels to lists of volume ids.

Most local scripts call `$CONTAINER_DIR/bin/run` scripts.
A few don't.

Scripts with dashes run external registry containers.
