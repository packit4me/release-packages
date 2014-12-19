%define base_name packit4me-puppetmodules

Name:           %{base_name}-release
Version:        0.1.0
Release:        1%{?dist}
Summary:        Yum configuration for PackIt4Me's Puppet modules repostitory
License:        GPLv3
URL:            https://github.rackspace.com/packit4me/release-packages
Source0:        %{name}.tgz

BuildArch:      noarch

Requires:       yum

%description
PackIt4Me provides a yum repository that has a separate RPM for each
puppet module that are just pulled from fore.puppetlabs.com

%prep
%setup -q -n %{name}


%build

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT%{_sysconfdir}/yum.repos.d/
cp %{base_name}.repo $RPM_BUILD_ROOT%{_sysconfdir}/yum.repos.d/


%files
%defattr(0644,root,root)
%config %{_sysconfdir}/yum.repos.d/%{base_name}.repo


%changelog
* Thu Mar 13 2014 Greg Swift <gregswift@gmail.com> - 0.1.0-1
- Initial release
