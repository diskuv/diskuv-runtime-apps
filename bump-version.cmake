# Test with:
# cmake --log-context -D DRYRUN=1 -D CMAKE_MESSAGE_CONTEXT=dkml-runtime-apps -D "regex_DKML_VERSION_SEMVER=1[.]2[.]1-[0-9]+" -D "regex_DKML_VERSION_OPAMVER=1[.]2[.]1[~]prerel[0-9]+" -D DKML_VERSION_SEMVER_NEW=1.2.1-3 -D DKML_VERSION_OPAMVER_NEW=1.2.1~prerel3 -D GIT_EXECUTABLE=git -D DKML_RELEASE_OCAML_VERSION=4.14.2 -D DKML_BUMP_VERSION_PARTICIPANT_MODULE=../../../pkg/bump/DkMLBumpVersionParticipant.cmake -P bump-version.cmake

if(NOT DKML_BUMP_VERSION_PARTICIPANT_MODULE)
    message(FATAL_ERROR "Missing -D DKML_BUMP_VERSION_PARTICIPANT_MODULE=.../DkMLBumpVersionParticipant.cmake")
endif()
include(${DKML_BUMP_VERSION_PARTICIPANT_MODULE})

DkMLBumpVersionParticipant_PlainReplace(src/runtimelib/version.txt)
DkMLBumpVersionParticipant_OpamReplace(dkml-apps.opam)
DkMLBumpVersionParticipant_OpamReplace(dkml-exe-lib.opam)
DkMLBumpVersionParticipant_OpamReplace(dkml-exe.opam)
DkMLBumpVersionParticipant_OpamReplace(dkml-runtimelib.opam)
DkMLBumpVersionParticipant_OpamReplace(dkml-runtimescripts.opam)
DkMLBumpVersionParticipant_OpamReplace(opam-dkml.opam)
DkMLBumpVersionParticipant_OpamReplace(with-dkml.opam)
DkMLBumpVersionParticipant_DuneProjectReplace(dune-project)
DkMLBumpVersionParticipant_GitAddAndCommit()
