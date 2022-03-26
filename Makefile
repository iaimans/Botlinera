-include .env
export

# Get the absolute path to the running Makefile
ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

# Colours
BLUE:=			\033[0;34m
RED:=			\033[0;31m
LIGHT_RED:=		\033[1;31m
WHITE:=			\033[1;37m
LIGHT_VIOLET := \033[1;35m
NO_COLOUR := 	\033[0m

# Environment : { dev, staging, prod }
ENV := dev

PROJECT_NAME := botlinera

MSG_SEPARATOR := "*********************************************************************"
MSG_IDENT := "    "


.SILENT:

help:
	echo "\n${MSG_SEPARATOR}\n$(LIGHT_VIOLET)$(PROJECT_NAME)$(NO_COLOUR)\n${MSG_SEPARATOR}\n"
	echo "${MSG_IDENT}=======   ✨  BASIC   =====================================\n   "
	echo "${MSG_IDENT}  ⚠️   Requirements : Java 17 \n"
	echo "${MSG_IDENT}  clean                   -  🚮  Erase the 📁 build/"
	echo "${MSG_IDENT}  test                    -  ✅  Run Unit tests"
	echo "${MSG_IDENT}  run                     -  🚀  Run the app with profile '${ENV}'"
	echo

######################################################################
########################   BASIC    #################################
######################################################################

clean:
	echo "\n\n${MSG_SEPARATOR}\n\n CLEAN => 🚮  Erase the 📁 build/\n\n${MSG_SEPARATOR}\n\n"

	./gradlew clean

test: clean
	./gradlew test

run: clean
	./gradlew run
