<%--
  - $RCSfile$
  - $Revision: $
  - $Date: $
  -
  - Copyright (C) 2003-2008 Jive Software. All rights reserved.
  -
  - This software is published under the terms of the GNU Public License (GPL),
  - a copy of which is included in this distribution, or a commercial license
  - agreement with Jive.
--%>

<%@ page import="org.jivesoftware.webchat.ChatManager" %>
<%@ page import="org.jivesoftware.webchat.settings.ConnectionSettings" %>
<%@page import="org.jivesoftware.smack.tcp.XMPPTCPConnectionConfiguration"%>
<%@page import="org.jivesoftware.smack.tcp.XMPPTCPConnection"%>
<%@ page import="org.jivesoftware.smack.XMPPException" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.StringWriter" %>
<%@ page import="java.io.Writer" %>
<%@ page import="org.jivesoftware.smack.ConnectionConfiguration" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Test Server Connection</title></head>

<body>
<table width="600">
    <tr><td colspan="2"><h4>Server Connection Test</h4></td></tr>
    <tr valign="top"><td><b>Results:</b></td>

        <td>
            <%
                ConnectionSettings settings = ChatManager.getInstance().getChatSettingsManager().getSettings();
                boolean ok = false;
                XMPPTCPConnection con = null;
                try {
                 XMPPTCPConnectionConfiguration.Builder xmppConfig =  XMPPTCPConnectionConfiguration.builder()
                     .setSecurityMode(XMPPTCPConnectionConfiguration.SecurityMode.disabled)
                     .setXmppDomain(settings.getServerDomain())
                       .setHost(settings.getServerDomain())
                       .setPort(settings.getPort());
                 xmppConfig.performSaslAnonymousAuthentication();
                    con = new XMPPTCPConnection(xmppConfig.build());
                    con.connect();
                    con.login();
                    ok = true;
                }
                catch (XMPPException e) {
                    final Writer result = new StringWriter();
                    final PrintWriter printWriter = new PrintWriter(result);
                    e.printStackTrace(printWriter);
                    out.println("<p>" + result.toString() + "</p>");
                }
                finally {
                    if (con != null && con.isConnected()) {
                        con.disconnect();
                    }
                }
            %>
            <% if (ok) { %>
            Connected!
            <% } %>
        </td>
    </tr>
</table>


</body>
</html>
