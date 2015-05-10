Shiz's Gentoo overlay
=====================

A collection of hopefully useful ebuilds.

Installing
----------
Add to `/etc/portage/repos.conf`:

    [shiz-overlay]
    location = /usr/local/portage/overlays/shiz
    sync-type = git
    sync-uri = https://git.shiz.me/shiz/overlay.git
    priority = 1000   # optional

Make sure `/usr/local/portage/overlays` exist and is writable by the `portage` user.

Contents
--------

* `net-irc/weechat`: original from Gentoo, rewritten from CMake to autotools.
* `net-misc/ntpclient`: original from Gentoo, also build `adjtimex`.
* `net-misc/strongswan`: original from Gentoo, removed ridiculous `DEPEND` items.
* `sys-apps/finite`: ebuild for [finite](/shiz/finite).
* `sys-process/bcron`: original from Gentoo, rewritten to work with OpenRC natively and updated to 0.10, as well as other small fixes.
