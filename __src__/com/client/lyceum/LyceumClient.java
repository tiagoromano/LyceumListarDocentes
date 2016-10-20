package com.client.lyceum;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.StringReader;
import java.io.StringWriter;
import java.io.Writer;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.json.JSONObject;
import org.json.XML;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import com.sun.org.apache.xml.internal.serialize.OutputFormat;
import com.sun.org.apache.xml.internal.serialize.XMLSerializer;

public class LyceumClient {

	public static JSONObject getResult(String wsUrl, String soapAction, String soapEnvelope) {

		String jsonPrettyPrintString = "";
		JSONObject xmlJSONObj = null;
		try {
			//Code to make a webservice HTTP request
			String responseString = "";
			String outputString = "";
			URL url = new URL(wsUrl);
			URLConnection connection = url.openConnection();
			HttpURLConnection httpConn = (HttpURLConnection) connection;
			ByteArrayOutputStream bout = new ByteArrayOutputStream();

			byte[] buffer = new byte[soapEnvelope.length()];
			buffer = soapEnvelope.getBytes();
			bout.write(buffer);
			byte[] b = bout.toByteArray();
			// Set the appropriate HTTP parameters.
			httpConn.setRequestProperty("Content-Length", String.valueOf(b.length));
			httpConn.setRequestProperty("Content-Type", "text/xml; charset=utf-8");
			httpConn.setRequestProperty("SOAPAction", soapAction);
			httpConn.setRequestMethod("POST");
			httpConn.setDoOutput(true);
			httpConn.setDoInput(true);
			OutputStream out = httpConn.getOutputStream();
			//Write the content of the request to the outputstream of the HTTP Connection.
			out.write(b);
			out.close();
			//Ready with sending the request.

			//Read the response.
			InputStreamReader isr = new InputStreamReader(httpConn.getInputStream());
			BufferedReader in = new BufferedReader(isr);

			//Write the SOAP message response to a String.
			while ((responseString = in.readLine()) != null) {
				outputString = outputString + responseString;
			}

			int PRETTY_PRINT_INDENT_FACTOR = 4;
			xmlJSONObj = XML.toJSONObject(outputString);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return xmlJSONObj;
	}


}
