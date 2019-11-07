package com.giftiel.shop.controller.admin;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.stereotype.Controller;

/**
 * Handles requests for the application home page.
 */
@Controller
public class AdminController {

	/**
	 * String path의 src추출
	 *
	 * @param path
	 * @return
	 */
	public static String convertGetSrc(String path) {
		Pattern p = Pattern.compile("src=[\"']?([^>\"']+)[\"']");
		Matcher m = p.matcher(path);
		String t = "";
		while (m.find()) {
			//            System.out.println(m.group(1));
			t = m.group(1);
		}
		if (t.equals("")) {
			t = path;
		}
		return t;
	}
}