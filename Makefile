-include config.mk

INPUT       = gamemd.exe
OUTPUT      = gamemd-cncnet.exe
LDS         = gamemd.lds
IMPORTS     = 0x40F0E0 320
LD_CFLAGS   = -Wl,--section-alignment=0x1000 -Wl,--subsystem=windows -Wl,--enable-stdcall-fixup
LDFLAGS     = --file-alignment=0x1000 --section-alignment=0x1000 --subsystem=windows --enable-stdcall-fixup
DLL_LDFLAGS = -mdll -Wl,--enable-stdcall-fixup
NFLAGS      = -f elf -Iinc/
CFLAGS      = -std=c99 -Iinc/ -I3rdparty/ -DLODEPNG_NO_COMPILE_DISK

REV         = $(shell git rev-parse --short @{0})
VERSION     = SOFT_VERSION-CnCNet-patch-$(REV)
WINDRES_FLAGS = --preprocessor-arg -DVERSION="$(VERSION)"


OBJS = \
                src/no-cd.o \
                src/no_window_frame.o \
                src/custom.mix.o \
                src/custom_connection_timeout.o \
                src/loading.o \
                src/graphics-patch.o \
                src/copy-protection.o \
                src/multi_spectators_hack.o \
                src/absolute_prism_bug_fix.o \
                src/self_spy_exploit_fix.o \
                src/invisible_mcv_exploit_fix.o \
                src/blowfish_dll_disable_option.o \
                src/movie_playback_disable_option.o \
                src/disable_wol_menu.o \
                src/win8_compat-func.o \
                src/win8_compat.o \
                src/rename_logs.o \
                src/multi-engineer_enhancements.o \
                src/fix_mouse_not_found_error.o \
                src/video_mode_hack.o \
                src/type_select_hacks.o \
                src/hide_names_qm.o \
                src/hide_names_qm_s.o \
                src/exception_catch.o \
                src/ra2mode_fixes.o \
                src/chrono_patches.o \
                src/ports_from_ares.o \
                src/high_res_fix.o \
                src/disable_edge_scrolling.o \
                src/fix_common_crashes.o \
                src/single-proc-affinity.o \
                src/online_optimizations.o \
                src/rage_quit.o \
                res/res.o \
                sym.o

SPAWNER_OBJS = \
		src/spawner/selectable_countries.o \
		src/spawner/selectable_handicaps.o \
		src/spawner/selectable_colors.o \
		src/spawner/selectable_spawns.o \
		src/spawner/coop.o \
		src/spawner/predetermined_alliances.o \
		src/spawner/spectators.o \
                src/spawner/skip_score.o \
                src/spawner/add_player_node.o \
		src/spawner/load_spawn.o \
		src/spawner/nethack.o \
                src/spawner/protocol_zero.o \
                src/spawner/random_map.o \

EXTERN_OBJS =

ifdef SPAWNER
        CFLAGS += -DSPAWNER=1
	OBJS += $(SPAWNER_OBJS)
endif

ifdef STATS
        CFLAGS += -DSTATS=1
	SPAWNER_OBJS += src/statistics.o
endif

ifeq (src/extern, $(wildcard src/extern))
        EXTERN_DIRS = $(shell find src/extern/ -maxdepth 1 -type d)
        EXTERN_FILES = $(foreach dir,$(EXTERN_DIRS),$(wildcard $(dir)/Makefile))
        -include $(EXTERN_FILES)
endif

ifdef WWDEBUG
	NFLAGS += -D WWDEBUG
	CFLAGS += -D WWDEBUG
	OBJS += src/yr_util.o \
                src/misc_debug.o
endif

DLL_OBJS = src/ares.o \
           src/no_window_frame.o \
           src/mods/saved_games_in_subdir.o \
           src/fix_mouse_not_found_error.o \
           src/video_mode_hack.o \
           src/type_select_hacks.o \
           src/exception_catch.o \
           src/high_res_fix.o \
           src/disable_edge_scrolling.o \
           src/fix_common_crashes.o \
           src/online_optimizations.o \
           src/rage_quit.o \
           src/single-proc-affinity.o \
           src/spawner/always_spawn.o \
           src/custom_connection_timeout.o \

MO_OBJS = src/mo/rename.o

OBJS += $(EXTERN_OBJS)

PETOOL     ?= petool
STRIP      ?= strip
NASM       ?= nasm
WINDRES    ?= windres

-include custom.mk

.PHONY: default
default: $(OUTPUT)

.PHONY: all
all: gamemd-syringe.exe ares-spawn.dll cncnet-spawn.dll $(OUTPUT)
.PHONY: dll
dll: gamemd-syringe.exe ares-spawn.dll mo-ares-spawn.dll cncnet-spawn.dll

%.o: %.asm
	$(NASM) $(NFLAGS) -o $@ $<

%.o: %.rc
	$(WINDRES) $(WINDRES_FLAGS) $< $@

res/mo_dll_res.o: res/dll_res.rc
	$(WINDRES) $(WINDRES_FLAGS) -DMO=1 $< $@

rsrc.o: $(INPUT)
	$(PETOOL) re2obj $(INPUT) $@

$(OUTPUT): $(LDS) $(INPUT) $(OBJS)
	$(LD) $(LDFLAGS) -T $(LDS) -o $@ $(OBJS)
	$(PETOOL) setdd $@ 1 $(IMPORTS) || ($(RM) $@ && exit 1)
	$(PETOOL) patch $@ || ($(RM) $@ && exit 1)
	$(STRIP) -R .patch $@ || ($(RM) $@ && exit 1)
	$(PETOOL) dump $@


src/spawner/always_spawn.o: src/spawner/load_spawn.c
	$(CC) $(CFLAGS) -DALWAYS_SPAWN -c -o $@ $^

mo-ares-spawn.dll: sym.o res/mo_dll_res.o src/loading_dll.o $(filter-out src/spawner/load_spawn.o, $(SPAWNER_OBJS)) $(DLL_OBJS) $(MO_OBJS)
	$(CC) $(CFLAGS) $(DLL_LDFLAGS) -DARES -o $@ $^ -lmsvcrt
	$(STRIP) $@
	$(PETOOL) dump $@

ares-spawn.dll: sym.o res/dll_res.o src/loading_dll.o $(filter-out src/spawner/load_spawn.o, $(SPAWNER_OBJS)) $(DLL_OBJS)
	$(CC) $(CFLAGS) $(DLL_LDFLAGS) -DARES -o $@ $^ -lmsvcrt
	$(STRIP) $@
	$(PETOOL) dump $@


cncnet-spawn.dll: $(filter-out src/spawner/load_spawn.o,$(OBJS)) $(DLL_OBJS)
	$(CC) $(CFLAGS) $(DLL_LDFLAGS),--dynamicbase -o $@ $^
	$(STRIP) $@
	$(STRIP) -R .syhks00 $@
	$(PETOOL) dump $@

gamemd-syringe.exe: src/gamemd-syringe.c
	$(CC) $(CFLAGS) -o $@ $<

clean:
	$(RM) $(OUTPUT) ares-spawn.dll src/loading_dll.o cncnet-spawn.dll gamemd-syringe.exe res/mo_dll_res.o res/dll_res.o $(ARES_OBJS) $(DLL_OBJS) $(OBJS) $(SPAWNER_OBJS)
