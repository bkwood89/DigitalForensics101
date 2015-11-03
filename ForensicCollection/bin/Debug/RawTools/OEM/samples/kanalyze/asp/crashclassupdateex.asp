<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    crashclassupdateex.asp

Abstract:

    

Author:

    Akifumi Nagai(v-akinag) 18-NOV-1999

Revision History:

-->
<%
    Set Connecter=Server.CreateObject("ADODB.Connection")
    Set DSN=Request.QueryString("DSN")
    Set ClassID=Request.QueryString("ClassID")
    Connecter.Open(DSN)

    Command="update CrashClass set AnalysisID="+Request.Form("AnalysisID")
    Command=Command+",SolutionID="+Request.Form("SolutionID")
    Command=Command+" where ClassID="+ClassID
    Set Data=Connecter.Execute(Command)

    Response.Redirect "crashclass.asp?DSN="+DSN+"&ClassID="+ClassID
%>
