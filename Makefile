-include config.mk

INPUT		= gamemd.dat
OUTPUT		= gamemd-output.exe
LDS			= gamemd.lds
IMPORTS		= 0x40F0E0 320
LD_CFLAGS	= -Wl,--section-alignment=0x1000 -Wl,--subsystem=windows -Wl,--enable-stdcall-fixup
LDFLAGS		= --file-alignment=0x1000 --section-alignment=0x1000 --subsystem=windows --enable-stdcall-fixup
DLL_LDFLAGS	= -mdll -Wl,--enable-stdcall-fixup
NFLAGS		= -f elf -Iinc/
CFLAGS		= -std=c99 -Iinc/ -I3rdparty/ -DLODEPNG_NO_COMPILE_DISK

REV				= $(shell git rev-parse --short @{0})
VERSION			= SOFT_VERSION-CnCNet-patch-$(REV)
WINDRES_FLAGS	= --preprocessor-arg -DVERSION="$(VERSION)"

EXE_OBJS = \
		src/no-cd.o \
		src/no_window_frame.o \
		src/mods/saved_games_in_subdir.o \
		src/custom.mix.o \
		src/loading.o \
		src/graphics-patch.o \
		src/copy-protection.o \
		src/chat_disable.o \
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
		src/isomappack5_limit_extend.o \
		src/high_res_fix.o \
		src/disable_edge_scrolling.o \
		src/fix_common_crashes.o \
		src/single-proc-affinity.o \
		src/online_optimizations.o \
		src/rage_quit.o \
		src/silent_cheer.o \
		src/artyr_ini_patch.o \
		res/res.o \
		sym.o

DLL_OBJS = src/ares.o \
		src/no_window_frame.o \
		src/mods/saved_games_in_subdir.o \
		src/loading_dll.o \
		src/multi_spectators_hack.o \
		src/fix_mouse_not_found_error.o \
		src/video_mode_hack.o \
		src/type_select_hacks.o \
		src/exception_catch.o \
		src/high_res_fix.o \
		src/disable_edge_scrolling.o \
		src/fix_common_crashes.o \
		src/single-proc-affinity.o \
		src/online_optimizations.o \
		src/rage_quit.o \
		src/spawner/always_spawn.o \
		res/dll_res.o \
		sym.o

SPAWNER_OBJS = \
		src/custom_connection_timeout.o \
		src/Hook_Main_Loop.o \
		src/spawner/add_player_node.o \
		src/spawner/chat_ignore.o \
		src/spawner/coop.o \
		src/spawner/load_spawn.o \
		src/spawner/predetermined_alliances.o \
		src/spawner/extended_events_c.o \
		src/spawner/extended_events.o \
		src/spawner/protocol_zero_c.o \
		src/spawner/protocol_zero.o \
		src/spawner/random_map.o \
		src/spawner/selectable_colors.o \
		src/spawner/selectable_countries.o \
		src/spawner/selectable_handicaps.o \
		src/spawner/selectable_spawns.o \
		src/spawner/skip_score.o \
		src/spawner/spectators.o

ifndef CNCNET
	SPAWNER_OBJS += src/spawner/nethack.o
endif

ifdef CNCNET
	NFLAGS += -DCNCNET=1
	CFLAGS += -DCNCNET=1
	include cncnet/makefile.mk
	EXE_OBJS += $(CNCNET_OBJS)
	DLL_OBJS += $(CNCNET_OBJS)
endif

STATS_OBJS = \
	src/statistics.o

ifdef STATS
	CFLAGS += -DSTATS=1
	SPAWNER_OBJS += $(STATS_OBJS)
endif

ifdef SPAWNER
	CFLAGS += -DSPAWNER=1
	EXE_OBJS += $(SPAWNER_OBJS)
	DLL_OBJS += $(SPAWNER_OBJS)
endif

WWDEBUG_OBJS = \
	src/yr_util.o \
	src/misc_debug.o

ifdef WWDEBUG
	NFLAGS += -D WWDEBUG
	CFLAGS += -D WWDEBUG
	EXE_OBJS += $(WWDEBUG_OBJS)
	DLL_OBJS += $(WWDEBUG_OBJS)
endif

PETOOL ?= petool
STRIP ?= strip
NASM ?= nasm
WINDRES	?= windres

-include custom.mk

.PHONY: default
default: $(OUTPUT)

.PHONY: all
all: cncnet-spawn.dll $(OUTPUT)
.PHONY: dll
dll: cncnet-spawn.dll

%.o: %.asm
	$(NASM) $(NFLAGS) -o $@ $<

%.o: %.rc
	$(WINDRES) $(WINDRES_FLAGS) $< $@

rsrc.o: $(INPUT)
	$(PETOOL) re2obj $(INPUT) $@

$(OUTPUT): $(LDS) $(INPUT) $(EXE_OBJS)
	$(LD) $(LDFLAGS) -T $(LDS) -o $@ $(EXE_OBJS)
	$(PETOOL) setdd $@ 1 $(IMPORTS) || ($(RM) $@ && exit 1)
	$(PETOOL) patch $@ || ($(RM) $@ && exit 1)
	$(STRIP) -R .patch $@ || ($(RM) $@ && exit 1)
	$(PETOOL) dump $@

src/spawner/always_spawn.o: src/spawner/load_spawn.c
	$(CC) $(CFLAGS) -DALWAYS_SPAWN -c -o $@ $^

cncnet-spawn.dll: $(filter-out src/spawner/load_spawn.o, $(DLL_OBJS))
	$(CC) $(CFLAGS) $(DLL_LDFLAGS) -DARES -o $@ $^ -lmsvcrt
	$(STRIP) $@
	$(PETOOL) dump $@

clean:
	$(RM) $(OUTPUT) cncnet-spawn.dll $(DLL_OBJS) $(EXE_OBJS) $(SPAWNER_OBJS) $(CNCNET_OBJS) $(STATS_OBJS) $(WWDEBUG_OBJS)
