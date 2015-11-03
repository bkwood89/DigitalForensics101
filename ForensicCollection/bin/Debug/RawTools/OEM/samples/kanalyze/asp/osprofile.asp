<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    osprofile.asp

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
    Set OSProfileRecID=Request.QueryString("OSProfileRecID")
    Set ClassID=Request.QueryString("ClassID")
    Set InstanceID=Request.QueryString("InstanceID")
    Connecter.Open(DSN)
%>
    <a href="crashinstance.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&InstanceID=<% =InstanceID %>">Return to CrashInstance Table</a>
    <h1>OSProfile</h1>
<%
    Command="select OSProfileRecID,OSCheckedBuild,OSSMPKernel,OSPAEKernel,"
    Command=Command+"OSBuild,OSServicePackLevel,ProductType,QfeData,OccurrenceCount "
    Command=Command+"from OSProfile where OSProfileRecID="+OSProfileRecID
    Set Data=Connecter.Execute(Command)
%>
    <table>
        <tr>
            <th>Column Name</th>
            <th>Value</th>
        </tr>
        <tr>
            <td>OSProfileRecID</td>
            <td><% =OSProfileRecID %></td>
        </tr>
        <tr>
            <td>OSCheckedBuild</td>
            <td><% =Data("OSCheckedBuild") %></td>
        </tr>
        <tr>
            <td>OSSMPKernel</td>
            <td><% =Data("OSSMPKernel") %></td>
        </tr>
        <tr>
            <td>OSPAEKernel</td>
            <td><% =Data("OSPAEKernel") %></td>
        </tr>
        <tr>
            <td>OSBuild</td>
            <td><% =Data("OSBuild") %></td>
        </tr>
        <tr>
            <td>OSServicePackLevel</td>
            <td><% If IsNull(Data("OSServicePackLevel")) or IsEmpty(Data("OSServicePackLevel")) Then
                       Response.Write "[no data]"
                   Else
                       Response.Write Data("OSServicePackLevel")
                   End If 
                %></td>
        </tr>
        <tr>
            <td>ProductType</td>
            <td><% =Data("ProductType") %></td>
        </tr>
        <tr>
            <td>QfeData</td>
            <td><% If IsNull(Data("QfeData")) or IsEmpty(Data("QfeData")) Then
                       Response.Write "[no data]"
                   Else
                       Response.Write Data("QfeData")
                   End If 
                %></td>
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
