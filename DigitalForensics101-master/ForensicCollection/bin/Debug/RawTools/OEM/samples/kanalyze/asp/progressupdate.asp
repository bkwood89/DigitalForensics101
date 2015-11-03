<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    progressupdate.asp

Abstract:

    

Author:

    Akifumi Nagai(v-akinag) 19-NOV-1999

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
    Set AnalysisID=Request.QueryString("AnalysisID")
    Set ProgressTextID=Request.QueryString("ProgressTextID")
    Set ClassID=Request.QueryString("ClassID")
    Connecter.Open(DSN)
%>
    <a href="crashclass.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>">Return to CrashClass Table</a>
    <h1>ProgressText Update</h1>
<%
    Command="select AnalysisID,DateTime,Annotation,Author "
    Command=Command+"from ProgressText where ProgressTextID="+ProgressTextID
    Set Data=Connecter.Execute(Command)

    Command="select AnalysisID,Abstract from Analysis"
    Set AnalysisData=Connecter.Execute(Command)
%>
    <form action="progressupdateex.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&ProgressTextID=<% =ProgressTextID %>" method="post">
    <input type="hidden" name="ProgressTextID" value="<% =ProgressTextID %>">
    <table>
        <tr>
            <th>Column Name</th>
            <th>Value</th>
        </tr>
        <tr>
            <td>ProgressTextID</td>
            <td><% =ProgressTextID %></td>
        </tr>
        <tr>
            <td>AnalysisID</td>
            <td><select name="AnalysisID">
                <% Do While not AnalysisData.EOF %>
                    <option <% If AnalysisData("AnalysisID")=Data("AnalysisID") Then %>
                                selected
                            <% End If %>
                            value="<% =AnalysisData("AnalysisID") %>"><% =AnalysisData("AnalysisID") %> : <% =Left(AnalysisData("Abstract"),80) %>
                <% AnalysisData.MoveNext
                Loop %>
                </select>
            </td>
        </tr>
        <tr>
            <td>DateTime</td>
            <td><input type="text" name="DateTime" value="<% =Data("DateTime") %>" size="71"></td>
        </tr>
        <tr>
            <td>Annotation<br>(3800chr)</td>
            <td><textarea name="Annotation" rows="5" cols="50"><% =Data("Annotation") %></textarea></td>
        </tr>
        <tr>
            <td>Author<br>(75chr)</td>
            <td><textarea name="Author" rows="2" cols="50"><% =Data("Author") %></textarea></td>
        </tr>
    </table>
    <p>
    <input type="submit" value="Update">
<%
    AnalysisData.Close
    Data.Close
    Connecter.Close
%>
</body>
</html>
