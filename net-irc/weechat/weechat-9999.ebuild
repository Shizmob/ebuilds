# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/weechat/weechat-9999.ebuild,v 1.39 2015/04/01 20:52:24 radhermit Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )
inherit autotools python-single-r1 multilib git-r3

EGIT_REPO_URI="https://github.com/weechat/weechat.git"
DESCRIPTION="Portable and multi-interface IRC client"
HOMEPAGE="http://weechat.org/"

LICENSE="GPL-3"
SLOT="0"

NETWORKS="+irc"
PLUGINS="+alias +charset +exec +fifo +logger +relay +scripts +spell +trigger +xfer"
SCRIPT_LANGS="guile lua +perl +python ruby tcl"
LANGS=" cs de es fr hu it ja pl pt_BR ru tr"
IUSE="doc nls +ssl test ${LANGS// / linguas_} ${SCRIPT_LANGS} ${PLUGINS} ${INTERFACES} ${NETWORKS}"

RDEPEND="
	dev-libs/libgcrypt:0=
	net-misc/curl[ssl]
	sys-libs/ncurses
	sys-libs/zlib
	charset? ( virtual/libiconv )
	guile? ( dev-scheme/guile:12 )
	lua? ( dev-lang/lua:0[deprecated] )
	nls? ( virtual/libintl )
	perl? ( dev-lang/perl )
	python? ( ${PYTHON_DEPS} )
	ruby? ( >=dev-lang/ruby-1.9 )
	ssl? ( net-libs/gnutls )
	spell? ( app-text/aspell )
	tcl? ( >=dev-lang/tcl-8.4.15:0= )
"
DEPEND="${RDEPEND}
	doc? (
		app-text/asciidoc
		dev-util/source-highlight
	)
	nls? ( >=sys-devel/gettext-0.15 )
	test? ( dev-util/cpputest )
"

DOCS="AUTHORS.asciidoc ChangeLog.asciidoc ReleaseNotes.asciidoc README.asciidoc"

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_prepare() {
	use nls || epatch "${FILESDIR}/01-weechat-disable-localization.patch"
	epatch_user
	eautoreconf
}

src_configure() {
	local extraargs=
	use python && [[ ${EPYTHON} == python3* ]] && extraargs="${extraargs} $(use_enable python python3)"
	econf \
		--enable-ncurses \
		--enable-largefile \
		$(use_enable doc) \
		$(use_enable nls) \
		$(use_enable ssl gnutls) \
		$(use_enable test tests) \
		$(use_enable alias) \
		$(use_enable charset) \
		$(use_enable exec) \
		$(use_enable fifo) \
		$(use_enable irc) \
		$(use_enable logger) \
		$(use_enable relay) \
		$(use_enable scripts) \
		$(use_enable scripts script) \
		$(use_enable spell aspell) \
		$(use_enable trigger) \
		$(use_enable xfer) \
		$(use_enable guile) \
		$(use_enable lua) \
		$(use_enable perl) \
		$(use_enable python) \
		$(use_enable ruby) \
		$(use_enable tcl) \
		${extraargs}
}
