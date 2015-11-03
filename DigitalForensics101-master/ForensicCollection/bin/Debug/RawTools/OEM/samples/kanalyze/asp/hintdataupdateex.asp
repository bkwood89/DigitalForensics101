<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    hintdataupdateex.asp

Abstract:

    

Author:

    Akifumi Nagai(v-akinag) 19-NOV-1999

Revision History:

-->
<%
    Set Connecter=Server.CreateObject("ADODB.Connection")
    Set DSN=Request.QueryString("DSN")
    Set DataID=Request.QueryString("DataID")
    Set ClassID=Request.QueryString("ClassID")
    Connecter.Open(DSN)

    Command="update HintData set "
    Command=Command+"SolutionID='"+Request.Form("SolutionID")+"',"
    Command=Command+"Data='"+Left(Replace( Request.Form("Data"), "'", "''"),2500)+"' "
    Command=Command+"where DataID="+DataID
    Set Data=Connecter.Execute(Command)

    Response.Redirect "hintdata.asp?DSN="+DSN+"&ClassID="+ClassID+"&DataID="+DataID+"&SolutionID="&Request.Form("SolutionID")
%>
