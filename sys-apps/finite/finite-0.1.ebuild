# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Fine init environment"
HOMEPAGE="https://github.com/Shizmob/finite"

LICENSE="BSD-2"
SLOT="0"

if [[ ${PV} != 9999 ]]; then
	MY_PV=v${PV}
	SRC_URI="https://github.com/Shizmob/finite/archive/${MY_PV}.tar.gz"
	KEYWORDS="~amd64"
	S=${WORKDIR}/${PN}-${MY_PV}
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Shizmob/finite"
fi

RDEPEND="!sys-apps/sysvinit"


src_compile()
{
	emake sysvinit
}

src_install()
{
	emake DESTDIR="${D}" install-sysvinit symlink-sysvinit
	insinto /etc
	doins "${FILESDIR}/inittab"
}
