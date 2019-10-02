#!/bin/bash
echo -n "Match: "
echo grep | grep grep >/dev/null; echo $?
echo -n "Inverted match (-v): "
echo grep | grep -v grep; echo $?
echo -n "Nonmatch: "
echo grep | grep grepx; echo $?
echo -n "Inverted nonmatch (-v): "
echo grep | grep -v grepx >/dev/null; echo $?
echo -n "Quiet match (-q): "
echo grep | grep -q grep; echo $?
echo -n "Quiet nonmatch (-q): "
echo grep | grep -q grepx; echo $?
echo -n "Inverted quiet match (-qv): "
echo grep | grep -qv grep; echo $?
echo -n "Inverted quiet nonmatch (-qv): "
echo grep | grep -qv grepx; echo $?
