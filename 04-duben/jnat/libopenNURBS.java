import org.xvolks.test.bug.*;
import org.xvolks.jnative.util.ole.*;
import org.xvolks.jnative.util.windows.hooks.*;
import org.xvolks.jnative.pointers.*;
import org.xvolks.jnative.logging.*;
import org.xvolks.jnative.com.interfaces.*;
import org.xvolks.test.windows.trayicon.*;
import org.xvolks.jnative.util.mapi.*;
import org.xvolks.jnative.com.typebrowser.business.export.*;
import org.xvolks.jnative.misc.*;
import org.xvolks.jnative.util.mapi.structs.*;
import org.xvolks.jnative.misc.basicStructures.*;
import org.xvolks.test.com.*;
import org.xvolks.jnative.util.windows.hotkey.*;
import org.xvolks.jnative.pointers.memory.*;
import org.xvolks.jnative.misc.registry.*;
import org.xvolks.test.windows.*;
import org.xvolks.jnative.exceptions.*;
import org.xvolks.jnative.com.typebrowser.gui.*;
import org.xvolks.jnative.com.utils.*;
import org.xvolks.jnative.util.windows.*;
import org.xvolks.jnative.util.constants.winuser.*;
import org.xvolks.test.callbacks.*;
import org.xvolks.jnative.com.typebrowser.gui.panels.*;
import org.xvolks.jnative.*;
import org.xvolks.jnative.util.win32session.*;
import org.xvolks.test.callbacks.linux.*;
import org.xvolks.jnative.util.constants.*;
import org.xvolks.jnative.com.typebrowser.business.*;
import org.xvolks.test.*;
import org.xvolks.jnative.misc.machine.*;
import org.xvolks.jnative.util.*;
import org.xvolks.jnative.util.windows.structures.*;
import org.xvolks.jnative.com.*;
import processing.core.*;

package org.xvolks.jnative.util;

public class libopenNURBS extends PApplet{

	public static final String DLL_NAME = "libopenNURBS.so";

	//Cache the JNative object between calls.
	private static JNative nANT_Init;  // Native-side function names
	private static JNative nANT_AssignResponseFunction; //one for each DLL function you will use...

	// The actual DLL export, most likely from API documentation / header file:
	// __declspec(dllexport) BOOL ANT_Init(UCHAR ucUSBDeviceNum, USHORT usBaudrate);

	// Java-side function name
	public static int ANT_Init(byte ucUSBDeviceNum, short usBaudrate) throws NativeException, IllegalAccessException
	{
		if(nANT_Init == null)
		{
			nANT_Init = new JNative(DLL_NAME, "_ANT_Init");  // The actual "decorated" name in the DLL
			//BOOL is in fact an INT
			nANT_Init.setRetVal(Type.INT);  // tell JNative's DLL what kind of return data to expect
		}

		nANT_Init.setParameter(0, ucUSBDeviceNum); // tell JNative's DLL what data to pass to the native function, in what order.
		nANT_Init.setParameter(1, usBaudrate);    // ...
		nANT_Init.invoke();  // Finally, execute the native function

		return nANT_Init.getRetValAsInt(); // get native call's return value
	}

}





