Name: cookbook-snmp
Version: %{__version}
Release: %{__release}%{?dist}
BuildArch: noarch
Summary: snmp cookbook to install and configure snmp tools for redborder environment

License: AGPL 3.0
URL: https://github.com/redBorder/cookbook-snmp
Source0: %{name}-%{version}.tar.gz

%description
%{summary}

%prep
%setup -qn %{name}-%{version}

%build

%install
mkdir -p %{buildroot}/var/chef/cookbooks/snmp
cp -f -r  resources/* %{buildroot}/var/chef/cookbooks/snmp/
chmod -R 0755 %{buildroot}/var/chef/cookbooks/snmp
install -D -m 0644 README.md %{buildroot}/var/chef/cookbooks/snmp/README.md

%pre

%post
case "$1" in
  1)
    # This is an initial install.
    :
  ;;
  2)
    # This is an upgrade.
    su - -s /bin/bash -c 'source /etc/profile && rvm gemset use default && env knife cookbook upload snmp'
  ;;
esac
%files
%defattr(0755,root,root)
/var/chef/cookbooks/snmp
%defattr(0644,root,root)
/var/chef/cookbooks/snmp/README.md

%doc

%changelog
* Wed Dec 14 2016 Alberto Rodríguez <arodriguez@redborder.com> - 1.0.0-1
- first spec version
