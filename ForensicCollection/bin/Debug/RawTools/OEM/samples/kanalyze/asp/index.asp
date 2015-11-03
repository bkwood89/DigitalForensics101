<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    index.asp

Abstract:

    

Author:

    Akifumi Nagai(v-akinag) 19-NOV-1999

Revision History:

-->

<html>
<head>
<title>Kernel Memory Space Analyzer</title>
</head>
<body bgcolor="white">
    <a href="index.htm">Return to Main</a>
    <h1>Select ClassID</h1>

<%
    Set Connecter=Server.CreateObject("ADODB.Connection")
    Set DSN=Request.Form("DSN")

    If DSN="" Then
        DSN=Request.QueryString("DSN")
    End If

    If DSN="" Then
        DSN="KaKnownIssue"
    End If

    Connecter.Open(DSN)

    Command="select ClassID,StopCode,LastOccurrence from CrashClass"
    Set Data=Connecter.Execute(Command)

    If not Data.EOF Then
%>
    <p>
    <form action="crashclass.asp" method="post">
        <input type="hidden" name="DSN" value="<% =DSN %>">
        ClassID : <select name="ClassID">
                  <% Do While not Data.EOF %>
                      <option value="<% =Data("ClassID") %>"><% =Data("ClassID") %> : 0x<% =Data("StopCode") %> - <% =Left(Data("LastOccurrence"),80) %>
                  <% Data.MoveNext
                  Loop %>
                  </select>
        <input type="submit" value="Enter">
    </form>
<%
    Else
%>
    No data
<%
    End If
    Data.Close
    Connecter.Close
%>
</body>
</html>
