<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    hwprofile.asp

Abstract:

    

Author:

    Akifumi Nagai(v-akinag) 18-NOV-1999

Revision History:

-->

<html>
<head>
<title>Kernel Memory Space Analyzer</title>
</head>
<body bgcolor=white>
<%
    Set Connecter=Server.CreateObject("ADODB.Connection")
    Set DSN=Request.QueryString("DSN")
    Set HWProfileRecID=Request.QueryString("HWProfileRecID")
    Set ClassID=Request.QueryString("ClassID")
    Set InstanceID=Request.QueryString("InstanceID")
    Connecter.Open(DSN)
%>
    <a href="crashinstance.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&InstanceID=<% =InstanceID %>">Return to CrashInstance Table</a>
    <h1>HWProfile</h1>
<%
    Command="select HWProfileRecID,Architecture,ProcessorType,ProcessorSpec,"
    Command=Command+"ProcessorVendor,ProcessorCount,OccurrenceCount "
    Command=Command+"from HWProfile where HWProfileRecID="+HWProfileRecID
    Set Data=Connecter.Execute(Command)
%>
    <table>
        <tr>
            <th>Column Name</th>
            <th>Value</th>
        </tr>
        <tr>
            <td>HWProfileRecID</td>
            <td><% =HWProfileRecID %></td>
        </tr>
        <tr>
            <td>Architecture</td>
            <td><% =Data("Architecture") %></td>
        </tr>
        <tr>
            <td>ProcessorType</td>
            <td><% =Data("ProcessorType") %></td>
        </tr>
        <tr>
            <td>ProcessorSpec</td>
            <td><% =Data("ProcessorSpec") %></td>
        </tr>
        <tr>
            <td>ProcessorVendor</td>
            <td><% =Data("ProcessorVendor") %></td>
        </tr>
        <tr>
            <td>ProcessorCount</td>
            <td><% =Data("ProcessorCount") %></td>
        </tr>
        <tr>
            <td>OccurrenceCount</td>
            <td><% =Data("OccurrenceCount") %></td>
        </tr>
    </table>
<% 
    Data.Close
    Connecter.Close
%>
</body>
</html>
