# $NetBSD$
#

DISTNAME=	quickbackup-percona-3.6
CATEGORIES=	sysutils
PKGREVISION=	#

MAINTAINER=	jperkin@joyent.com
HOMEPAGE=	http://wiki.joyent.com/jpc2/Joyent+Percona+SmartMachine
COMMENT=	Percona quickbackup SMF service

GIT_REPOSITORIES=	qb-percona
GIT_REPO.qb-percona=	git@git.joyent.com:qb-percona.git
GIT_TAG.qb-percona=	3.6

NO_CHECKSUM=	yes
NO_BUILD=	yes

WRKSRC=			${WRKDIR}/${GIT_REPOSITORIES}
INSTALLATION_DIRS=	bin

do-install:
	${INSTALL_SCRIPT} ${WRKSRC}/quickbackup-percona ${DESTDIR}${PREFIX}/bin

.include "../../wip/mk/git-package.mk"
.include "../../mk/bsd.pkg.mk"
