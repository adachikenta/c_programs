include $(PathRoot)/_build_/MakefileTool.mk
include $(PathRoot)/_build_/MakefileOption.mk
ifeq ($(Component),main)
include $(PathRoot)/MakefileSubDirs.mk
include $(PathRoot)/_build_/MakefileLibs.mk
endif
include $(PathRoot)/_build_/MakefileDefine.mk
include $(PathRoot)/_build_/MakefileInclude.mk
include $(PathRoot)/_build_/MakefileArtifacts.mk
include $(PathRoot)/_build_/MakefileFunc.mk
include $(PathRoot)/_build_/MakefileRule.mk
