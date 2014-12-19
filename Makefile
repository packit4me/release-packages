PACKAGE := $(shell basename *.spec .spec)
ARCH = noarch
RPMBUILD = rpmbuild --define "_topdir %(pwd)/rpm-build" \
	--define "_builddir %{_topdir}" \
	--define "_rpmdir %(pwd)/rpms" \
	--define "_srcrpmdir %{_rpmdir}" \
	--define "_sourcedir  %{_topdir}"
PYTHON = $(which python)
TARGETHOST = nytefyre.net
TARGETDIR = ./packit4me/puppetmodules/rpms/noarch/
STARGETDIR = ./packit4me/puppetmodules/rpms/srpms/
LATESTRPM = ./packit4me/packit4me-puppetmodules-release.latest.rpm

all: rpms

clean:
	rm -rf dist/ build/ rpm-build/ rpms/

install: clean
	mkdir -p ${DISTDIR}/etc/yum.repos.d/
	cp packit4me*-release/*.repo ${DISTDIR}/etc/yum.repos.d/

reinstall: uninstall install

uninstall: clean
	rm -f /etc/yum.repos.d/packit4me*.repo

uninstall_rpms: clean
	rpm -e ${PACKAGE}

sdist:
	mkdir -p dist/
	tar -czf dist/${PACKAGE}.tgz ${PACKAGE}/

prep_rpmbuild: sdist
	mkdir -p rpm-build
	mkdir -p rpms
	cp dist/*.tgz rpm-build/

rpms: prep_rpmbuild
	${RPMBUILD} -ba ${PACKAGE}.spec

srpm: prep_rpmbuild
	${RPMBUILD} -bs ${PACKAGE}.spec

publish:
	scp rpms/*.rpm ${TARGETHOST}:${STARGETDIR}
	scp rpms/noarch/*.rpm ${TARGETHOST}:${TARGETDIR}
