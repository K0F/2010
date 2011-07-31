import com.google.api.translate.Language;
import com.google.api.translate.Translate;

void setup(){

	try{
      // Set the HTTP referrer to your website address.
          Translate.setHttpReferrer("http://processing.org");
          
              String translatedText = Translate.execute("ahoj tam", Language.CZECH, Language.ENGLISH);
              
                  System.out.println(translatedText);
                  
                  }catch(Exception e){
                  	println(e);
                  }
}
