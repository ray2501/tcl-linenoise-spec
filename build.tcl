#!/usr/bin/tclsh

set arch "x86_64"
set base "tcl-linenoise-1.3_git20210608"

if {[file exists $base]} {
    file delete -force $base
}

set var [list git clone https://github.com/andreas-kupries/tcl-linenoise $base]
exec >@stdout 2>@stderr {*}$var

cd $base

set var2 [list git checkout 18b8513dc158d7a218d43a3f3963b93a2193941a]
exec >@stdout 2>@stderr {*}$var2

set var2 [list git reset --hard]
exec >@stdout 2>@stderr {*}$var2

file delete -force .git

set var [list git clone https://github.com/andreas-kupries/linenoise linenoise]
exec >@stdout 2>@stderr {*}$var

cd linenoise

set var2 [list git checkout a2389c9fea8f3bd0d791ea4c30b9132ed2319b71]
exec >@stdout 2>@stderr {*}$var2

set var2 [list git reset --hard]
exec >@stdout 2>@stderr {*}$var2

file delete -force .git

cd ..
cd ..

if {[file exists $base]} {
    file delete -force $base/.git
}

set var2 [list tar czvf ${base}.tar.gz $base]
exec >@stdout 2>@stderr {*}$var2

if {[file exists build]} {
    file delete -force build
}

file mkdir build/BUILD build/RPMS build/SOURCES build/SPECS build/SRPMS
file copy -force $base.tar.gz build/SOURCES

set buildit [list rpmbuild --target $arch --define "_topdir [pwd]/build" -bb tcl-linenoise.spec]
exec >@stdout 2>@stderr {*}$buildit

# Remove our source code
file delete -force $base
file delete -force $base.tar.gz

