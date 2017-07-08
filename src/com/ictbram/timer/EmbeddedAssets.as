package com.ictbram.timer {
	/**
	 * @author Bram Joris - ictbram.com
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