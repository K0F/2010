import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.w3c.dom.Document;

import com.google.code.facebookapi.FacebookWebappHelper;
import com.google.code.facebookapi.FacebookXmlRestClient;
import com.google.code.facebookapi.IFacebookRestClient;


    Log LOG = LogFactory.getLog(FacebookInterceptor.class);

String FACEBOOK_USER_CLIENT = "facebook.user.client";
String fbApiKey;
 String fbSecret;

 
 boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(true);
        IFacebookRestClient<Document> userClient = FacebookInterceptor.getUserClient(request, fbApiKey, fbSecret);

        FacebookWebappHelper<Document> facebook = new FacebookWebappHelper<Document>(request, response, fbApiKey,
                fbSecret, userClient);
        String nextPage = request.getRequestURI();
        nextPage = nextPage.substring(nextPage.indexOf("/", 1) + 1);
        LOG.debug("NEXT PAGE : " + nextPage);
      
	boolean redirectOccurred = facebook.requireLogin(nextPage);
       
	
	
	if (redirectOccurred) {
            LOG.debug("REDIRECT OCCURRED ");
            return false;
        }

        return true;
    }

    public static FacebookXmlRestClient getUserClient(HttpServletRequest request, String fbApiKey, String fbSecret) {
        LOG.debug("Obtaining user session.");
        HttpSession session = request.getSession(true);
        IFacebookRestClient<Document> userClient = (FacebookXmlRestClient) session.getAttribute(FACEBOOK_USER_CLIENT);
        if (userClient == null) {
            LOG.debug("Creating user session");
            userClient = new FacebookXmlRestClient(fbApiKey, fbSecret);
            session.setAttribute(FACEBOOK_USER_CLIENT, userClient);
        }

        return (FacebookXmlRestClient) userClient;
    }

    public void setFbApiKey(String fbApiKey) {
        this.fbApiKey = fbApiKey;
    }

    public void setFbSecret(String fbSecret) {
        this.fbSecret = fbSecret;
    }
}