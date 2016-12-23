/*
 * arch/ubicom32/mach-common/vdc_tio_at070tn93.h
 *   Initialization for Innolux AT070TN93
 *
 * (C) Copyright 2009, Ubicom, Inc.
 *
 * This file is part of the Ubicom32 Linux Kernel Port.
 *
 * The Ubicom32 Linux Kernel Port is free software: you can redistribute
 * it and/or modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation, either version 2 of the
 * License, or (at your option) any later version.
 *
 * The Ubicom32 Linux Kernel Port is distributed in the hope that it
 * will be useful, but WITHOUT ANY WARRANTY; without even the implied
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
 * the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with the Ubicom32 Linux Kernel Port.  If not,
 * see <http://www.gnu.org/licenses/>.
 */

#ifndef __VDC_TIO_AT070TN93_H__
#define __VDC_TIO_AT070TN93_H__

#if defined(CONFIG_VDC_LCD_INNOLUX_AT070TN93)
#define VDC_TIO_LCD_PLATFORM_DATA "Innolux AT070TN93"
static struct ubicom32fb_platform_data vdc_tio_ubicom32fb_platform_data __initdata = {
	.flags		= UBICOM32FB_PLATFORM_DATA_FLAG_MODE | UBICOM32FB_PLATFORM_DATA_FLAG_TIMING | UBICOM32FB_PLATFORM_DATA_FLAG_DIM |
			  UBICOM32FB_PLATFORM_DATA_FLAG_SHIFT |
			  UBICOM32FB_PLATFORM_DATA_FLAG_RESOLUTION,

	.rshift		= 11,
	.gshift		= 5,
	.bshift		= 0,
	.rbits		= 5,
	.gbits		= 6,
	.bbits		= 5,

	.mode		= UBICOM32FB_MODE_SYNC,

	.hfp = 210,
	.hsync = 6,
	.hbp = 40,
	.vfp = 22,
	.vsync = 3,
	.vbp = 20,
	.fclk = 33333333,

	.xres = 800,
	.yres = 480,

	.width_mm = 154,
	.height_mm = 85,
};
#endif

#endif
