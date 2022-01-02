Summary: SVOX PicoTTS speech synthesizer
Name: picotts
Version: 17.08.10
Release: 1%{?dist}
License: Apache License 2.0
Group: Applications/Multimedia
URL: https://android.googlesource.com/platform/external/svox/+/master

Source: %{name}-%{version}.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root

BuildRequires: gcc-c++ python libtool popt-devel
%define _unpackaged_files_terminate_build 0

%description
SVOX PicoTTS speech synthesizer.

PackageName: PicoTTS
Type: console-application
Custom:
  Repo: https://github.com/sailfishos-chum/picotts
Categories:
  - Utility
  - Accessibility

%prep
%setup -q 

%build
%{__make} clean || true

%{__make} 

%install
%{__rm} -rf %{buildroot}
%{__make} install DESTDIR=%{buildroot}

%clean
%{__rm} -rf %{buildroot}

%pre

%post

%files
%defattr(-, root, root, 0755)
%{_bindir}/pico2wave
%{_datadir}/picotts

%changelog
* Wed Aug 10 2017 rinigus <rinigus.git@gmail.com> - 17.08.10-1
- packaging for SFOS
