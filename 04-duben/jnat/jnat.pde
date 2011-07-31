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


void setup(){
	JNative.setLoggingEnabled(true); // show what JNative is doing!
	try{
		int blah=org.xvolks.jnative.util.libeopenNURBS.ANT_Init((byte)0,(short)57600); // Call the first native function. This initializes the USB radio via the manufacturer's DLL.
		print(blah); // should return '1' upon success. This was easy so far!
	}catch (NativeException e) // traps in case anything naughty happens
	{
		e.printStackTrace();
	}
	catch (IllegalAccessException e)
	{
		e.printStackTrace();
	}



}


