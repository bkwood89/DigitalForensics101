<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    progressinsert.asp

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
    Set ClassID=Request.QueryString("ClassID")
    Connecter.Open(DSN)

    Command="select AnalysisID from Analysis where AnalysisID="&AnalysisID
    Set Data=Connecter.Execute(Command)

    Command="select AnalysisID,Abstract from Analysis"
    Set AnalysisData=Connecter.Execute(Command)
%>
    <a href="crashclass.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>">Return to CrashClass Table</a>
    <h1>ProgressText Add</h1>
    <form action="progressinsertex.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&AnalysisID=<% =AnalysisID %>" method="post">
    <table>
        <tr>
            <th>Column Name</th>
            <th>Value</th>
        </tr>
        <tr>
            <td>ProgressTextID</td>
            <td>-</td>
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
                <td><input type="text" name="DateTime" value="<% =Now %>" size="71"></td>
<!--            <td><input type="text" name="DateTime" value="<% =(DatePart("yyyy", Now)&"-"&DatePart("m", Now)&"-"&DatePart("d", Now)&" "&DatePart("h", Now)&":"&DatePart("n", Now)&":"&DatePart("s", Now)) %>.000"></td> -->
        </tr>
        <tr>
            <td>Annotation<br>(3800chr)</td>
            <td><textarea name="Annotation" rows="10" cols="50">[not null]</textarea></td>
        </tr>
        <tr>
            <td>Author<br>(75chr)</td>
            <td><textarea name="Author" rows="2" cols="50"></textarea></td>
        </tr>
    </table>
    <p>
    <input type="submit" value="New">
</body>
</html>
