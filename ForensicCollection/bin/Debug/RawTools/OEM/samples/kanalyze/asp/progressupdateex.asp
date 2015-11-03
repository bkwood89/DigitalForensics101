<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    progressupdateex.asp

Abstract:

    

Author:

    Akifumi Nagai(v-akinag) 19-NOV-1999

Revision History:

-->
<%
    Set Connecter=Server.CreateObject("ADODB.Connection")
    Set DSN=Request.QueryString("DSN")
    Set ProgressTextID=Request.QueryString("ProgressTextID")
    Set ClassID=Request.QueryString("ClassID")
    Connecter.Open(DSN)

    Command="update ProgressText set "
    Command=Command+"AnalysisID='"+Request.Form("AnalysisID")+"',"
    Command=Command+"DateTime='"+Request.Form("DateTime")+"',"
    Command=Command+"Annotation='"+Left(Replace( Request.Form("Annotation"), "'", "''"),3800)+"',"
    Command=Command+"Author='"+Left(Replace( Request.Form("Author"), "'", "''"),75)+"' "
    Command=Command+"where ProgressTextID="+ProgressTextID
    Set Data=Connecter.Execute(Command)

    Response.Redirect"progress.asp?DSN="+DSN+"&ClassID="+ClassID+"&ProgressTextID="+ProgressTextID+"&AnalysisID="&Request.Form("AnalysisID")
%>
