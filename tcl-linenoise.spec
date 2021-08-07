%define buildroot %{_tmppath}/%{name}

Name:          tcl-linenoise
Summary:       Tcl Binding to the linenoise line editing library
Version:       1.3_git20210608
Release:       0
License:       TCL
Group:         Development/Libraries/Tcl
Source:        %{name}-%{version}.tar.gz
URL:           https://github.com/andreas-kupries/tcl-linenoise
BuildRequires: gcc
BuildRequires: tcl >= 8.5
BuildRequires: tcl-kettle
BuildRequires: critcl
BuildRequires: critcl-devel
BuildRequires: tcllib
Requires:      tcl >= 8.5
Requires:      critcl
Requires:      critcl-devel
BuildRoot:     %{buildroot}

%description
tcl-linenoise is a Tcl Binding to the linenoise line editing library.

%prep
%setup -q -n %{name}-%{version}

%build

%install
tclsh /usr/bin/kettle -f build.tcl --lib-dir %{buildroot}%_libdir/tcl \
--include-dir %{buildroot}/usr/include install-package-linenoise

%clean
rm -rf %buildroot

%files
%defattr(-,root,root)
%{tcl_archdir}

