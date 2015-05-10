Shiz's Gentoo overlay
=====================

A collection of hopefully useful ebuilds.

Installing
----------
Add to `/etc/portage/repos.conf`:

    [shiz-overlay]
    location = /usr/local/portage/overlays/shiz
    sync-type = git
    sync-uri = git://git.shiz.me/shiz/overlay.git
    auto-sync = yes
    priority = 1000   # optional

Make sure `/usr/local/portage/overlays` exist and is writable by the `portage` user.
