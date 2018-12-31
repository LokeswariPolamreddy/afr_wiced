#
# $ Copyright Cypress Semiconductor $
#
# Definitions to create packaged build artifacts.
# These build artifacts are binary output files containing the
# applications/bootloaders/etc... for a given target.
# They are used by the download program to update a target board
# with a given image.
# NOTE: This builds packages of the target (i.e. board/app) objs
# not of wiced itself
#

# Packaging Definitions
# create a temporary file to accumulate the list of artifacts in pkg
# TODO: Accumulate in-make instead of a file
#
# This is to be used in the same fashion as the existing 'download'
# target is used. e.g.
# ./make test.lava_wifi-BCM943907AEVAL1F package
#

PACKAGE_DESCRIPTOR   := $(BUILD_DIR)/package_descriptor.temp
PACKAGE_COUNT := 0
# call is $(call ADD_TO_PACKAGE, filename, offset, type)
define ADD_TO_PACKAGE
       @$(ECHO) Packaging file:$1 dest:$2 offset:$3 type:$4
       $(QUIET)$(ECHO) $(QUOTES_FOR_ECHO){$(ESC_QUOTE)filename$(ESC_QUOTE): $(ESC_QUOTE)$(strip $1)$(ESC_QUOTE), $(ESC_QUOTE)dest$(ESC_QUOTE): $(ESC_QUOTE)$(strip $2)$(ESC_QUOTE), $(ESC_QUOTE)offset$(ESC_QUOTE): $(ESC_QUOTE)$(strip $3)$(ESC_QUOTE), $(ESC_QUOTE)type$(ESC_QUOTE): $(ESC_QUOTE)$(strip $4)$(ESC_QUOTE)},$(QUOTES_FOR_ECHO) >>$(PACKAGE_DESCRIPTOR)
endef

.PHONY: create_package_descriptor

#RELEASE_PACKAGE := $(OUTPUT_DIR)/release.pkg
RELEASE_PACKAGE := $(PACKAGE_OUTPUT_DIR)/release.pkg

# Creating a json file out of makefile rules is not easy...
# Format is
# {"files" : [ <--- create_package_descriptor target
#  {"filename": "file1", "dest" : "dest1", "offset" : "offset1", "type" : "type1"}, <- ADD_TO_PACKAGE macro
#  { ... }, <- ADD_TO_PACKAGE macro
#  {"filename": "fileN", "dest" : "destN", "offset" : "offsetN", "type" : "typeN"}, <- ADD_TO_PACKAGE macro
# {} ],  <- this and everything below, $(RELEASE_PACKAGE) target
# "aux-files": [
# {"filename": "file1", "path": "path1"}
#  { ... },
# {"filename": "fileN", "path": "pathN"}
# {} ]}
#
# "files" section defines files that are going to be programmed to the target device
# "aux-files" section defines auxiliary files for programming, i.e. flash binary, config files etc

# This format is what is expected by the "tools/packaging/create_pkg.py" tool
# that builds a collection of build artifacts into a package that is
# suitable for download by the download tool.

create_package_descriptor:
	$(QUIET)$(ECHO) Create_package_descriptor in wiced_package
	$(QUIET)$(ECHO) $(QUOTES_FOR_ECHO){$(ESC_QUOTE)files$(ESC_QUOTE): [$(QUOTES_FOR_ECHO) >$(PACKAGE_DESCRIPTOR)

# conditionally predefine SFLASH_APP_TARGET for standard targets
SFLASH_APP_TARGET ?= ""

ifeq ($(PLATFORM),CYW9MCU7X9N364)
$(RELEASE_PACKAGE):
	$(QUIET)$(ECHO) CHIPLOAD_PLATFORM_ARGS: $(CHIPLOAD_PLATFORM_ARGS)
	$(QUIET)$(ECHO) $(QUOTES_FOR_ECHO){}],$(QUOTES_FOR_ECHO) >>$(PACKAGE_DESCRIPTOR)
	$(QUIET)$(ECHO) $(QUOTES_FOR_ECHO)$(ESC_QUOTE)chipload_platform_args$(ESC_QUOTE): $(ESC_QUOTE)$(CHIPLOAD_PLATFORM_ARGS)$(ESC_QUOTE),$(QUOTES_FOR_ECHO) >>$(PACKAGE_DESCRIPTOR)
	$(QUIET)$(ECHO) $(QUOTES_FOR_ECHO)$(ESC_QUOTE)aux-files$(ESC_QUOTE): [$(QUOTES_FOR_ECHO) >>$(PACKAGE_DESCRIPTOR)
	$(QUIET)$(ECHO) $(QUOTES_FOR_ECHO){}]}$(QUOTES_FOR_ECHO) >>$(PACKAGE_DESCRIPTOR)
	$(QUIET)$(PYTHON) $(TOOLS_ROOT)/packaging/create_pkg.py --output $(RELEASE_PACKAGE) $(PACKAGE_DESCRIPTOR) \
	--devtarget $(PACKAGE_DEVTARGET) \
	--platform $(PLATFORM) \
	--openocd_host $(HOST_OPENOCD) \
	--tools_root $(WICED_TOOLS_DIR)
	$(QUIET)$(RM) $(PACKAGE_DESCRIPTOR)
else

$(RELEASE_PACKAGE):
	$(QUIET)$(ECHO) $(QUOTES_FOR_ECHO){}],$(QUOTES_FOR_ECHO) >>$(PACKAGE_DESCRIPTOR)
	$(QUIET)$(ECHO) $(QUOTES_FOR_ECHO)$(ESC_QUOTE)aux-files$(ESC_QUOTE): [$(QUOTES_FOR_ECHO) >>$(PACKAGE_DESCRIPTOR)
ifneq ($(strip $(SFLASH_APP_TARGET)),)
	$(QUIET)$(ECHO) Adding: $(SFLASH_APP_TARGET)
	$(QUIET)$(ECHO) $(QUOTES_FOR_ECHO){$(ESC_QUOTE)filename$(ESC_QUOTE): $(ESC_QUOTE)$(SFLASH_APP_TARGET).elf$(ESC_QUOTE), $(ESC_QUOTE)path$(ESC_QUOTE): $(ESC_QUOTE)$(BUILD_DIR)/$(SFLASH_APP_TARGET)/binary$(ESC_QUOTE)},$(QUOTES_FOR_ECHO) >>$(PACKAGE_DESCRIPTOR)
	$(QUIET)$(ECHO) Adding: sflash_write.tcl
	$(QUIET)$(ECHO) $(QUOTES_FOR_ECHO){$(ESC_QUOTE)filename$(ESC_QUOTE): $(ESC_QUOTE)sflash_write.tcl$(ESC_QUOTE), $(ESC_QUOTE)path$(ESC_QUOTE): $(ESC_QUOTE)apps/waf/sflash_write$(ESC_QUOTE)},$(QUOTES_FOR_ECHO) >>$(PACKAGE_DESCRIPTOR)
endif
	$(QUIET)$(ECHO) $(QUOTES_FOR_ECHO){}]}$(QUOTES_FOR_ECHO) >>$(PACKAGE_DESCRIPTOR)
	$(QUIET)$(PYTHON) $(TOOLS_ROOT)/packaging/create_pkg.py --output $(RELEASE_PACKAGE) $(PACKAGE_DESCRIPTOR) \
	--devtarget $(PACKAGE_DEVTARGET) \
	--platform $(PLATFORM) \
	--openocd_cfg $(OPENOCD_PATH)$(HOST_OPENOCD).cfg \
	--flash_app_cfg $(OPENOCD_PATH)$(HOST_OPENOCD)-flash-app.cfg \
	--jtag_cfg $(OPENOCD_PATH)$(JTAG).cfg \
	--openocd_host $(HOST_OPENOCD) \
	--sflash_app_plt_bus $(SFLASH_APP_PLATFROM_BUS) \
	--sflash_app_BCM4390 $(SFLASH_APP_BCM4390) \
	--tools_root $(TOOLS_ROOT)
	$(QUIET)$(RM) $(PACKAGE_DESCRIPTOR)
endif
