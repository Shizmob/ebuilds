# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cron eutils toolchain-funcs

DESCRIPTION="A new cron system designed with secure operations in mind"
HOMEPAGE="http://untroubled.org/bcron/"
SRC_URI="http://untroubled.org/bcron/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

DEPEND=">=dev-libs/bglibs-1.031"
RDEPEND="  sys-apps/findutils
         >=sys-process/cronbase-0.3.2
           virtual/mta
           sys-apps/ucspi-unix"

CRON_SYSTEM_CRONTAB="yes"


src_prepare() {
	epatch "${FILESDIR}/bcron-0.10-fix-missing-reference.patch"
}

src_compile() {
	echo "/usr/include/bglibs" > conf-bgincs
	echo "/usr/lib/bglibs" > conf-bglibs
	echo "${D}/usr/bin" > conf-bin
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
	emake
}

src_install() {
	# Install binaries.
	dobin bcron-exec bcron-sched bcron-spool bcron-start bcron-update
	newbin bcrontab crontab

	# Install manual.
	doman bcron-exec.8 bcron-sched.8 bcron-spool.8 bcron-start.8 bcron-update.8
	doman bcrontab.1 crontab.5

	# And documentation.
	use doc && dodoc ANNOUNCEMENT COPYING NEWS README TODO VERSION

	# Setup crontab.
	insinto /etc
	doins "${FILESDIR}/crontab"

	# Setup directories and files.
	dodir /etc/bcron
	keepdir /etc/cron.d
	for x in crontabs tmp; do
		keepdir /var/spool/cron/$x;
		fowners cron:cron /var/spool/cron/$x
		fperms go-rwx /var/spool/cron/$x
	done

	# Setup conf.d and init.d entries.
	newconfd "${FILESDIR}/bcron.confd" bcron
	newinitd "${FILESDIR}/bcron.rc" bcron

	# And setup utilities.
	dobin "${FILESDIR}/envdir"
}

pkg_config() {
	local fifo="${ROOT}var/spool/cron/trigger"
	if [[ ! -e "${fifo}" ]]; then
		mkfifo "$fifo" || die "mkfifo failed"
		fowners cron:cron "${fifo}"
		fperms go-rwx "${fifo}"
	fi
}

pkg_postinst() {
	elog "Run emerge --config =${PF} to finish package configuration."
	cron_pkg_postinst
}
