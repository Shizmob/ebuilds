EAPI=5
DESCRIPTION="Fine init environment."
HOMEPAGE="https://git.shiz.me/shiz/finite"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

inherit git-r3
EGIT_REPO_URI="https://git.shiz.me/shiz/finite.git"
EGIT_COMMIT="v0.1"
IUSE="+sysvinit"
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