EAPI=5
DESCRIPTION="Fine init environment."
HOMEPAGE="https://git.shiz.me/shiz/finite"
LICENSE="BSD-2"
SLOT="0"

if [[ ${PV} != 9999 ]]; then
	KEYWORDS="~amd64"
	SRC_URI="https://git.shiz.me/shiz/finite/archive/v${PV}.tar.gz"
	S="${WORKDIR}/${PN}-v${PV}"
else
	inherit git-r3
	EGIT_REPO_URI="https://git.shiz.me/shiz/finite.git"
fi

IUSE="+sysvinit"
REQUIRED_USE="^^ ( sysvinit )"
DEPEND="sysvinit? ( !sys-apps/sysvinit )"

src_compile()
{
	if use sysvinit; then
		emake sysvinit || die "emake failed"
	fi
}

src_install()
{
	if use sysvinit; then
		emake DESTDIR="${D}" install-sysvinit || die "emake failed"
		insinto /etc
		doins "${FILESDIR}/inittab"
	fi
}
