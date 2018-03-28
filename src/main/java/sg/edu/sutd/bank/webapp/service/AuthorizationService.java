package sg.edu.sutd.bank.webapp.service;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public class AuthorizationService {

	public static void authenticatedWithRole(HttpServletRequest req, String role) throws IOException, ServletException {
		if (!req.isUserInRole(role)) {
			throw new ServletException("Unauthorized - you do not have authorization to perform this action.");
		}
	}

}
