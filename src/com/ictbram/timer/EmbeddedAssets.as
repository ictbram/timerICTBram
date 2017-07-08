package com.ictbram.timer {
	/**
	 * Timer ICTBram
	 * Copyright (C) 2017 Bram Joris - ictbram.com 
	 * 
	 * This program is free software: you can redistribute it and/or modify
	 * it under the terms of the GNU General Public License as published by
	 * the Free Software Foundation, either version 3 of the License, or
	 * (at your option) any later version.

	 * This program is distributed in the hope that it will be useful,
	 * but WITHOUT ANY WARRANTY; without even the implied warranty of
	 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	 * GNU General Public License for more details.

	 * You should have received a copy of the GNU General Public License
	 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
	 */
	public class EmbeddedAssets {
		
		// Texture
	     [Embed(source="../../../data/atlas.png")]
	     public static const atlas:Class;
	        
	     // XML
	     [Embed(source="../../../data/atlas.xml", mimeType="application/octet-stream")]
	     public static const myxml:Class;
		 
		 // Texture
	     [Embed(source="../../../data/atlasCirkeltjes.png")]
	     public static const atlasCirkeltjes:Class;
	        
	     // XML
	     [Embed(source="../../../data/atlasCirkeltjes.xml", mimeType="application/octet-stream")]
	     public static const myxmlCirkeltjes:Class;
	}
}