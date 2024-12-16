#!/bin/bash

if [[ -z $(ps -ef | grep electricsheep | grep -v unless_electricsheep | grep -v grep) ]] ; then
    electricsheep
fi
